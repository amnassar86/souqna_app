import 'package:flutter/material.dart';
import '../styles/app_colors.dart';
import '../../config/app_constants.dart';

enum ButtonType { primary, secondary, outline, text }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  // final bool isLoading; // تم التعليق بناءً على تعليمات المستخدم
  final Widget? icon;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = ButtonType.primary,
    // this.isLoading = false, // تم التعليق بناءً على تعليمات المستخدم
    this.icon,
    this.width,
    this.height,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveWidth = width ?? double.infinity;
    final effectiveHeight = height ?? AppConstants.buttonHeight;
    final effectiveBorderRadius = borderRadius ?? 
        BorderRadius.circular(AppConstants.borderRadius);

    Widget buttonChild = Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                icon!,
                const SizedBox(width: AppConstants.smallPadding),
              ],
              Text(text),
            ],
          );

    switch (type) {
      case ButtonType.primary:
        return SizedBox(
          width: effectiveWidth,
          height: effectiveHeight,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.textOnPrimary,
              shape: RoundedRectangleBorder(borderRadius: effectiveBorderRadius),
              padding: padding,
              elevation: 2,
            ),
            child: buttonChild,
          ),
        );

      case ButtonType.secondary:
        return SizedBox(
          width: effectiveWidth,
          height: effectiveHeight,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondary,
              foregroundColor: AppColors.textOnPrimary,
              shape: RoundedRectangleBorder(borderRadius: effectiveBorderRadius),
              padding: padding,
              elevation: 2,
            ),
            child: buttonChild,
          ),
        );

      case ButtonType.outline:
        return SizedBox(
          width: effectiveWidth,
          height: effectiveHeight,
          child: OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary, width: 1.5),
              shape: RoundedRectangleBorder(borderRadius: effectiveBorderRadius),
              padding: padding,
            ),
            child: buttonChild,
          ),
        );

      case ButtonType.text:
        return SizedBox(
          width: effectiveWidth,
          height: effectiveHeight,
          child: TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(borderRadius: effectiveBorderRadius),
              padding: padding,
            ),
            child: buttonChild,
          ),
        );
    }
  }
}

