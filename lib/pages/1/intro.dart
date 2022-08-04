import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:fabrics/pages/layouts/intro_layout.dart';

class Intro extends StatelessWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => IntroLayout(
        title: const AutoSizeText("THE WEAKEST WEAVE"),
        description: AutoSizeText(
          [
            "We've given you a lot of information about the various fabrics, fibres and weaves.",
            "Let's see what you have remembered. Take a look at the following fibres and see if",
            "you can remember where they are sourced from."
          ].join(' '),
        ),
        onBegin: () {
          Navigator.pushNamed(context, "/1/test");
        },
      );
}
