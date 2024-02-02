import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:karaz_user/theme/app_colors.dart';
class MainTextField extends StatelessWidget {
  const MainTextField({
    Key? key,
    required this.controller,
    required this.hint,
    required this.textInputType,
    this.focusNode,
    this.validator,
    this.maxLength,
    this.obscureText,
    this.onChanged,
    this.prefixIcon,
    this.formatter,
    this.typeInput,
    this.suffix,
    this.suffixIcon,
    this.color,
    this.withWhiteBorder,
    this.maxLine,
    this.focus,
    this.textAlign,
    this.textInputAction,
    this.iconSize,
    this.isDense,
    this.onFieldSubmitted,
  }) : super(key: key);
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final TextEditingController controller;
  final String hint;
  final TextInputType textInputType;
  final Widget? prefixIcon, suffix, suffixIcon;
  final int? maxLength;
  final bool? obscureText;
  final bool? iconSize;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? formatter;
  final String? typeInput;
  final bool? withWhiteBorder;
  final Color? color;
  final int? maxLine;
  final bool? focus;
  final TextAlign? textAlign;
  final TextInputAction? textInputAction;
  final bool? isDense;
  final Function(String)? onFieldSubmitted;
  @override
  Widget build(BuildContext context) => TextFormField(
        scrollPadding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 300,
        ),
        autocorrect: true,
        showCursor: true,
        cursorColor: Colors.black,
        focusNode: focusNode,
        inputFormatters: formatter,
        onChanged: onChanged,
        controller: controller,
        validator: validator,
        keyboardType: textInputType,
        textInputAction: textInputAction,
        onFieldSubmitted: (_) {
          if ((textInputAction == TextInputAction.done) &&
              textInputAction != TextInputAction.next) {
            FocusScope.of(context).unfocus();
          }
          onFieldSubmitted!(_);
        },
        maxLines: maxLine ?? 1,
        textAlign: textAlign ?? TextAlign.start,
        style: const TextStyle(
          fontSize: 16,
          
        ),
        obscureText: obscureText ?? false,
        mouseCursor: MouseCursor.defer,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(
            left: 12,
            right: 12,
            top: 16,
            bottom: 16,
          ),
          isDense: isDense ?? false,
          errorMaxLines: 4,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.6),
              width: 1.2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.2),
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.defaultBlack,
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1.6),
            borderRadius: BorderRadius.circular(12.0),
          ),
          filled: true,
          prefixIcon: prefixIcon,
          prefixIconConstraints: const BoxConstraints(
            minWidth: 10,
          ),
          fillColor: Colors.white,
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w400,
            fontSize: 14,
            
          ),
        ),
      );
}
