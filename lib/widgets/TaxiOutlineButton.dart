// ignore_for_file: file_names, prefer_const_constructors_in_immutables, use_key_in_widget_constructors
import 'package:karaz_user/brand_colors.dart';
import 'package:flutter/material.dart';

class TaxiOutlineButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final Color? color;

  TaxiOutlineButton({required this.title, required this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return ElevatedButton(
        // borderSide: BorderSide(color: color!),
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(25.0),
        // ),
        onPressed: onPressed(),
        // color: color,
        // textColor: color,
        child: SizedBox(
          height: 50.0,
          child: Center(
            child: Text(title,
                style: const TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Brand-Bold',
                    color: BrandColors.colorText)),
          ),
        ));
  }
}
