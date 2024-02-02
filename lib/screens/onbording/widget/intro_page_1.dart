import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:karaz_user/Utilities/images.dart';
import 'package:karaz_user/widgets/text/headline4.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Headline4(
            maxLines: 4,
            title:
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.sizeOf(context).width * 0.2),
          child: SvgPicture.asset(
            ImagesAssets.driver3,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
          ),
        ),
      ],
    );
  }
}
