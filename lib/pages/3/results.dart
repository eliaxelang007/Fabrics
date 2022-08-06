// import 'package:fabrics/pages/3/test.dart';
// import 'package:fabrics/pages/layouts/results_layout.dart';
// import 'package:flutter/material.dart' hide Feedback;
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// class Results3 extends ConsumerWidget {
//   const Results3({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final test = ref.read(testProvider);

//     final description = [
//       "If we understand the most appropriate methods for treating a stain, we can remove it as effectively as possible without damaging the fabric.",
//       "In the next module, we'll explore how detergents can help us with the stain removal process."
//     ].join('\n\n');

//     final almostGradeDescription = ["Good job, you know how to treat a stain.", description].join('\n\n');

//     const icon = Icon(Icons.sanitizer_outlined);

//     return ResultsLayout(
//       grade: test.grade,
//       perfect: Feedback(
//         title: "Well done",
//         description: almostGradeDescription,
//         info: icon,
//       ),
//       almost: Feedback(
//         title: "Almost",
//         description: almostGradeDescription,
//         info: icon,
//       ),
//       tryAgain: Feedback(
//         title: "Try again",
//         description: ["Looks like you'll have to review stains and how to remove them.", description].join('\n\n'),
//         info: icon,
//       ),
//     );
//   }
// }
