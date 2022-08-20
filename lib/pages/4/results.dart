import 'package:fabrics/pages/4/test.dart';
import 'package:fabrics/pages/layouts/results_layout.dart';
import 'package:flutter/material.dart' hide Feedback;
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Results4 extends ConsumerWidget {
  const Results4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final test = ref.read(testProvider);

    final description = [
      "If we don't separate our laundry basket using the right properties, we could cause damage to the clothing.",
      "After this module, we'll quiz you on all the concepts you've learned so far."
    ].join('\n\n');

    final almostGradeDescription = ["You've chosen the right fabric properties to separate your laundry basket by.", description].join('\n\n');

    const icon = Icon(Icons.sanitizer_outlined);

    return ResultsLayout(
      grade: test.grade,
      perfect: Feedback(
        title: "Well done",
        description: almostGradeDescription,
        info: icon,
      ),
      almost: Feedback(
        title: "Almost",
        description: almostGradeDescription,
        info: icon,
      ),
      tryAgain: Feedback(
        title: "Try again",
        description:
            ["Looks like you'll have to review washers & dryers and how to use them to properly launder clothing.", description].join('\n\n'),
        info: icon,
      ),
    );
  }
}
