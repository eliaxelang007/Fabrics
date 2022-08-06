import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:fabrics/pages/layouts/intro_layout.dart';

class Intro3 extends StatelessWidget {
  const Intro3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => IntroLayout(
        title: const AutoSizeText("OFF THE SHELF"),
        description: AutoSizeText(
          [
            "Let's put what you've learned to the test!",
            "Take a look at the garment properties and the level of soiling. Drag the products you would use to launder the items into the washing machine."
          ].join(' '),
        ),
        onBegin: () {
          Navigator.pushNamed(context, "/3/test");
        },
      );
}
