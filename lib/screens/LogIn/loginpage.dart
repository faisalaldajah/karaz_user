import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:karaz_user/Services/translation_service.dart';
import 'package:karaz_user/Utilities/Constants/AppColors.dart';
import 'package:karaz_user/screens/LogIn/login_controller.dart';
import 'package:karaz_user/screens/SignUp/signUpView.dart';
import 'package:karaz_user/screens/SignUp/signUp_binding.dart';
import 'package:karaz_user/widgets/CustomizedTextField.dart';
import 'package:karaz_user/widgets/GradientButton.dart';
import 'package:flutter/material.dart';

class LoginPage extends GetView<LogInController> {
  static const String id = 'login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: controller.loginForm,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 25),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: IntrinsicHeight(
                    child: Row(children: [
                      InkWell(
                        child: Text(
                          'العربية',
                          style: Get.theme.textTheme.headline1!.copyWith(
                              fontSize: 15.0,
                              color: TranslationService().isLocaleArabic()
                                  ? AppColors.black
                                  : AppColors.grey.withOpacity(0.5)),
                        ),
                        onTap: () {
                          TranslationService().changeLocale('ar_SA');
                        },
                      ),
                      const VerticalDivider(
                        color: AppColors.black,
                      ),
                      InkWell(
                          onTap: () {
                            TranslationService().changeLocale('en_US');
                          },
                          child: Text(
                            'English',
                            style: Get.theme.textTheme.headline1!.copyWith(
                                fontSize: 15.0,
                                color: TranslationService().isLocaleArabic()
                                    ? AppColors.grey.withOpacity(0.5)
                                    : AppColors.black),
                          )),
                    ]),
                  ).paddingSymmetric(horizontal: 42).marginOnly(top: 20),
                ),
                const SizedBox(height: 40),
                SvgPicture.asset(
                  'images/karaz_logo.svg',
                  width: 120,
                  height: 120,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text('Karaz',
                    style: Get.textTheme.headline1!
                        .copyWith(color: AppColors.primary, fontSize: 40)),
                const SizedBox(height: 20),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        CustomizedTextField(
                          formatter: [
                            LengthLimitingTextInputFormatter(100),
                            FilteringTextInputFormatter.allow(
                                RegExp('[a-zA-Z0-9@#&\$*-_]'))
                          ],
                          obscureText: false,
                          textFieldController: controller.emailController.value,
                          hint: 'email address',
                          textInputType: TextInputType.emailAddress,
                          validator: (value) => controller
                              .authManager.commonTools
                              .emailValidate(controller.emailController.value),
                        ),
                        const SizedBox(height: 15),
                        CustomizedTextField(
                          formatter: [
                            LengthLimitingTextInputFormatter(24),
                            FilteringTextInputFormatter.allow(
                                RegExp('[a-zA-Z0-9@#&\$*-_]'))
                          ],
                          obscureText: controller.showPassword.value,
                          textFieldController:
                              controller.passwordController.value,
                          hint: 'password',
                          textInputType: TextInputType.text,
                          validator: (value) => controller
                              .authManager.commonTools
                              .passwordValidate(
                                  controller.passwordController.value),
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
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        GradientButton(
                          title: 'login',
                          onPressed: () async {
                            if (controller.loginForm.currentState!.validate()) {
                              controller.login();
                            } else {
                              controller.authManager.commonTools
                                  .showFailedSnackBar('enterValidData');
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
                      'don\'t have an account?'.tr,
                      style: Get.textTheme.headline5!
                          .copyWith(color: AppColors.grey),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => SignUpView(), binding: SignUpBinding());
                      },
                      child: Text(
                        '' + 'register now'.tr,
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
    );
  }
}
