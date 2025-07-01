import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../config/app_constants.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/styles/app_colors.dart';
import '../../../../routes/app_router.dart';

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
  final _phoneFocusNode = FocusNode();
  final _otpFocusNode = FocusNode();
  
  bool _isLoading = false;
  bool _isResending = false;
  bool _otpSent = false;
  int _resendCountdown = 0;

  @override
  void initState() {
    super.initState();
    if (widget.initialPhoneNumber != null) {
      _phoneController.text = widget.initialPhoneNumber!;
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    _phoneFocusNode.dispose();
    _otpFocusNode.dispose();
    super.dispose();
  }

  Future<void> _sendOTP() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: Implement OTP sending logic with Supabase or SMS service
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      
      if (mounted) {
        setState(() {
          _otpSent = true;
          _resendCountdown = 60;
        });
        _startCountdown();
        _showSnackBar('تم إرسال رمز التحقق إلى ${_phoneController.text}', isError: false);
        _otpFocusNode.requestFocus();
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar('حدث خطأ أثناء إرسال رمز التحقق');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _verifyOTP() async {
    if (_otpController.text.length != 6) {
      _showSnackBar('يرجى إدخال رمز التحقق المكون من 6 أرقام');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: Implement OTP verification logic
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      
      if (mounted) {
        _showSnackBar('تم التحقق من رقم الهاتف بنجاح!', isError: false);
        AppRouter.goToHome(context);
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar('رمز التحقق غير صحيح');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _resendOTP() async {
    if (_resendCountdown > 0) return;

    setState(() {
      _isResending = true;
    });

    try {
      // TODO: Implement OTP resending logic
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call
      
      if (mounted) {
        setState(() {
          _resendCountdown = 60;
        });
        _startCountdown();
        _showSnackBar('تم إعادة إرسال رمز التحقق', isError: false);
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar('حدث خطأ أثناء إعادة الإرسال');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isResending = false;
        });
      }
    }
  }

  void _startCountdown() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted && _resendCountdown > 0) {
        setState(() {
          _resendCountdown--;
        });
        return true;
      }
      return false;
    });
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
                    validator: Validators.validatePhone,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    focusNode: _phoneFocusNode,
                    onSubmitted: (_) => _sendOTP(),
                    prefixIcon: const Icon(Icons.phone),
                    autofocus: widget.initialPhoneNumber == null,
                  ),
                  
                  const SizedBox(height: AppConstants.largePadding),
                  
                  // Send OTP Button
                  CustomButton(
                    text: 'إرسال رمز التحقق',
                    onPressed: _sendOTP,
                    isLoading: _isLoading,
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
                    focusNode: _otpFocusNode,
                    onSubmitted: (_) => _verifyOTP(),
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
                    isLoading: _isLoading,
                    icon: const Icon(Icons.verified_user),
                  ),
                  
                  const SizedBox(height: AppConstants.defaultPadding),
                  
                  // Resend OTP Button
                  CustomButton(
                    text: _resendCountdown > 0
                        ? 'إعادة الإرسال خلال ${_resendCountdown}s'
                        : 'إعادة إرسال الرمز',
                    onPressed: _resendCountdown > 0 ? null : _resendOTP,
                    isLoading: _isResending,
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
                        _resendCountdown = 0;
                      });
                      _phoneFocusNode.requestFocus();
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
                      onPressed: () => AppRouter.goToHome(context),
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

