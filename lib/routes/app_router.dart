import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../config/app_constants.dart';
import '../config/supabase_config.dart';
import '../features/authentication/presentation/screens/sign_in_screen.dart';
import '../features/authentication/presentation/screens/sign_up_screen.dart';
import '../features/authentication/presentation/screens/forgot_password_screen.dart';
import '../features/authentication/presentation/screens/email_verification_screen.dart';
import '../features/authentication/presentation/screens/phone_verification_screen.dart';
import '../features/authentication/presentation/screens/reset_password_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: AppConstants.splashRoute,
    redirect: (context, state) {
      final isSignedIn = SupabaseConfig.isSignedIn;
      final isAuthRoute = [
        AppConstants.signInRoute,
        AppConstants.signUpRoute,
        AppConstants.forgotPasswordRoute,
        '/email-verification',
        '/phone-verification',
        '/reset-password',
      ].contains(state.matchedLocation);
      
      // If user is signed in and trying to access auth routes, redirect to home
      if (isSignedIn && isAuthRoute) {
        return AppConstants.homeRoute;
      }
      
      // If user is not signed in and trying to access protected routes, redirect to sign in
      if (!isSignedIn && !isAuthRoute && state.matchedLocation != AppConstants.splashRoute) {
        return AppConstants.signInRoute;
      }
      
      return null;
    },
    routes: [
      // Splash Route
      GoRoute(
        path: AppConstants.splashRoute,
        builder: (context, state) {
          // Check auth state and redirect accordingly
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (SupabaseConfig.isSignedIn) {
              context.go(AppConstants.homeRoute);
            } else {
              context.go(AppConstants.signInRoute);
            }
          });
          
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
      
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
        builder: (context, state) {
          final email = state.uri.queryParameters['email'] ?? '';
          return EmailVerificationScreen(email: email);
        },
      ),
      GoRoute(
        path: '/phone-verification',
        builder: (context, state) {
          final phone = state.uri.queryParameters['phone'];
          return PhoneVerificationScreen(initialPhoneNumber: phone);
        },
      ),
      GoRoute(
        path: '/reset-password',
        builder: (context, state) {
          final accessToken = state.uri.queryParameters['access_token'];
          final refreshToken = state.uri.queryParameters['refresh_token'];
          return ResetPasswordScreen(
            accessToken: accessToken,
            refreshToken: refreshToken,
          );
        },
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
              onPressed: () => context.go(AppConstants.homeRoute),
              child: const Text('العودة للرئيسية'),
            ),
          ],
        ),
      ),
    ),
  );
  
  static GoRouter get router => _router;
  
  // Navigation helpers
  static void goToSignIn(BuildContext context) {
    context.go(AppConstants.signInRoute);
  }
  
  static void goToSignUp(BuildContext context) {
    context.go(AppConstants.signUpRoute);
  }
  
  static void goToForgotPassword(BuildContext context) {
    context.go(AppConstants.forgotPasswordRoute);
  }
  
  static void goToEmailVerification(BuildContext context, String email) {
    context.go('/email-verification?email=${Uri.encodeComponent(email)}');
  }
  
  static void goToPhoneVerification(BuildContext context, {String? phone}) {
    final query = phone != null ? '?phone=${Uri.encodeComponent(phone)}' : '';
    context.go('/phone-verification$query');
  }
  
  static void goToResetPassword(BuildContext context, {String? accessToken, String? refreshToken}) {
    final params = <String, String>{};
    if (accessToken != null) params['access_token'] = accessToken;
    if (refreshToken != null) params['refresh_token'] = refreshToken;
    
    final query = params.isNotEmpty 
        ? '?${params.entries.map((e) => '${e.key}=${Uri.encodeComponent(e.value)}').join('&')}'
        : '';
    context.go('/reset-password$query');
  }
  
  static void goToHome(BuildContext context) {
    context.go(AppConstants.homeRoute);
  }
  
  static void goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppConstants.homeRoute);
    }
  }
}

