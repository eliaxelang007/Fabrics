import 'package:fabrics/utilities/colored_background.dart';
import 'package:flutter/material.dart';

import 'package:fabrics/utilities/flex_padded.dart';
import 'package:fabrics/utilities/fit.dart';

class Section extends StatelessWidget {
  final Widget icon;
  final Widget title;
  final Widget description;
  final void Function()? onTap;

  const Section({required this.icon, required this.title, required this.description, this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final titleStyle = textTheme.headline3!;

    final landscape = MediaQuery.of(context).orientation == Orientation.landscape;

    final descriptionStyle = (landscape) ? textTheme.headline4! : textTheme.headline5!;

    final iconSize = (landscape) ? 200.0 : 100.0;

    final children = [
      Expanded(
        flex: 3,
        child: LayoutBuilder(
          builder: (_, BoxConstraints constraints) => Stack(
            fit: StackFit.passthrough,
            children: [
              Positioned(
                top: constraints.maxHeight * 0.2,
                left: constraints.maxWidth * 0.5,
                child: Fit(
                  width: iconSize,
                  height: iconSize,
                  child: icon,
                ),
              ),
              Align(
                alignment: const FractionalOffset(0.04, 1.0),
                child: DefaultTextStyle(
                  style: titleStyle,
                  child: title,
                ),
              ),
            ],
          ),
        ),
      ),
      Expanded(
        flex: (landscape) ? 1 : 3,
        child: Ink(
          child: ColoredBackground(
            color: colorScheme.primary,
            child: FlexPadded(
              childHorizontal: 10,
              childVertical: 90,
              child: DefaultTextStyle(
                style: descriptionStyle.copyWith(
                  color: colorScheme.onPrimary,
                ),
                child: Align(alignment: Alignment.centerLeft, child: description),
              ),
            ),
          ),
        ),
      ),
    ];

    return InkWell(
        onTap: onTap,
        child: Flex(
          direction: (landscape) ? Axis.vertical : Axis.horizontal,
          children: (landscape) ? children : children.reversed.toList(),
        ));
  }
}
