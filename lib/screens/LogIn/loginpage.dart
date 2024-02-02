import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:karaz_user/screens/LogIn/login_controller.dart';
import 'package:karaz_user/screens/SignUp/signUpView.dart';
import 'package:karaz_user/screens/SignUp/signUp_binding.dart';
import 'package:karaz_user/theme/app_colors.dart';
import 'package:karaz_user/theme/text_themes.dart';
import 'package:karaz_user/widgets/CustomizedTextField.dart';
import 'package:flutter/material.dart';
import 'package:karaz_user/widgets/primary_appbar.dart';
import 'package:karaz_user/widgets/primary_button/primary_button.dart';
import 'package:karaz_user/widgets/text/headline1.dart';
import 'package:karaz_user/widgets/text/headline5.dart';

class LoginPage extends GetView<LogInController> {
  static const String id = 'login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(
        withBack: true,
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: controller.loginForm,
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
                const SizedBox(
                  height: 32,
                ),
                Center(
                  child: Headline5(
                    title: 'Sign in your account',
                    style: TextThemeStyle().headline5.copyWith(
                          color: const Color.fromARGB(255, 118, 118, 120),
                        ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
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
                        PrimaryButton(
                          title: 'login',
                          onTap: () async {
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
                      style: Get.textTheme.headlineSmall!
                          .copyWith(color: AppColors.grey),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => SignUpView(), binding: SignUpBinding());
                      },
                      child: Text(
                        '' + 'register now'.tr,
                        style: Get.textTheme.headlineMedium!.copyWith(
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
