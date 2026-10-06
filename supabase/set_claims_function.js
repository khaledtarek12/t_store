/**
 * OPTIONAL. The Storage policies in storage_policies.sql authorise requests
 * from the verified claims of the Firebase ID token, so nothing here is needed
 * for image uploads to work, and deploying Cloud Functions requires the
 * Firebase Blaze plan.
 *
 * It is still worth deploying later if you add regular Postgres tables and
 * want to use Supabase's normal `to authenticated` policies, which depend on
 * the token carrying a `role: "authenticated"` claim.
 *
 * Deploy:
 *   cd functions && npm i firebase-admin firebase-functions
 *   firebase deploy --only functions
 */

const { onUserCreated } = require("firebase-functions/v2/identity");
const { onCall, HttpsError } = require("firebase-functions/v2/https");
const admin = require("firebase-admin");

admin.initializeApp();

/** Runs for every newly created account. */
exports.setAuthenticatedRole = onUserCreated(async(event) => {
    await admin.auth().setCustomUserClaims(event.data.uid, {
        role: "authenticated",
    });
});

/**
 * One-off backfill for accounts that already existed before the function was
 * deployed. Call it once from a trusted context, then delete it.
 */
exports.backfillAuthenticatedRole = onCall(async(request) => {
    if (!request.auth) throw new HttpsError("unauthenticated", "Sign in first.");

    let pageToken;
    let updated = 0;
    do {
        const page = await admin.auth().listUsers(1000, pageToken);
        for (const user of page.users) {
            if (user.customClaims.role !== "authenticated") {
                await admin.auth().setCustomUserClaims(user.uid, {
                    ...user.customClaims,
                    role: "authenticated",
                });
                updated++;
            }
        }
        pageToken = page.pageToken;
    } while (pageToken);

    return { updated };
});

/**
 * Grants yourself admin rights so the in-app "Upload Data" screen can write to
 * the catalog folders. Run once with the Admin SDK (or a local script), then
 * sign out and back in so the new token carries the claim.
 *
 *   admin.auth().getUserByEmail("you@example.com").then((u) =>
 *     admin.auth().setCustomUserClaims(u.uid, {
 *       role: "authenticated",
 *       admin: true,
 *     }));
 */