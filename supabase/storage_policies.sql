-- ============================================================================
--  Supabase Storage + Firebase Auth
-- ============================================================================
--  Run this in the Supabase dashboard: SQL Editor > New query.
--  Safe to re-run: every statement is idempotent.
--
--  Ready to run as-is for:
--    Supabase project ref   xanjcjplxnvhwhaolxrn
--    Firebase project id    ecommerceapp-eac38
--
--  Prerequisite: Authentication > Third-Party Auth > Add provider > Firebase,
--  with the Firebase project id  ecommerceapp-eac38.
--
--  No Cloud Function is required. Authorisation is decided from the verified
--  claims of the Firebase ID token, not from the Postgres role, so it works
--  whether or not the token carries  role: "authenticated".
--
--  Remember to run section 6 to make yourself an admin.
-- ============================================================================


-- ----------------------------------------------------------------------------
-- 1. Bucket
-- ----------------------------------------------------------------------------
-- Public = images are readable over the CDN without a token, which is what
-- makes CachedNetworkImage work with plain URLs stored in Firestore.
insert into storage.buckets (id, name, public)
values ('images', 'images', true)
on conflict (id) do nothing;


-- ----------------------------------------------------------------------------
-- 2. Identify the caller
-- ----------------------------------------------------------------------------
-- Returns the Firebase uid, but only for tokens minted by OUR Firebase
-- project. Firebase signs every project's tokens with the same keys, so the
-- issuer and audience have to be checked explicitly: without this, a token
-- from any unrelated Firebase project would be accepted here.
--
-- auth.uid() is deliberately not used: Firebase uids are not UUIDs.
create or replace function public.firebase_uid()
returns text
language sql
stable
as $$
  select case
    when (auth.jwt() ->> 'iss') = 'https://securetoken.google.com/ecommerceapp-eac38'
     and (auth.jwt() ->> 'aud') = 'ecommerceapp-eac38'
    then auth.jwt() ->> 'sub'
  end;
$$;


-- ----------------------------------------------------------------------------
-- 3. Admin list
-- ----------------------------------------------------------------------------
-- Holds the Firebase uids allowed to write the catalog folders. RLS is on with
-- no policies, so the table is invisible to the app; only the SQL editor and
-- the service key can touch it.
create table if not exists public.app_admins (
  uid text primary key,
  note text,
  created_at timestamptz not null default now()
);

alter table public.app_admins enable row level security;

create or replace function public.is_app_admin()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1 from public.app_admins a where a.uid = public.firebase_uid()
  );
$$;


-- ----------------------------------------------------------------------------
-- 4. Read access
-- ----------------------------------------------------------------------------
drop policy if exists "trusted issuers only" on storage.objects;
drop policy if exists "public read images" on storage.objects;

create policy "public read images"
on storage.objects
for select
to public
using (bucket_id = 'images');


-- ----------------------------------------------------------------------------
-- 5. A user may only write inside Users/<their firebase uid>/
-- ----------------------------------------------------------------------------
drop policy if exists "own profile folder insert" on storage.objects;
drop policy if exists "own profile folder update" on storage.objects;
drop policy if exists "own profile folder delete" on storage.objects;

create policy "own profile folder insert"
on storage.objects
for insert
to public
with check (
  bucket_id = 'images'
  and (storage.foldername(name))[1] = 'Users'
  and (storage.foldername(name))[2] = (select public.firebase_uid())
);

create policy "own profile folder update"
on storage.objects
for update
to public
using (
  bucket_id = 'images'
  and (storage.foldername(name))[1] = 'Users'
  and (storage.foldername(name))[2] = (select public.firebase_uid())
)
with check (
  bucket_id = 'images'
  and (storage.foldername(name))[1] = 'Users'
  and (storage.foldername(name))[2] = (select public.firebase_uid())
);

create policy "own profile folder delete"
on storage.objects
for delete
to public
using (
  bucket_id = 'images'
  and (storage.foldername(name))[1] = 'Users'
  and (storage.foldername(name))[2] = (select public.firebase_uid())
);


-- ----------------------------------------------------------------------------
-- 6. Catalog folders are admin-only
-- ----------------------------------------------------------------------------
-- Written by the in-app "Upload Data" screen. Without this, any signed-in
-- customer could overwrite your product images.
drop policy if exists "admins write catalog" on storage.objects;

create policy "admins write catalog"
on storage.objects
for all
to public
using (
  bucket_id = 'images'
  and (storage.foldername(name))[1] in ('Products', 'Categories', 'Brands', 'Banners')
  and (select public.is_app_admin())
)
with check (
  bucket_id = 'images'
  and (storage.foldername(name))[1] in ('Products', 'Categories', 'Brands', 'Banners')
  and (select public.is_app_admin())
);


-- >>> REQUIRED: put your own Firebase uid here, then run this line. <<<
-- Find it in Firebase console > Authentication > Users > "User UID".
insert into public.app_admins (uid, note)
values ('PASTE_YOUR_FIREBASE_UID_HERE', 'owner')
on conflict (uid) do nothing;


-- ----------------------------------------------------------------------------
-- 7. Troubleshooting
-- ----------------------------------------------------------------------------
-- Run this from the app's session to see what Supabase thinks of your token.
-- From the SQL editor it returns nulls, which is expected.
--   select auth.jwt() ->> 'iss'  as issuer,
--          auth.jwt() ->> 'aud'  as audience,
--          auth.jwt() ->> 'sub'  as firebase_uid,
--          auth.jwt() ->> 'role' as role_claim,
--          public.firebase_uid() as resolved_uid,
--          public.is_app_admin() as is_admin;
