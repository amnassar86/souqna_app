import 'package:flutter/material.dart';
import '../../../../shared/styles/app_colors.dart';
import '../../../../shared/styles/app_text_styles.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../config/app_constants.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _isEmailSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            print('Back button pressed');
          },
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              
              // أيقونة استعادة كلمة المرور
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Icon(
                    _isEmailSent ? Icons.mark_email_read : Icons.lock_reset,
                    size: 50,
                    color: AppColors.primary,
                  ),
                ),
              ),
              
              const SizedBox(height: 30),
              
              // عنوان الصفحة
              Text(
                _isEmailSent ? 'تم إرسال الرابط' : 'استعادة كلمة المرور',
                style: AppTextStyles.headlineLarge.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 16),
              
              // وصف الصفحة
              Text(
                _isEmailSent 
                  ? 'تم إرسال رابط استعادة كلمة المرور إلى بريدك الإلكتروني. يرجى التحقق من صندوق الوارد والبريد المزعج.'
                  : 'أدخل بريدك الإلكتروني وسنرسل لك رابط لإعادة تعيين كلمة المرور.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 40),
              
              if (!_isEmailSent) ...[
                // حقل البريد الإلكتروني
                CustomTextField(
                  controller: _emailController,
                  label: 'البريد الإلكتروني',
                  hint: 'أدخل بريدك الإلكتروني',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
                
                const SizedBox(height: 30),
                
                // زر إرسال الرابط
                CustomButton(
                  text: 'إرسال رابط الاستعادة',
                  onPressed: () {
                    print('Send reset link pressed');
                    print('Email: ${_emailController.text}');
                    setState(() {
                      _isEmailSent = true;
                    });
                  },
                  isLoading: false,
                ),
              ] else ...[
                // معلومات إضافية بعد الإرسال
                Container(
                  padding: const EdgeInsets.all(AppConstants.defaultPadding),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                    border: Border.all(
                      color: AppColors.success.withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: AppColors.success,
                        size: 24,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'لم تستلم الرسالة؟',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.success,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '• تحقق من مجلد البريد المزعج\n• تأكد من صحة عنوان البريد الإلكتروني\n• انتظر بضع دقائق قد تتأخر الرسالة',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // زر إعادة الإرسال
                OutlinedButton(
                  onPressed: () {
                    print('Resend email pressed');
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                    ),
                  ),
                  child: Text(
                    'إعادة إرسال الرسالة',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
              
              const SizedBox(height: 40),
              
              // رابط العودة لتسجيل الدخول
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'تذكرت كلمة المرور؟ ',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      print('Navigate to sign in screen');
                    },
                    child: Text(
                      'تسجيل الدخول',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
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

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}

