import 'package:fabrics/pages/3/test.dart';
import 'package:fabrics/pages/layouts/results_layout.dart';
import 'package:flutter/material.dart' hide Feedback;
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Results3 extends ConsumerWidget {
  const Results3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final test = ref.read(testProvider);

    final description = [
      "Using the right types of detergent, we can effectively clean the different types of clothing our customer bring us.",
      "We'll explore how we can use washers and dryers to effectively launder clothes in the next module."
    ].join('\n\n');

    final almostGradeDescription = ["Keep it up, you understand how to use detergents to treat a clothing.", description].join('\n\n');

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
        description: ["Looks like you'll have to review detergents and how they affect clothing.", description].join('\n\n'),
        info: icon,
      ),
    );
  }
}
