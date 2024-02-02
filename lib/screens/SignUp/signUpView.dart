// ignore_for_file: deprecated_member_use, file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:karaz_user/Utilities/tools/tools.dart';
import 'package:karaz_user/screens/SignUp/SignUp_controller.dart';
import 'package:karaz_user/theme/app_colors.dart';
import 'package:karaz_user/theme/text_themes.dart';
import 'package:karaz_user/widgets/CustomizedTextField.dart';
import 'package:karaz_user/widgets/PasswordRoleChecker.dart';
import 'package:karaz_user/widgets/primary_appbar.dart';
import 'package:karaz_user/widgets/primary_button/primary_button.dart';
import 'package:karaz_user/widgets/text/headline1.dart';

// ignore: use_key_in_widget_constructors
class SignUpView extends GetView<SignUpController> {
  static const String id = 'register';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => appTools.unFocusKeyboard(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const PrimaryAppBar(
          withBack: true,
        ),
        body: Form(
          key: controller.registrationKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: Headline1(
                      title: 'Taxico',
                      style: TextThemeStyle().headline1.copyWith(
                            color: AppColors.defaultBlack,
                            fontSize: 60,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Obx(
                      () => Column(
                        children: <Widget>[
                          // Fullname
                          CustomizedTextField(
                            formatter: [
                              LengthLimitingTextInputFormatter(100),
                              FilteringTextInputFormatter.allow(
                                  RegExp('[a-zA-Zا-ي ]'))
                            ],
                            textFieldController:
                                controller.fullNameController.value,
                            hint: 'fullname',
                            textInputType: TextInputType.text,
                            obscureText: false,
                            validator: (value) => appTools
                                .nameValidate(controller.emailController.value),
                          ),
                          const SizedBox(height: 10),
                          // Email Address
                          CustomizedTextField(
                            formatter: [
                              LengthLimitingTextInputFormatter(100),
                              FilteringTextInputFormatter.allow(
                                  RegExp('[a-zA-Z0-9@#&\$*-_%]'))
                            ],
                            textFieldController:
                                controller.emailController.value,
                            hint: 'email address',
                            textInputType: TextInputType.emailAddress,
                            obscureText: false,
                            validator: (value) => appTools.emailValidate(
                                controller.emailController.value),
                          ),
                          const SizedBox(height: 10),
                          // Phone
                          CustomizedTextField(
                            formatter: [
                              LengthLimitingTextInputFormatter(10),
                              FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                            ],
                            textFieldController:
                                controller.phoneController.value,
                            hint: 'Phone Number',
                            textInputType: TextInputType.phone,
                            obscureText: false,
                            validator: (value) => appTools.phoneNumberValidate(
                                controller.phoneController.value),
                          ),
                          const SizedBox(height: 10),
                          // Password
                          CustomizedTextField(
                            formatter: [
                              LengthLimitingTextInputFormatter(24),
                              FilteringTextInputFormatter.allow(
                                  RegExp('[a-zA-Z0-9@#&\$*-_%]'))
                            ],
                            textFieldController:
                                controller.passwordController.value,
                            hint: 'password',
                            textInputType: TextInputType.text,
                            obscureText: controller.showPassword.value,
                            suffix: IconButton(
                              onPressed: () {
                                controller.showPassword.value =
                                    !controller.showPassword.value;
                              },
                              color: controller.showPassword.value
                                  ? AppColors.grey
                                  : AppColors.primary,
                              icon: Icon(
                                !controller.showPassword.value
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                            ),
                            onChanged: (value) {
                              String number = r'^(?=.*?[0-9])';
                              RegExp numberregExp = RegExp(number);
                              String letter = r'^(?=.*?[A-Z])(?=.*?[a-z])';
                              String sympol = r'(?=.*?[!@#\$&*~%])';
                              RegExp regExp = RegExp(sympol);
                              RegExp letterregExp = RegExp(letter);
                              if (value.length >= 8) {
                                controller.eightCharacter.value = true;
                              } else {
                                controller.eightCharacter.value = false;
                              }
                              if (letterregExp.hasMatch(
                                  controller.passwordController.value.text)) {
                                controller.characterCase.value = true;
                              } else {
                                controller.characterCase.value = false;
                              }
                              if ((numberregExp.hasMatch(controller
                                      .passwordController.value.text) &&
                                  regExp.hasMatch(controller
                                      .passwordController.value.text))) {
                                controller.numberOfDigit.value = true;
                              } else {
                                controller.numberOfDigit.value = false;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          PasswordRoleChecker(
                            content: 'At least 8 characters.',
                            roleCheck: controller.eightCharacter.value,
                          ),
                          const SizedBox(height: 8.0),
                          PasswordRoleChecker(
                            content: 'Uppercase(A-Z), lowercase (a-z).',
                            roleCheck: controller.characterCase.value,
                          ),
                          const SizedBox(height: 8.0),
                          PasswordRoleChecker(
                            content:
                                'Digits (0-9) & special character (\$,%,@..).',
                            roleCheck: controller.numberOfDigit.value,
                          ),
                          const SizedBox(height: 8.0),
                          const SizedBox(height: 40),
                          PrimaryButton(
                            title: 'signup'.tr,
                            onTap: () async {
                              if (controller.registrationKey.currentState!
                                  .validate()) {
                                await controller.registerUser();
                              } else {
                                // appTools
                                //     .showFailedSnackBar(
                                //         'Please fill the required fields');
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'already have account?'.tr,
                        style: Get.textTheme.headline5!
                            .copyWith(color: AppColors.grey),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          '' + 'login'.tr,
                          style: Get.textTheme.headline4!.copyWith(
                              color: Get.theme.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
