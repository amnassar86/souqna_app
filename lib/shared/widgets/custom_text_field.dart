import 'package:flutter/material.dart';
import '../styles/app_colors.dart';
import '../../config/app_constants.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String? hint;
  final TextEditingController controller;
  // final String? Function(String?)? validator; // تم التعليق بناءً على تعليمات المستخدم
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;
  final int? maxLines;
  final int? maxLength;
  final TextInputAction? textInputAction;
  // final Function(String)? onChanged; // تم التعليق بناءً على تعليمات المستخدم
  // final Function(String)? onSubmitted; // تم التعليق بناءً على تعليمات المستخدم
  // final FocusNode? focusNode; // تم التعليق بناءً على تعليمات المستخدم
  // final bool autofocus; // تم التعليق بناءً على تعليمات المستخدم

  const CustomTextField({
    super.key,
    required this.label,
    this.hint,
    required this.controller,
    // this.validator, // تم التعليق بناءً على تعليمات المستخدم
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.textInputAction,
    // this.onChanged,
    // this.onSubmitted,
    // this.focusNode,
    // this.autofocus = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppConstants.smallPadding),
        TextFormField(
          controller: widget.controller,
          // validator: widget.validator, // تم التعليق بناءً على تعليمات المستخدم
          keyboardType: widget.keyboardType,
          obscureText: _obscureText,
          enabled: widget.enabled,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          textInputAction: widget.textInputAction,
          // onChanged: widget.onChanged, // تم التعليق بناءً على تعليمات المستخدم
          // onFieldSubmitted: widget.onSubmitted, // تم التعليق بناءً على تعليمات المستخدم
          // focusNode: widget.focusNode, // تم التعليق بناءً على تعليمات المستخدم
          // autofocus: widget.autofocus, // تم التعليق بناءً على تعليمات المستخدم
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: widget.hint ?? widget.label,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : widget.suffixIcon,
            counterText: widget.maxLength != null ? null : '',
          ),
        ),
      ],
    );
  }
}


