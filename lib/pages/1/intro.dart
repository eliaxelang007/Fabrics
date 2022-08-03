import 'package:auto_size_text/auto_size_text.dart';
import 'package:fabrics/pages/layouts/intro_layout.dart';
import 'package:flutter/material.dart';

class Intro extends StatelessWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => IntroLayout(
        title: const AutoSizeText("THE WEAKEST WEAVE", maxLines: 3),
        description: AutoSizeText(
          [
            "We've given you a lot of information about the various fabrics, fibres and weaves.",
            "Let's see what you have remembered. Take a look at the following fibres and see if",
            "you can remember where they are sourced from."
          ].join(' '),
          maxLines: 12,
        ),
        onBegin: () {
          Navigator.pushNamed(context, "/1/");
        },
      );
}
