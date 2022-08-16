import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:karaz_user/Utilities/Constants/AppColors.dart';

class CustomizedTextField extends StatelessWidget {
  const CustomizedTextField(
      {Key? key,
      required this.textFieldController,
      this.title,
      required this.hint,
      required this.textInputType,
      this.subtitle,
      this.validator,
      this.maxLength,
      this.obscureText,
      this.onChanged,
      this.icon,
      this.formatter,
      this.suffix})
      : super(key: key);
  final Function(String)? onChanged;
  final TextEditingController? textFieldController;
  final String? title;
  final String hint;
  final String? subtitle;
  final TextInputType textInputType;
  final Widget? icon, suffix;
  final int? maxLength;
  final bool? obscureText;
  final FormFieldValidator<String?>? validator;
  final List<TextInputFormatter>? formatter;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title == null ? '' : title!.tr,
              style: Get.textTheme.headline5,
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              (subtitle != null) ? subtitle!.tr : '',
              style: Get.textTheme.headline6,
            )
          ],
        ),
        TextFormField(
          inputFormatters: formatter,
          onChanged: onChanged,
          controller: textFieldController,
          validator: validator,
          keyboardType: textInputType,
          maxLines: 1,
          textAlign: TextAlign.start,
          style: Get.textTheme.headline6,
          obscureText: obscureText == true ? obscureText! : false,
          decoration: InputDecoration(
            suffixIcon: suffix,
            contentPadding: const EdgeInsets.all(15.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide:
                  const BorderSide(color: AppColors.lightGreyColor, width: 0.7),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.lightGreyColor, width: 0.7),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.lightGreyColor, width: 1.2),
              borderRadius: BorderRadius.circular(10.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 0.7),
              borderRadius: BorderRadius.circular(10.0),
            ),
            filled: true,
            fillColor: AppColors.grey.withOpacity(0.07),
            hintText: hint.tr,
            hintStyle: Get.textTheme.headline6!.copyWith(
              color: AppColors.grey,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
