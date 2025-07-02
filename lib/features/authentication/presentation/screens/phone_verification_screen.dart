import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/app_constants.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/styles/app_colors.dart';

class PhoneVerificationScreen extends StatefulWidget {
  final String? initialPhoneNumber;

  const PhoneVerificationScreen({
    super.key,
    this.initialPhoneNumber,
  });

  @override
  State<PhoneVerificationScreen> createState() => _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();

  // استخدام حالة وهمية للعرض الثابت
  bool _otpSent = false;
  final String _mockPhoneNumber = '0501234567';

  @override
  void initState() {
    super.initState();
    if (widget.initialPhoneNumber != null) {
      _phoneController.text = widget.initialPhoneNumber!;
    } else {
      _phoneController.text = _mockPhoneNumber;
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message, {bool isError = false}) {
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

  void _sendOTP() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _otpSent = true;
      });
      _showSnackBar('تم إرسال رمز التحقق إلى ${_phoneController.text} (محاكاة)', isError: false);
    }
  }

  void _verifyOTP() {
    if (_otpController.text.length != 6) {
      _showSnackBar('يرجى إدخال رمز التحقق المكون من 6 أرقام');
      return;
    }
    _showSnackBar('تم التحقق من رقم الهاتف بنجاح! (محاكاة)', isError: false);
    GoRouter.of(context).go(AppConstants.homeRoute);
  }

  void _resendOTP() {
    _showSnackBar('تم إعادة إرسال رمز التحقق (محاكاة)', isError: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('التحقق من رقم الهاتف'),
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
                          color: _otpSent ? AppColors.success : AppColors.primary,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: (_otpSent ? AppColors.success : AppColors.primary)
                                  .withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Icon(
                          _otpSent ? Icons.sms : Icons.phone_android,
                          size: 50,
                          color: AppColors.textOnPrimary,
                        ),
                      ),
                      const SizedBox(height: AppConstants.defaultPadding),
                      Text(
                        _otpSent ? 'أدخل رمز التحقق' : 'التحقق من رقم الهاتف',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: AppConstants.smallPadding),
                      Text(
                        _otpSent
                            ? 'أدخل الرمز المرسل إلى ${_phoneController.text}'
                            : 'سنرسل لك رمز تحقق عبر الرسائل النصية',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppConstants.largePadding * 2),

                if (!_otpSent) ...[
                  // Phone Number Field
                  CustomTextField(
                    label: 'رقم الهاتف',
                    hint: '05xxxxxxxx',
                    controller: _phoneController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى إدخال رقم الهاتف';
                      }
                      if (!RegExp(r'^(05)([0-9]{8})$').hasMatch(value)) {
                        return 'يرجى إدخال رقم هاتف سعودي صحيح (05xxxxxxxx)';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    prefixIcon: const Icon(Icons.phone),
                  ),

                  const SizedBox(height: AppConstants.largePadding),

                  // Send OTP Button
                  CustomButton(
                    text: 'إرسال رمز التحقق',
                    onPressed: _sendOTP,
                    icon: const Icon(Icons.send),
                  ),
                ] else ...[
                  // OTP Input Field
                  CustomTextField(
                    label: 'رمز التحقق',
                    hint: '123456',
                    controller: _otpController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'رمز التحقق مطلوب';
                      }
                      if (value.length != 6) {
                        return 'رمز التحقق يجب أن يكون 6 أرقام';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    maxLength: 6,
                    prefixIcon: const Icon(Icons.security),
                    onChanged: (value) {
                      if (value.length == 6) {
                        _verifyOTP();
                      }
                    },
                  ),

                  const SizedBox(height: AppConstants.largePadding),

                  // Verify OTP Button
                  CustomButton(
                    text: 'تحقق من الرمز',
                    onPressed: _verifyOTP,
                    icon: const Icon(Icons.verified_user),
                  ),

                  const SizedBox(height: AppConstants.defaultPadding),

                  // Resend OTP Button
                  CustomButton(
                    text: 'إعادة إرسال الرمز',
                    onPressed: _resendOTP,
                    type: ButtonType.outline,
                    icon: const Icon(Icons.refresh),
                  ),

                  const SizedBox(height: AppConstants.defaultPadding),

                  // Change Phone Number
                  CustomButton(
                    text: 'تغيير رقم الهاتف',
                    onPressed: () {
                      setState(() {
                        _otpSent = false;
                        _otpController.clear();
                      });
                    },
                    type: ButtonType.text,
                    icon: const Icon(Icons.edit),
                  ),
                ],

                const SizedBox(height: AppConstants.largePadding),

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
                            'معلومات مهمة:',
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppConstants.smallPadding),
                      Text(
                        '• تأكد من إدخال رقم هاتف سعودي صحيح\n'
                        '• الرمز صالح لمدة 10 دقائق فقط\n'
                        '• تحقق من رسائل SMS الواردة\n'
                        '• يمكنك إعادة طلب الرمز بعد انتهاء العد التنازلي',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppConstants.largePadding),

                // Skip for now option
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'تريد التخطي الآن؟ ',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () => GoRouter.of(context).go(AppConstants.homeRoute),
                      child: const Text(
                        'التخطي',
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
}

