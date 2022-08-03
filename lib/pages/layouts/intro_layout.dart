import 'package:auto_size_text/auto_size_text.dart';
import 'package:fabrics/utilities/device_orientation_builder.dart';
import 'package:fabrics/utilities/flex_padded.dart';
import 'package:flutter/material.dart';

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
    final titleStyle = textTheme.headline3!;
    final descriptionStyle = textTheme.headline6!;

    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: DeviceOrientationBuilder(
        builder: (_, Orientation orientation) {
          bool landscape = orientation == Orientation.landscape;

          return FlexPadded(
            horizontal: (landscape) ? 4 : 14,
            vertical: (landscape) ? 5 : 28,
            child: SizedBox.expand(
              child: ColoredBox(
                color: colorScheme.onBackground,
                child: FlexPadded(
                  vertical: (landscape) ? 5 : 16,
                  horizontal: 3,
                  child: Column(
                    children: [
                      Expanded(
                        flex: (landscape) ? 1 : 2,
                        child: DefaultTextStyle(
                          textAlign: TextAlign.center,
                          style: titleStyle,
                          child: Center(child: title),
                        ),
                      ),
                      const Expanded(child: Center(child: Divider())),
                      Expanded(
                        flex: (landscape) ? 2 : 4,
                        child: DefaultTextStyle(
                          textAlign: TextAlign.center,
                          style: descriptionStyle,
                          child: Center(child: description),
                        ),
                      ),
                      Expanded(
                        flex: (landscape) ? 1 : 2,
                        child: Center(
                          child: AutoSizeText(
                            "Press BEGIN when you're ready to start.",
                            textAlign: TextAlign.center,
                            style: descriptionStyle.copyWith(color: colorScheme.primary),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: SizedBox(
                            width: 130,
                            height: 45,
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
        },
      ),
    );
  }
}
