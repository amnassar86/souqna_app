import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../config/app_constants.dart';
import '../features/authentication/presentation/screens/sign_in_screen.dart';
import '../features/authentication/presentation/screens/sign_up_screen.dart';
import '../features/authentication/presentation/screens/forgot_password_screen.dart';
import '../features/authentication/presentation/screens/email_verification_screen.dart';
import '../features/authentication/presentation/screens/phone_verification_screen.dart';
import '../features/authentication/presentation/screens/reset_password_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: AppConstants.signInRoute, // Start directly at sign-in for static UI
    routes: [
      // Authentication Routes
      GoRoute(
        path: AppConstants.signInRoute,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: AppConstants.signUpRoute,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: AppConstants.forgotPasswordRoute,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/email-verification',
        builder: (context, state) => const EmailVerificationScreen(),
      ),
      GoRoute(
        path: '/phone-verification',
        builder: (context, state) => const PhoneVerificationScreen(),
      ),
      GoRoute(
        path: '/reset-password',
        builder: (context, state) => const ResetPasswordScreen(),
      ),
      
      // Home Route
      GoRoute(
        path: AppConstants.homeRoute,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'الصفحة غير موجودة',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'المسار: ${state.matchedLocation}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(AppConstants.signInRoute), // Redirect to sign-in
              child: const Text('العودة لتسجيل الدخول'),
            ),
          ],
        ),
      ),
    ),
  );
  
  static GoRouter get router => _router;
}


