import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:fabrics/utilities/flex_padded.dart';
import 'package:fabrics/utilities/colored_background.dart';

import 'package:fabrics/pages/widgets/checkmark.dart';

class Feedback {
  final String title;
  final String description;
  final Widget info;

  const Feedback({required this.title, required this.description, required this.info});
}

class ResultsLayout extends StatelessWidget {
  final double grade;

  final Feedback perfect;
  final Feedback almost;
  final Feedback tryAgain;

  const ResultsLayout({
    required this.grade,
    required this.perfect,
    required this.almost,
    required this.tryAgain,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final colorScheme = theme.colorScheme;

    final textTheme = theme.textTheme;
    final titleStyle = textTheme.headline3!;
    final descriptionStyle = textTheme.headline6!;

    final checked = (grade >= 0.79);
    final feedback = (grade >= 1.00) ? perfect : ((checked) ? almost : tryAgain);

    final landscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: FlexPadded(
        childHorizontal: (landscape) ? 6 : 14,
        childVertical: (landscape) ? 7 : 28,
        child: ColoredBackground(
          color: colorScheme.background,
          child: FlexPadded(
            childHorizontal: 19,
            childVertical: 15,
            child: Flex(
              direction: (landscape) ? Axis.horizontal : Axis.vertical,
              children: [
                Expanded(
                  flex: (landscape) ? 9 : 35,
                  child: FlexPadded(
                    top: 0,
                    left: 0,
                    bottom: 0,
                    right: (landscape) ? 1 : 0,
                    childHorizontal: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (landscape) const Spacer(),
                        Expanded(
                          flex: 2,
                          child: Checkmark(checked),
                        ),
                        Expanded(
                          flex: 4,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: AutoSizeText(
                              feedback.title,
                              style: titleStyle,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: AutoSizeText(
                            overflow: TextOverflow.visible,
                            feedback.description,
                            style: descriptionStyle,
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          flex: 2,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
                              },
                              child: Text("BACK TO MENU", style: descriptionStyle.copyWith(color: colorScheme.onPrimary)),
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 12,
                  child: SizedBox.expand(
                    child: FittedBox(
                      child: feedback.info,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
