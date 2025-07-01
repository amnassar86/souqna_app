# التوثيق التقني - تطبيق سوقنا

## 📋 جدول المحتويات

1. [نظرة عامة على البنية](#نظرة-عامة-على-البنية)
2. [إدارة الحالة](#إدارة-الحالة)
3. [نظام التوجيه](#نظام-التوجيه)
4. [خدمات المصادقة](#خدمات-المصادقة)
5. [التحقق من البيانات](#التحقق-من-البيانات)
6. [إدارة الثيمات](#إدارة-الثيمات)
7. [المكونات المخصصة](#المكونات-المخصصة)
8. [قاعدة البيانات](#قاعدة-البيانات)
9. [معالجة الأخطاء](#معالجة-الأخطاء)
10. [الأمان والحماية](#الأمان-والحماية)

## 🏗️ نظرة عامة على البنية

### البنية المعمارية

يتبع تطبيق سوقنا نمط **Clean Architecture** مع تقسيم الكود إلى طبقات منفصلة:

```
┌─────────────────────────────────────┐
│           Presentation Layer        │
│         (UI + State Management)     │
├─────────────────────────────────────┤
│            Domain Layer             │
│        (Business Logic)             │
├─────────────────────────────────────┤
│             Data Layer              │
│    (Repositories + Data Sources)    │
└─────────────────────────────────────┘
```

### تنظيم المجلدات

```
lib/
├── main.dart                    # نقطة الدخول
├── config/                      # إعدادات التطبيق
├── core/                        # الوظائف الأساسية
│   ├── services/               # الخدمات العامة
│   └── utils/                  # الأدوات المساعدة
├── data/                       # طبقة البيانات
│   ├── models/                 # نماذج البيانات
│   └── repositories/           # مستودعات البيانات
├── features/                   # الميزات حسب المجال
│   └── authentication/         # ميزة المصادقة
│       ├── data/              # بيانات خاصة بالميزة
│       └── presentation/       # واجهة المستخدم
│           ├── screens/        # الشاشات
│           └── widgets/        # المكونات
├── shared/                     # المكونات المشتركة
│   ├── widgets/               # مكونات UI
│   ├── styles/                # الأنماط
│   └── themes/                # الثيمات
└── routes/                     # نظام التوجيه
```

## 🔄 إدارة الحالة

### استراتيجية إدارة الحالة

يستخدم التطبيق **Provider** لإدارة الحالة مع التركيز على:

1. **البساطة**: سهولة الفهم والصيانة
2. **الأداء**: تحديثات محدودة النطاق
3. **القابلية للاختبار**: فصل المنطق عن الواجهة

### مثال على Provider للمصادقة

```dart
class AuthProvider extends ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _currentUser != null;

  // Methods
  Future<void> signIn(String email, String password) async {
    _setLoading(true);
    try {
      final response = await AuthService.signIn(
        email: email,
        password: password,
      );
      _currentUser = response.user;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
```

## 🧭 نظام التوجيه

### Go Router Configuration

```dart
final GoRouter router = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    final isSignedIn = AuthService.isSignedIn();
    final isAuthRoute = authRoutes.contains(state.matchedLocation);
    
    if (isSignedIn && isAuthRoute) {
      return '/home';
    }
    
    if (!isSignedIn && !isAuthRoute) {
      return '/sign-in';
    }
    
    return null;
  },
  routes: [
    // تعريف المسارات
  ],
);
```

### حماية المسارات

```dart
class RouteGuard {
  static String? authGuard(BuildContext context, GoRouterState state) {
    if (!AuthService.isSignedIn()) {
      return '/sign-in';
    }
    return null;
  }
  
  static String? guestGuard(BuildContext context, GoRouterState state) {
    if (AuthService.isSignedIn()) {
      return '/home';
    }
    return null;
  }
}
```

## 🔐 خدمات المصادقة

### AuthService Architecture

```dart
class AuthService {
  static final SupabaseClient _client = SupabaseConfig.client;
  
  // Core authentication methods
  static Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      return await _client.auth.signUp(
        email: email,
        password: password,
        data: {'full_name': fullName},
      );
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      throw Exception('Unexpected error occurred');
    }
  }
  
  // Session management
  static Stream<AuthState> get authStateStream {
    return _client.auth.onAuthStateChange;
  }
}
```

### معالجة حالات المصادقة

```dart
class AuthStateHandler {
  static void handleAuthStateChange(AuthState state) {
    switch (state.event) {
      case AuthChangeEvent.signedIn:
        _handleSignedIn(state.session?.user);
        break;
      case AuthChangeEvent.signedOut:
        _handleSignedOut();
        break;
      case AuthChangeEvent.tokenRefreshed:
        _handleTokenRefresh(state.session);
        break;
    }
  }
  
  static void _handleSignedIn(User? user) {
    // تحديث حالة التطبيق
    // توجيه المستخدم للصفحة الرئيسية
  }
}
```

## ✅ التحقق من البيانات

### نظام التحقق المتقدم

```dart
class Validators {
  // Email validation with Arabic support
  static String? validateEmail(String? value) {
    if (value?.isEmpty ?? true) {
      return 'البريد الإلكتروني مطلوب';
    }
    
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    );
    
    if (!emailRegex.hasMatch(value!)) {
      return 'يرجى إدخال بريد إلكتروني صحيح';
    }
    
    return null;
  }
  
  // Password strength validation
  static String? validatePassword(String? value) {
    if (value?.isEmpty ?? true) {
      return 'كلمة المرور مطلوبة';
    }
    
    final password = value!;
    final validations = [
      _PasswordValidation(
        test: password.length >= 8,
        message: 'يجب أن تكون 8 أحرف على الأقل',
      ),
      _PasswordValidation(
        test: RegExp(r'[A-Z]').hasMatch(password),
        message: 'يجب أن تحتوي على حرف كبير',
      ),
      _PasswordValidation(
        test: RegExp(r'[a-z]').hasMatch(password),
        message: 'يجب أن تحتوي على حرف صغير',
      ),
      _PasswordValidation(
        test: RegExp(r'[0-9]').hasMatch(password),
        message: 'يجب أن تحتوي على رقم',
      ),
    ];
    
    final failedValidation = validations
        .firstWhere((v) => !v.test, orElse: () => null);
    
    return failedValidation?.message;
  }
}

class _PasswordValidation {
  final bool test;
  final String message;
  
  _PasswordValidation({required this.test, required this.message});
}
```

### التحقق في الوقت الفعلي

```dart
class RealTimeValidator extends StatefulWidget {
  final String Function(String) validator;
  final Function(bool) onValidationChanged;
  
  @override
  _RealTimeValidatorState createState() => _RealTimeValidatorState();
}

class _RealTimeValidatorState extends State<RealTimeValidator> {
  Timer? _debounceTimer;
  
  void _onTextChanged(String text) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(Duration(milliseconds: 500), () {
      final error = widget.validator(text);
      widget.onValidationChanged(error == null);
    });
  }
}
```

## 🎨 إدارة الثيمات

### نظام الثيمات المتقدم

```dart
class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _lightColorScheme,
      textTheme: _textTheme,
      inputDecorationTheme: _inputDecorationTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      // المزيد من إعدادات الثيم
    );
  }
  
  static ColorScheme get _lightColorScheme {
    return ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    );
  }
  
  static TextTheme get _textTheme {
    return GoogleFonts.cairoTextTheme().copyWith(
      displayLarge: GoogleFonts.cairo(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
      // المزيد من أنماط النصوص
    );
  }
}
```

### إدارة الألوان الديناميكية

```dart
class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF2E7D32);
  static const Color primaryVariant = Color(0xFF1B5E20);
  
  // Semantic colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);
  
  // Context-aware colors
  static Color get surfaceColor {
    return Theme.of(context).colorScheme.surface;
  }
  
  static Color get onSurfaceColor {
    return Theme.of(context).colorScheme.onSurface;
  }
}
```

## 🧩 المكونات المخصصة

### CustomTextField Component

```dart
class CustomTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final bool enabled;
  
  const CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.enabled = true,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscured = false;
  bool _isFocused = false;
  
  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(),
        SizedBox(height: 8),
        _buildTextField(),
      ],
    );
  }
  
  Widget _buildTextField() {
    return Focus(
      onFocusChange: (focused) {
        setState(() => _isFocused = focused);
      },
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        obscureText: _isObscured,
        keyboardType: widget.keyboardType,
        enabled: widget.enabled,
        onChanged: widget.onChanged,
        decoration: _buildInputDecoration(),
      ),
    );
  }
  
  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      hintText: widget.label,
      prefixIcon: widget.prefixIcon,
      suffixIcon: _buildSuffixIcon(),
      border: _buildBorder(),
      focusedBorder: _buildFocusedBorder(),
      errorBorder: _buildErrorBorder(),
      // المزيد من إعدادات التصميم
    );
  }
}
```

### CustomButton Component

```dart
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final bool isLoading;
  final Widget? icon;
  final EdgeInsetsGeometry? padding;
  
  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.type = ButtonType.primary,
    this.isLoading = false,
    this.icon,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      child: _buildButton(context),
    );
  }
  
  Widget _buildButton(BuildContext context) {
    switch (type) {
      case ButtonType.primary:
        return _buildElevatedButton(context);
      case ButtonType.secondary:
        return _buildOutlinedButton(context);
      case ButtonType.text:
        return _buildTextButton(context);
    }
  }
}
```

## 🗄️ قاعدة البيانات

### Supabase Schema

```sql
-- Users table
CREATE TABLE users (
  id UUID REFERENCES auth.users ON DELETE CASCADE,
  full_name TEXT NOT NULL,
  phone TEXT,
  avatar_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  PRIMARY KEY (id)
);

-- Enable RLS
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

-- RLS Policies
CREATE POLICY "Users can view own profile" ON users
  FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can update own profile" ON users
  FOR UPDATE USING (auth.uid() = id);

-- Function to handle updated_at
CREATE OR REPLACE FUNCTION handle_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for updated_at
CREATE TRIGGER handle_users_updated_at
  BEFORE UPDATE ON users
  FOR EACH ROW
  EXECUTE FUNCTION handle_updated_at();
```

### Data Models

```dart
class User {
  final String id;
  final String fullName;
  final String email;
  final String? phone;
  final String? avatarUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  User({
    required this.id,
    required this.fullName,
    required this.email,
    this.phone,
    this.avatarUrl,
    required this.createdAt,
    required this.updatedAt,
  });
  
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['full_name'],
      email: json['email'],
      phone: json['phone'],
      avatarUrl: json['avatar_url'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'avatar_url': avatarUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
```

### Repository Pattern

```dart
abstract class UserRepository {
  Future<User?> getCurrentUser();
  Future<User> updateUser(User user);
  Future<void> deleteUser(String userId);
}

class SupabaseUserRepository implements UserRepository {
  final SupabaseClient _client = SupabaseConfig.client;
  
  @override
  Future<User?> getCurrentUser() async {
    try {
      final authUser = _client.auth.currentUser;
      if (authUser == null) return null;
      
      final response = await _client
          .from('users')
          .select()
          .eq('id', authUser.id)
          .single();
      
      return User.fromJson(response);
    } catch (e) {
      throw RepositoryException('Failed to get current user: $e');
    }
  }
  
  @override
  Future<User> updateUser(User user) async {
    try {
      final response = await _client
          .from('users')
          .update(user.toJson())
          .eq('id', user.id)
          .select()
          .single();
      
      return User.fromJson(response);
    } catch (e) {
      throw RepositoryException('Failed to update user: $e');
    }
  }
}
```

## ⚠️ معالجة الأخطاء

### نظام معالجة الأخطاء المتقدم

```dart
abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;
  
  AppException(this.message, {this.code, this.originalError});
  
  @override
  String toString() => message;
}

class AuthException extends AppException {
  AuthException(String message, {String? code, dynamic originalError})
      : super(message, code: code, originalError: originalError);
}

class NetworkException extends AppException {
  NetworkException(String message, {String? code, dynamic originalError})
      : super(message, code: code, originalError: originalError);
}

class ValidationException extends AppException {
  final Map<String, String> fieldErrors;
  
  ValidationException(String message, this.fieldErrors)
      : super(message);
}
```

### Error Handler Service

```dart
class ErrorHandler {
  static void handleError(dynamic error, {VoidCallback? onRetry}) {
    if (error is AuthException) {
      _handleAuthError(error);
    } else if (error is NetworkException) {
      _handleNetworkError(error, onRetry: onRetry);
    } else if (error is ValidationException) {
      _handleValidationError(error);
    } else {
      _handleUnknownError(error);
    }
  }
  
  static void _handleAuthError(AuthException error) {
    // إظهار رسالة خطأ المصادقة
    // توجيه المستخدم لصفحة تسجيل الدخول إذا لزم الأمر
  }
  
  static void _handleNetworkError(NetworkException error, {VoidCallback? onRetry}) {
    // إظهار رسالة خطأ الشبكة
    // إظهار زر إعادة المحاولة
  }
}
```

### Global Error Boundary

```dart
class ErrorBoundary extends StatefulWidget {
  final Widget child;
  final Widget Function(Object error, StackTrace stackTrace)? errorBuilder;
  
  const ErrorBoundary({
    Key? key,
    required this.child,
    this.errorBuilder,
  }) : super(key: key);

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  Object? _error;
  StackTrace? _stackTrace;
  
  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return widget.errorBuilder?.call(_error!, _stackTrace!) ??
          _buildDefaultErrorWidget();
    }
    
    return widget.child;
  }
  
  Widget _buildDefaultErrorWidget() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red),
            SizedBox(height: 16),
            Text('حدث خطأ غير متوقع'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => setState(() {
                _error = null;
                _stackTrace = null;
              }),
              child: Text('إعادة المحاولة'),
            ),
          ],
        ),
      ),
    );
  }
}
```

## 🔒 الأمان والحماية

### Security Best Practices

#### 1. Input Sanitization

```dart
class InputSanitizer {
  static String sanitizeString(String input) {
    // إزالة الأحرف الخطيرة
    return input
        .replaceAll(RegExp(r'[<>"\']'), '')
        .trim();
  }
  
  static String sanitizeEmail(String email) {
    return email.toLowerCase().trim();
  }
  
  static String sanitizePhone(String phone) {
    // إزالة جميع الأحرف غير الرقمية
    return phone.replaceAll(RegExp(r'[^\d]'), '');
  }
}
```

#### 2. Secure Storage

```dart
class SecureStorage {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: IOSAccessibility.first_unlock_this_device,
    ),
  );
  
  static Future<void> storeToken(String token) async {
    await _storage.write(key: 'auth_token', value: token);
  }
  
  static Future<String?> getToken() async {
    return await _storage.read(key: 'auth_token');
  }
  
  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
```

#### 3. API Security

```dart
class ApiClient {
  static const String baseUrl = 'https://api.souqna.app';
  
  static Future<Response> secureRequest(
    String endpoint, {
    Map<String, dynamic>? data,
    String method = 'GET',
  }) async {
    final token = await SecureStorage.getToken();
    
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'X-API-Version': '1.0',
      'X-Request-ID': _generateRequestId(),
    };
    
    // إضافة CSRF protection
    if (['POST', 'PUT', 'DELETE'].contains(method)) {
      headers['X-CSRF-Token'] = await _getCSRFToken();
    }
    
    return await _makeRequest(endpoint, headers, data, method);
  }
  
  static String _generateRequestId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}
```

### Rate Limiting

```dart
class RateLimiter {
  static final Map<String, List<DateTime>> _requests = {};
  static const int maxRequests = 10;
  static const Duration timeWindow = Duration(minutes: 1);
  
  static bool canMakeRequest(String identifier) {
    final now = DateTime.now();
    final requests = _requests[identifier] ?? [];
    
    // إزالة الطلبات القديمة
    requests.removeWhere(
      (time) => now.difference(time) > timeWindow,
    );
    
    if (requests.length >= maxRequests) {
      return false;
    }
    
    requests.add(now);
    _requests[identifier] = requests;
    return true;
  }
}
```

## 📊 مراقبة الأداء

### Performance Monitoring

```dart
class PerformanceMonitor {
  static void trackScreenLoad(String screenName) {
    final stopwatch = Stopwatch()..start();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      stopwatch.stop();
      _logPerformance(
        'screen_load',
        screenName,
        stopwatch.elapsedMilliseconds,
      );
    });
  }
  
  static void trackApiCall(String endpoint, Future<dynamic> apiCall) async {
    final stopwatch = Stopwatch()..start();
    
    try {
      await apiCall;
      stopwatch.stop();
      _logPerformance(
        'api_call_success',
        endpoint,
        stopwatch.elapsedMilliseconds,
      );
    } catch (e) {
      stopwatch.stop();
      _logPerformance(
        'api_call_error',
        endpoint,
        stopwatch.elapsedMilliseconds,
        error: e.toString(),
      );
    }
  }
  
  static void _logPerformance(
    String type,
    String name,
    int duration, {
    String? error,
  }) {
    // إرسال البيانات لخدمة المراقبة
    print('Performance: $type - $name - ${duration}ms');
    if (error != null) {
      print('Error: $error');
    }
  }
}
```

### Memory Management

```dart
class MemoryManager {
  static void disposeResources() {
    // تنظيف الموارد غير المستخدمة
    imageCache.clear();
    imageCache.clearLiveImages();
  }
  
  static void optimizeImageCache() {
    imageCache.maximumSize = 100;
    imageCache.maximumSizeBytes = 50 * 1024 * 1024; // 50MB
  }
}
```

## 🧪 الاختبار

### Unit Testing

```dart
// test/services/auth_service_test.dart
void main() {
  group('AuthService', () {
    late AuthService authService;
    
    setUp(() {
      authService = AuthService();
    });
    
    test('should sign in user with valid credentials', () async {
      // Arrange
      const email = 'test@example.com';
      const password = 'password123';
      
      // Act
      final result = await authService.signIn(email, password);
      
      // Assert
      expect(result.user, isNotNull);
      expect(result.user!.email, equals(email));
    });
    
    test('should throw exception with invalid credentials', () async {
      // Arrange
      const email = 'invalid@example.com';
      const password = 'wrongpassword';
      
      // Act & Assert
      expect(
        () => authService.signIn(email, password),
        throwsA(isA<AuthException>()),
      );
    });
  });
}
```

### Widget Testing

```dart
// test/widgets/custom_text_field_test.dart
void main() {
  group('CustomTextField', () {
    testWidgets('should display label and hint text', (tester) async {
      // Arrange
      const label = 'Email';
      const hint = 'Enter your email';
      final controller = TextEditingController();
      
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              label: label,
              hint: hint,
              controller: controller,
            ),
          ),
        ),
      );
      
      // Assert
      expect(find.text(label), findsOneWidget);
      expect(find.text(hint), findsOneWidget);
    });
    
    testWidgets('should validate input correctly', (tester) async {
      // Arrange
      final controller = TextEditingController();
      String? validationError;
      
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              label: 'Email',
              controller: controller,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Email is required';
                }
                return null;
              },
            ),
          ),
        ),
      );
      
      // Trigger validation
      await tester.enterText(find.byType(TextFormField), '');
      await tester.pump();
      
      // Assert
      expect(find.text('Email is required'), findsOneWidget);
    });
  });
}
```

### Integration Testing

```dart
// integration_test/auth_flow_test.dart
void main() {
  group('Authentication Flow', () {
    testWidgets('complete sign up and sign in flow', (tester) async {
      // Start app
      app.main();
      await tester.pumpAndSettle();
      
      // Navigate to sign up
      await tester.tap(find.text('إنشاء حساب'));
      await tester.pumpAndSettle();
      
      // Fill sign up form
      await tester.enterText(
        find.byKey(Key('fullNameField')),
        'Test User',
      );
      await tester.enterText(
        find.byKey(Key('emailField')),
        'test@example.com',
      );
      await tester.enterText(
        find.byKey(Key('passwordField')),
        'Password123',
      );
      await tester.enterText(
        find.byKey(Key('confirmPasswordField')),
        'Password123',
      );
      
      // Accept terms
      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();
      
      // Submit form
      await tester.tap(find.text('إنشاء حساب'));
      await tester.pumpAndSettle();
      
      // Verify navigation to verification screen
      expect(find.text('تحقق من بريدك الإلكتروني'), findsOneWidget);
    });
  });
}
```

## 📈 التحسين والأداء

### Code Optimization

```dart
// استخدام const constructors
class OptimizedWidget extends StatelessWidget {
  const OptimizedWidget({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('Optimized Text'),
        SizedBox(height: 16),
        Icon(Icons.star),
      ],
    );
  }
}

// تجنب إعادة البناء غير الضرورية
class EfficientListItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  
  const EfficientListItem({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: onTap,
    );
  }
  
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is EfficientListItem &&
            runtimeType == other.runtimeType &&
            title == other.title;
  }
  
  @override
  int get hashCode => title.hashCode;
}
```

### Image Optimization

```dart
class OptimizedImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  
  const OptimizedImage({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: BoxFit.cover,
      placeholder: (context, url) => const ShimmerPlaceholder(),
      errorWidget: (context, url, error) => const ErrorPlaceholder(),
      memCacheWidth: width?.toInt(),
      memCacheHeight: height?.toInt(),
    );
  }
}
```

## 🔧 أدوات التطوير

### Debug Tools

```dart
class DebugTools {
  static void logUserAction(String action, Map<String, dynamic> data) {
    if (kDebugMode) {
      print('User Action: $action');
      print('Data: ${jsonEncode(data)}');
    }
  }
  
  static void logApiCall(String endpoint, Map<String, dynamic> params) {
    if (kDebugMode) {
      print('API Call: $endpoint');
      print('Params: ${jsonEncode(params)}');
    }
  }
  
  static void logError(String error, StackTrace stackTrace) {
    if (kDebugMode) {
      print('Error: $error');
      print('Stack Trace: $stackTrace');
    }
  }
}
```

### Development Environment Setup

```dart
class Environment {
  static const String development = 'development';
  static const String staging = 'staging';
  static const String production = 'production';
  
  static const String current = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: development,
  );
  
  static bool get isDevelopment => current == development;
  static bool get isStaging => current == staging;
  static bool get isProduction => current == production;
  
  static String get apiBaseUrl {
    switch (current) {
      case development:
        return 'https://dev-api.souqna.app';
      case staging:
        return 'https://staging-api.souqna.app';
      case production:
        return 'https://api.souqna.app';
      default:
        return 'https://dev-api.souqna.app';
    }
  }
}
```

---

هذا التوثيق التقني يوفر دليلاً شاملاً للمطورين للعمل مع تطبيق سوقنا. يتم تحديثه بانتظام مع تطور المشروع وإضافة ميزات جديدة.

