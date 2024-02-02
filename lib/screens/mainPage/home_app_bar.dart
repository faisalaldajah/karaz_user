import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaz_user/Utilities/routes/routes_string.dart';
import 'package:karaz_user/screens/mainPage/main_page_controller.dart';
import 'package:karaz_user/screens/mainPage/top_widget_icon.dart';
import 'package:karaz_user/theme/app_colors.dart';
import 'package:karaz_user/widgets/text/headline2.dart';
import 'package:karaz_user/widgets/top_modal_sheet/top_modal_sheet.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GetBuilder<MainPageController>(builder: (homeController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          height: MediaQuery.sizeOf(context).height * 0.2,
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.white,
                AppColors.white.withOpacity(0.8),
                AppColors.white.withOpacity(0.6),
                AppColors.white.withOpacity(0.4),
                AppColors.white.withOpacity(0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => SizedBox(
                  width: 30,
                  child: homeController.locationOnMap.value != false
                      ? IconButton(
                          onPressed: () {
                            homeController.resetApp();
                          },
                          icon: const Icon(
                            Icons.close,
                          ),
                        )
                      : const SizedBox(),
                ),
              ),
              const Headline2(
                title: 'Taxico',
              ),
              CircleAvatar(
                backgroundColor: AppColors.primary,
                child: IconButton(
                  onPressed: () {
                    showTopModalSheet<String?>(
                      context,
                      Container(
                        height: 230,
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 60,
                            ),
                            const Headline2(
                              title: 'Taxico',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TopWidgetIcon(
                                  iconData: Icons.location_on_outlined,
                                  title: 'Address',
                                  onTap: () =>
                                      Get.toNamed(RoutesString.addressBook),
                                ),
                                TopWidgetIcon(
                                  title: 'Help',
                                  iconData: Icons.help,
                                  onTap: () {},
                                ),
                                TopWidgetIcon(
                                  title: 'History',
                                  iconData: Icons.history,
                                  onTap: () {},
                                ),
                                TopWidgetIcon(
                                  title: 'Profile',
                                  iconData: Icons.person_2_outlined,
                                  onTap: () =>
                                      Get.toNamed(RoutesString.profile),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Container(
                              height: 5,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.menu_outlined,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
