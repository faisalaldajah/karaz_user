import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaz_user/theme/app_colors.dart';
import 'package:karaz_user/theme/text_themes.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PrimaryAppBar({
    Key? key,
    this.withBack,
    this.onTap,
    this.title,
    this.widgetTitle,
    this.actions,
  }) : super(key: key);
  final bool? withBack;
  final VoidCallback? onTap;
  final String? title;
  final Widget? widgetTitle;
  final List<Widget>? actions;
  @override
  Size get preferredSize => const Size.fromHeight(40);

  @override
  Widget build(BuildContext context) => PreferredSize(
        preferredSize: preferredSize,
        child: AppBar(
          elevation: 0,
          backgroundColor: AppColors.white.withOpacity(0),
          titleSpacing: 0,
          title: widgetTitle ??
              Text(
                title ?? '',
                style: TextThemeStyle().headline3.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                    ),
              ),
          centerTitle: false,
          leadingWidth: widgetTitle != null ? 0 : 60,
          leading: withBack != false
              ? Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    24,
                    0,
                    5,
                    0,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      child: const SizedBox(
                        width: 32,
                        height: 32,
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.black,
                        ),
                      ),
                      onTap: () {
                        if (onTap != null) {
                          onTap!();
                        }
                        if (withBack != null &&
                            withBack != false &&
                            onTap == null) {
                          Get.back();
                        }
                      },
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          actions: actions,
        ),
      );
}
