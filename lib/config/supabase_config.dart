import 'package:supabase_flutter/supabase_flutter.dart';
import 'app_constants.dart';

class SupabaseConfig {
  static late Supabase _instance;
  
  static SupabaseClient get client => _instance.client;
  
  static Future<void> initialize() async {
    _instance = await Supabase.initialize(
      url: AppConstants.supabaseUrl,
      anonKey: AppConstants.supabaseAnonKey,
      debug: false, // Set to true for development
    );
  }
  
  // Auth helpers
  static User? get currentUser => client.auth.currentUser;
  static bool get isSignedIn => currentUser != null;
  static String? get currentUserId => currentUser?.id;
  
  // Database helpers
  static SupabaseQueryBuilder from(String table) => client.from(table);
  
  // Storage helpers
  static SupabaseStorageClient get storage => client.storage;
}

