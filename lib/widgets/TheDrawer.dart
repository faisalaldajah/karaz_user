import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaz_user/Services/AuthenticationService/Core/manager.dart';
import 'package:karaz_user/theme/app_colors.dart';import 'package:karaz_user/globalvariable.dart';
import 'package:karaz_user/screens/mainPage/main_page_controller.dart';

class TheDrawer extends StatelessWidget {
  TheDrawer({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final AuthenticationManager authManager = Get.find();
  final MainPageController controller;
  final Rx<File> personalImageFile = File('').obs;
  UploadTask? personalImageUploadTask;
  FirebaseStorage storage = FirebaseStorage.instance;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.white,
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: <Widget>[
          Container(
            color: Colors.white,
            height: 160,
            child: DrawerHeader(
              decoration: const BoxDecoration(color: Colors.white),
              child: Row(
                children: <Widget>[
                  Stack(
                    children: [
                      currentUserInfo!.personalImage != null
                          ? Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    currentUserInfo!.personalImage!,
                                  ),
                                ),
                                shape: BoxShape.circle,
                              ),
                            )
                          : Image.asset(
                              'images/user_icon.png',
                              height: 60,
                              width: 60,
                            ),
                      Positioned(
                        bottom: 7,
                        right: 7,
                        child: GestureDetector(
                          onTap: () async {
                            // await selectFile();
                            // DatabaseReference imageRef =
                            //     FirebaseDatabase.instance.ref().child(
                            //         'users/${currentFirebaseUser!.uid}/personalImage');
                            // personalImageUploadTask = storage
                            //     .ref()
                            //     .child(
                            //         'users/${Uri.file(personalImageFile.value.path).pathSegments.last}.jpg')
                            //     .putFile(personalImageFile.value);
                            // String personalImageUploadTaskUrl =
                            //     await (await personalImageUploadTask!)
                            //         .ref
                            //         .getDownloadURL()
                            //         .catchError((e) {
                            //   log(e.toString());
                            // });
                            // imageRef.set(personalImageUploadTaskUrl);
                          },
                          child: const Icon(
                            Icons.edit,
                            size: 20,
                            color: AppColors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(width: 15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        currentUserInfo!.fullname!,
                        style: Get.textTheme.displaySmall,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: const Icon(
              Icons.credit_card,
              color: AppColors.primary,
            ),
            title: Text(
              'PaymentMethod'.tr,
              style: Get.textTheme.headlineSmall,
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.history,
              color: AppColors.primary,
            ),
            title: Text(
              'history'.tr,
              style: Get.textTheme.headlineSmall,
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.contact_support,
              color: AppColors.primary,
            ),
            title: Text(
              'support'.tr,
              style: Get.textTheme.headlineSmall,
            ),
          ),
          ListTile(
            onTap: controller.signOut,
            leading: const Icon(
              Icons.contact_support,
              color: AppColors.primary,
            ),
            title: Text(
              'logout'.tr,
              style: Get.textTheme.headlineSmall,
            ),
          ),
        ],
      ),
    );
  }

  // Future<void> selectFile() async {
  //   List<Asset> profilePic1 = <Asset>[].obs;
  //   await MultiImagePicker.pickImages(
  //     maxImages: 1,
  //     enableCamera: true,
  //     selectedAssets: profilePic1,
  //     cupertinoOptions: const CupertinoOptions(
  //       takePhotoIcon: 'chat',
  //     ),
  //     materialOptions: const MaterialOptions(
  //       actionBarColor: '#339A58',
  //       statusBarColor: '#339A58',
  //       allViewTitle: 'All Photos',
  //       useDetailsView: false,
  //       selectCircleStrokeColor: '#339A58',
  //     ),
  //   ).then((value) async {
  //     var bytes = await value[0].getByteData();
  //     String dir = (await getApplicationDocumentsDirectory()).path;
  //     await authManager.commonTools
  //         .writeToFile(bytes, '$dir/${value[0].name}.jpg');
  //     File tempFile = File('$dir/${value[0].name}.jpg');
  //     personalImageFile.value = tempFile;
  //   });
  // }
}
