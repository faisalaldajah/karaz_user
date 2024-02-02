import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaz_user/widgets/my_country_code/caountry_widget.dart';
import 'package:karaz_user/widgets/my_country_code/country_code_method.dart';
import 'package:karaz_user/widgets/text/headline5.dart';

class CallCountryCodeIcon extends GetView<CountryCodeMethod> {
  const CallCountryCodeIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Obx(
        () => GestureDetector(
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(width: 16),
                myCountryCodeMethod.flagWidget(
                  mainCountryCode.value,
                ),
                Headline5(
                  title: mainCountryCode.value.dialCode,
                ),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 20,
                  color: Colors.black,
                ),
                Container(
                  margin: const EdgeInsetsDirectional.fromSTEB(
                    8,
                    0,
                    8,
                    0,
                  ),
                  height: 26,
                  width: 1,
                  color: Colors.grey.withOpacity(0.3),
                ),
              ],
            ),
          ),
          onTap: () {
            Get.lazyPut<CountryCodeMethod>(() => CountryCodeMethod());
            showCustomBottomSheet(
              context,
              const NadCountryCodeWidget(),
              true,
            );
          },
        ),
      );
}
