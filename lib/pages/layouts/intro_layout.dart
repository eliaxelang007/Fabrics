import 'package:auto_size_text/auto_size_text.dart';
import 'package:fabrics/utilities/colored_background.dart';
import 'package:fabrics/utilities/flex_padded.dart';
import 'package:fabrics/utilities/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroLayout extends StatelessWidget {
  final Widget title;
  final Widget description;
  final void Function() onBegin;

  const IntroLayout({required this.title, required this.description, required this.onBegin, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final colorScheme = theme.colorScheme;

    final textTheme = theme.textTheme;
    final titleStyle = textTheme.headline3!.responsive;
    final descriptionStyle = textTheme.headline6!.responsive;

    final landscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: FlexPadded(
        childHorizontal: (landscape) ? 4 : 14,
        childVertical: (landscape) ? 5 : 28,
        child: ColoredBackground(
          color: colorScheme.background,
          child: FlexPadded(
            childHorizontal: (landscape) ? 5 : 16,
            childVertical: (landscape) ? 3 : 10,
            child: Column(
              children: [
                Expanded(
                  flex: (landscape) ? 1 : 2,
                  child: DefaultTextStyle(
                    textAlign: TextAlign.center,
                    style: titleStyle,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: title,
                      ),
                    ),
                  ),
                ),
                const Expanded(child: Center(child: Divider())),
                Expanded(
                  flex: (landscape) ? 2 : 4,
                  child: DefaultTextStyle(
                    textAlign: TextAlign.center,
                    style: descriptionStyle,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: description,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: (landscape) ? 1 : 2,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: AutoSizeText(
                        "Press BEGIN when you're ready to start.",
                        textAlign: TextAlign.center,
                        style: descriptionStyle.copyWith(color: colorScheme.primary, fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: SizedBox(
                      width: 140.w,
                      height: 45.h,
                      child: ElevatedButton(
                        onPressed: onBegin,
                        child: Text("BEGIN", style: descriptionStyle.copyWith(color: colorScheme.onPrimary)),
                      ),
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
