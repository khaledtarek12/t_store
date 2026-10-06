/// Supabase connection settings.
///
/// The publishable key is a public, client-side key: it carries no privileges
/// on its own and every request it makes is still checked by the Storage RLS
/// policies in `supabase/storage_policies.sql`. The service key is the secret
/// one and must never appear in this app.
///
/// Each value can still be overridden at build time, which is how you point a
/// build at a staging project:
///
/// ```
/// flutter run --dart-define=SUPABASE_URL=https://OTHER_REF.supabase.co
/// ```
class TSupabase {
  TSupabase._();

  static const String projectRef = 'xanjcjplxnvhwhaolxrn';

  static const String url = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://$projectRef.supabase.co',
  );

  static const String publishableKey = String.fromEnvironment(
    'SUPABASE_PUBLISHABLE_KEY',
    defaultValue: 'sb_publishable_m_LLgoJ9PgHWlZZBKQckaw_Ur2Oetic',
  );

  /// Name of the Storage bucket that holds every app image.
  static const String imagesBucket =
      String.fromEnvironment('SUPABASE_IMAGES_BUCKET', defaultValue: 'images');

  static bool get isConfigured => url.isNotEmpty && publishableKey.isNotEmpty;

  /// Folder that holds per-user uploads. Storage policies only allow a user to
  /// write inside `profileFolder/` followed by their own Firebase uid.
  static const String profileFolder = 'Users';
}
