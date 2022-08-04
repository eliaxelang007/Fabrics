import 'package:fabrics/pages/1/test.dart';
import 'package:fabrics/pages/layouts/results_layout.dart';
import 'package:flutter/material.dart' hide Feedback;
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Results extends ConsumerWidget {
  const Results({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final test = ref.read(testProvider);

    final description = [
      "If we understand where fabrics originate, we can choose the best-suited laundering and stain removal processes.",
      "We'll go into detail about stain removal methods in the next module."
    ].join('\n\n');

    final almostGradeDescription = ["It seems that you know the source of your fabrics.", description].join('\n\n');

    return ResultsLayout(
      grade: test.grade,
      perfect: Feedback(
        title: "Well done",
        description: almostGradeDescription,
        info: const Icon(Icons.dry_cleaning),
      ),
      almost: Feedback(
        title: "Almost",
        description: almostGradeDescription,
        info: const Icon(Icons.dry_cleaning),
      ),
      tryAgain: Feedback(
        title: "Try again",
        description: ["Looks like you'll have to review fabrics and their types.", description].join('\n\n'),
        info: const Icon(Icons.dry_cleaning),
      ),
    );
  }
}
