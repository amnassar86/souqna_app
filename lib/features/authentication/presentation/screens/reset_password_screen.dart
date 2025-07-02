import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/styles/app_colors.dart';
import '../../../../shared/styles/app_text_styles.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../config/app_constants.dart';

class ResetPasswordScreen extends StatefulWidget {
  // لا حاجة لـ accessToken و refreshToken في الواجهة الثابتة
  // final String? accessToken;
  // final String? refreshToken;
  
  const ResetPasswordScreen({
    super.key,
    // this.accessToken,
    // this.refreshToken,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  // لا حاجة لـ _isLoading أو _passwordsMatch في الواجهة الثابتة
  // bool _isLoading = false;
  // bool _passwordsMatch = true;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleResetPassword() {
    if (_formKey.currentState!.validate()) {
      // محاكاة إعادة تعيين كلمة المرور
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم تغيير كلمة المرور بنجاح! (محاكاة)'))
      );
      GoRouter.of(context).go(AppConstants.signInRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إعادة تعيين كلمة المرور'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppConstants.largePadding),
                
                // Header
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.lock_reset,
                          size: 50,
                          color: AppColors.textOnPrimary,
                        ),
                      ),
                      const SizedBox(height: AppConstants.defaultPadding),
                      Text(
                        'إعادة تعيين كلمة المرور',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppConstants.smallPadding),
                      Text(
                        'أدخل كلمة المرور الجديدة لحسابك',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: AppConstants.largePadding * 2),
                
                // New Password Field
                CustomTextField(
                  label: 'كلمة المرور الجديدة',
                  hint: 'أدخل كلمة مرور قوية',
                  controller: _newPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى إدخال كلمة المرور الجديدة';
                    }
                    if (value.length < 6) {
                      return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                    }
                    return null;
                  },
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(Icons.lock_outline),
                  autofocus: true,
                ),
                
                const SizedBox(height: AppConstants.defaultPadding),
                
                // Confirm New Password Field
                CustomTextField(
                  label: 'تأكيد كلمة المرور الجديدة',
                  hint: 'أعد إدخال كلمة المرور الجديدة',
                  controller: _confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى تأكيد كلمة المرور الجديدة';
                    }
                    if (value != _newPasswordController.text) {
                      return 'كلمة المرور غير متطابقة';
                    }
                    return null;
                  },
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  prefixIcon: const Icon(Icons.lock_outline),
                ),
                
                const SizedBox(height: AppConstants.largePadding),
                
                // Password Requirements
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
                            'متطلبات كلمة المرور:',
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppConstants.smallPadding),
                      _buildPasswordRequirement(
                        'على الأقل ${AppConstants.minPasswordLength} أحرف',
                        _newPasswordController.text.length >= AppConstants.minPasswordLength,
                      ),
                      _buildPasswordRequirement(
                        'حرف كبير واحد على الأقل (A-Z)',
                        RegExp(r'[A-Z]').hasMatch(_newPasswordController.text),
                      ),
                      _buildPasswordRequirement(
                        'حرف صغير واحد على الأقل (a-z)',
                        RegExp(r'[a-z]').hasMatch(_newPasswordController.text),
                      ),
                      _buildPasswordRequirement(
                        'رقم واحد على الأقل (0-9)',
                        RegExp(r'[0-9]').hasMatch(_newPasswordController.text),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: AppConstants.largePadding),
                
                // Reset Password Button
                CustomButton(
                  text: 'تعيين كلمة المرور الجديدة',
                  onPressed: _handleResetPassword,
                  icon: const Icon(Icons.save),
                ),
                
                const SizedBox(height: AppConstants.largePadding),
                
                // Security Notice
                Container(
                  padding: const EdgeInsets.all(AppConstants.defaultPadding),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                    border: Border.all(color: AppColors.warning.withOpacity(0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.security,
                            color: AppColors.warning,
                            size: 20,
                          ),
                          const SizedBox(width: AppConstants.smallPadding),
                          Text(
                            'ملاحظة أمنية:',
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.warning,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppConstants.smallPadding),
                      Text(
                        'بعد تغيير كلمة المرور، ستحتاج إلى تسجيل الدخول مرة أخرى في جميع الأجهزة.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: AppConstants.largePadding),
                
                // Back to Sign In
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'تذكرت كلمة المرور؟ ',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () => GoRouter.of(context).go(AppConstants.signInRoute),
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
      ),
    );
  }

  Widget _buildPasswordRequirement(String text, bool isMet) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isMet ? AppColors.success : AppColors.textSecondary,
            size: 16,
          ),
          const SizedBox(width: AppConstants.smallPadding),
          Text(
            text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isMet ? AppColors.success : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

