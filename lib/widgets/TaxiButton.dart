// ignore_for_file: file_names, prefer_const_constructors_in_immutables, sized_box_for_whitespace, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:karaz_user/brand_colors.dart';

class TaxiButton extends StatelessWidget {
  final String title;
  final Color? color;
  final VoidCallback onPressed;

  TaxiButton({required this.title, required this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          begin: Alignment.topRight, end: Alignment.bottomLeft,
          // ignore: prefer_const_literals_to_create_immutables
          colors: [
            BrandColors.colorGreen,
            BrandColors.colorGreen.withOpacity(0.9),
            BrandColors.colorGreen,
          ],
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 2,
            spreadRadius: 0.3,
            color: BrandColors.colorTextLight,
          ),
        ],
      ),
      height: 50,
      child: Center(
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 18, fontFamily: 'Brand-Bold', color: Colors.white),
          ),
        ),
      ),
    );
  }
}
