import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:fabrics/pages/layouts/intro_layout.dart';

class Intro4 extends StatelessWidget {
  const Intro4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => IntroLayout(
        title: const AutoSizeText("THE SEPARATION GAME"),
        description: AutoSizeText(
          [
            "Let's put what you've learned to the test.",
            "Before you cam move forward and start your laundry process, whether it's washing or drying, it's important to separate the items in your laundry basket."
          ].join(' '),
        ),
        onBegin: () {
          Navigator.pushNamed(context, "/4/test");
        },
      );
}
