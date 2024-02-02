import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController{
  RxBool onLastPage = false.obs;
  final PageController pageController = PageController();
}