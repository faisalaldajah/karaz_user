import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaz_user/theme/app_colors.dart';
import 'package:karaz_user/widgets/text/headline6.dart';

class TopWidgetIcon extends StatelessWidget {
  const TopWidgetIcon({
    super.key,
    required this.iconData,
    required this.title,
    required this.onTap,
  });
  final String title;
  final IconData iconData;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 1,
                color: AppColors.grey,
              ),
              color: AppColors.white,
            ),
            child: Center(
              child: Icon(
                iconData,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Headline6(title: title.tr)
        ],
      ),
    );
  }
}
