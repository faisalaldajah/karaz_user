import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:karaz_user/theme/app_colors.dart';
class PasswordRoleChecker extends StatelessWidget {
  const PasswordRoleChecker({
    required this.content,
    required this.roleCheck,
    Key? key,
  }) : super(key: key);
  final String content;
  final bool roleCheck;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        roleCheck == false
            ? SvgPicture.asset(
                'images/!.svg',
                width: 12,
                color: AppColors.grey.withOpacity(0.7),
              )
            : const Icon(
                Icons.done,
                color: AppColors.success,
              ),
        const SizedBox(width: 10),
        Text(
          content.tr,
          style: Get.textTheme.headline6!.copyWith(
            color: roleCheck == false
                ? AppColors.grey.withOpacity(0.7)
                : AppColors.success,
          ),
        )
      ],
    );
  }
}
