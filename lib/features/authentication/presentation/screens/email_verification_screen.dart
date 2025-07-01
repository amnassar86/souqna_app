import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../config/app_constants.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/styles/app_colors.dart';
import '../../../../routes/app_router.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String email;
  
  const EmailVerificationScreen({
    super.key,
    required this.email,
  });

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool _isLoading = false;
  bool _isResending = false;

  @override
  void initState() {
    super.initState();
    _checkEmailVerification();
  }

  Future<void> _checkEmailVerification() async {
    // Listen to auth state changes
    AuthService.authStateStream.listen((AuthState state) {
      if (state.event == AuthChangeEvent.signedIn && mounted) {
        final user = state.session?.user;
        if (user != null && user.emailConfirmedAt != null) {
          AppRouter.goToHome(context);
        }
      }
    });
  }

  Future<void> _resendVerificationEmail() async {
    setState(() {
      _isResending = true;
    });

    try {
      await AuthService.resendEmailConfirmation(email: widget.email);
      if (mounted) {
        _showSnackBar('تم إعادة إرسال رسالة التحقق', isError: false);
      }
    } on AuthException catch (e) {
      if (mounted) {
        _showSnackBar(e.message);
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar(AppConstants.unknownError);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isResending = false;
        });
      }
    }
  }

  Future<void> _refreshVerificationStatus() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Refresh the session to check if email is verified
      await AuthService.client.auth.refreshSession();
      final user = AuthService.getCurrentUser();
      
      if (user?.emailConfirmedAt != null && mounted) {
        AppRouter.goToHome(context);
      } else if (mounted) {
        _showSnackBar('لم يتم التحقق من البريد الإلكتروني بعد');
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar('حدث خطأ أثناء التحقق من الحالة');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showSnackBar(String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? AppColors.error : AppColors.success,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(AppConstants.defaultPadding),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('التحقق من البريد الإلكتروني'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppConstants.largePadding),
              
              // Header
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppColors.warning,
                        borderRadius: BorderRadius.circular(60),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.warning.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.mark_email_unread,
                        size: 60,
                        color: AppColors.textOnPrimary,
                      ),
                    ),
                    const SizedBox(height: AppConstants.defaultPadding),
                    Text(
                      'تحقق من بريدك الإلكتروني',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppConstants.smallPadding),
                    Text(
                      'لقد أرسلنا رسالة تحقق إلى:',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppConstants.smallPadding),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.defaultPadding,
                        vertical: AppConstants.smallPadding,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Text(
                        widget.email,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: AppConstants.largePadding * 2),
              
              // Instructions
              Container(
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.info_outline,
                          color: AppColors.primary,
                          size: 20,
                        ),
                        const SizedBox(width: AppConstants.smallPadding),
                        Text(
                          'خطوات التحقق:',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppConstants.smallPadding),
                    Text(
                      '1. افتح تطبيق البريد الإلكتروني\n'
                      '2. ابحث عن رسالة من سوقنا\n'
                      '3. اضغط على رابط التحقق في الرسالة\n'
                      '4. ارجع إلى التطبيق واضغط "تحديث الحالة"',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: AppConstants.largePadding),
              
              // Action Buttons
              CustomButton(
                text: 'تحديث حالة التحقق',
                onPressed: _refreshVerificationStatus,
                isLoading: _isLoading,
                icon: const Icon(Icons.refresh),
              ),
              
              const SizedBox(height: AppConstants.defaultPadding),
              
              CustomButton(
                text: 'إعادة إرسال رسالة التحقق',
                onPressed: _resendVerificationEmail,
                isLoading: _isResending,
                type: ButtonType.outline,
                icon: const Icon(Icons.send),
              ),
              
              const SizedBox(height: AppConstants.defaultPadding),
              
              CustomButton(
                text: 'فتح تطبيق البريد',
                onPressed: () {
                  // TODO: Open email app
                  _showSnackBar(
                    'يرجى فتح تطبيق البريد الإلكتروني يدوياً',
                    isError: false,
                  );
                },
                type: ButtonType.text,
                icon: const Icon(Icons.mail_outline),
              ),
              
              const Spacer(),
              
              // Help Section
              Container(
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.help_outline,
                          color: AppColors.textSecondary,
                          size: 20,
                        ),
                        const SizedBox(width: AppConstants.smallPadding),
                        Text(
                          'لم تستلم الرسالة؟',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppConstants.smallPadding),
                    Text(
                      '• تحقق من مجلد البريد المزعج\n'
                      '• تأكد من صحة عنوان البريد الإلكتروني\n'
                      '• انتظر بضع دقائق قد تتأخر الرسالة\n'
                      '• تأكد من اتصالك بالإنترنت',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: AppConstants.defaultPadding),
              
              // Back to Sign In
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'تريد استخدام بريد آخر؟ ',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextButton(
                    onPressed: () => AppRouter.goToSignIn(context),
                    child: const Text(
                      'تسجيل الدخول',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

