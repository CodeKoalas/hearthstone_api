// Get the dart-define environment option.
const kEnvironment = String.fromEnvironment('ENVIRONMENT', defaultValue: 'development');
const kSupabaseUrl = String.fromEnvironment('SUPABASE_URL', defaultValue: 'https://<your-supabase-url>.supabase.co');
const kSupabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY', defaultValue: '<your-supabase-anon-key>');
