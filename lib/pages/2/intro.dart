import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:fabrics/pages/layouts/intro_layout.dart';

class Intro2 extends StatelessWidget {
  const Intro2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => IntroLayout(
        title: const AutoSizeText("THE STAIN GAME"),
        description: AutoSizeText(
          [
            "Let's put what you've learned to the test!",
            "Take a look at the type of stain you need to remove, and then select the most appropriate removal method.",
            "Make sure to get it right or you could damage the garment."
          ].join(' '),
        ),
        onBegin: () {
          Navigator.pushNamed(context, "/2/test");
        },
      );
}