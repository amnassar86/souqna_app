class AppConstants {
  // App Information
  static const String appName = 'سوقنا';
  static const String appVersion = '1.0.0';
  
  // API Configuration
  static const String supabaseUrl = 'YOUR_SUPABASE_URL';
  static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
  
  // Validation Constants
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 128;
  static const int minNameLength = 2;
  static const int maxNameLength = 50;
  
  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double borderRadius = 12.0;
  static const double buttonHeight = 56.0;
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
  
  // Routes
  static const String signInRoute = '/sign-in';
  static const String signUpRoute = '/sign-up';
  static const String forgotPasswordRoute = '/forgot-password';
  static const String homeRoute = '/home';
  static const String splashRoute = '/';
  
  // Error Messages
  static const String networkError = 'خطأ في الاتصال بالشبكة';
  static const String unknownError = 'حدث خطأ غير متوقع';
  static const String invalidCredentials = 'بيانات الدخول غير صحيحة';
  static const String emailAlreadyExists = 'البريد الإلكتروني مستخدم بالفعل';
  
  // Success Messages
  static const String signUpSuccess = 'تم إنشاء الحساب بنجاح';
  static const String signInSuccess = 'تم تسجيل الدخول بنجاح';
  static const String passwordResetSent = 'تم إرسال رابط إعادة تعيين كلمة المرور';
}

