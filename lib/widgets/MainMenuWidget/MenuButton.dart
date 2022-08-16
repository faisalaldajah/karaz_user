import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaz_user/screens/mainPage/main_page_controller.dart';

class MenuButton extends GetView<MainPageController> {
  const MenuButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
                color: Colors.black26,
                blurRadius: 5.0,
                spreadRadius: 0.5,
                offset: Offset(
                  0.7,
                  0.7,
                ))
          ]),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 20,
        child: Obx(
          () => Icon(
            (controller.drawerCanOpen.value &&
                    controller.locationOnMap.value == false)
                ? Icons.menu
                : Icons.arrow_back,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
