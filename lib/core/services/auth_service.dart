import 'package:supabase_flutter/supabase_flutter.dart';
import '../../config/supabase_config.dart';
import '../../config/app_constants.dart';

class AuthService {
  static final SupabaseClient _client = SupabaseConfig.client;
  
  // Sign Up
  static Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': fullName,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
  
  // Sign In
  static Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
  
  // Sign Out
  static Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } catch (e) {
      rethrow;
    }
  }
  
  // Reset Password
  static Future<void> resetPassword({required String email}) async {
    try {
      await _client.auth.resetPasswordForEmail(email);
    } catch (e) {
      rethrow;
    }
  }
  
  // Get Current User
  static User? getCurrentUser() {
    return _client.auth.currentUser;
  }
  
  // Check if user is signed in
  static bool isSignedIn() {
    return getCurrentUser() != null;
  }
  
  // Get auth state stream
  static Stream<AuthState> get authStateStream {
    return _client.auth.onAuthStateChange;
  }
  
  // Update user profile
  static Future<UserResponse> updateProfile({
    String? fullName,
    String? phone,
  }) async {
    try {
      final updates = <String, dynamic>{};
      if (fullName != null) updates['full_name'] = fullName;
      if (phone != null) updates['phone'] = phone;
      
      final response = await _client.auth.updateUser(
        UserAttributes(data: updates),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
  
  // Change password
  static Future<UserResponse> changePassword({
    required String newPassword,
  }) async {
    try {
      final response = await _client.auth.updateUser(
        UserAttributes(password: newPassword),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
  
  // Verify email
  static Future<void> resendEmailConfirmation({required String email}) async {
    try {
      await _client.auth.resend(
        type: OtpType.signup,
        email: email,
      );
    } catch (e) {
      rethrow;
    }
  }
}

