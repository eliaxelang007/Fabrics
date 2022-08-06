import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:handy/handy.dart';

import 'package:fabrics/utilities/colored_background.dart';
import 'package:fabrics/utilities/flex_padded.dart';
import 'package:fabrics/utilities/fit.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final landscape = MediaQuery.of(context).orientation == Orientation.landscape;

    final theme = Theme.of(context);

    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final titleStyle = textTheme.headline3!;
    final subtitleStyle = textTheme.headline6!;

    const sections = [
      _SectionData(icon: Icons.dry_cleaning_outlined, title: "Fabrics, Fibres, & Weaves", maxLines: 4),
      _SectionData(icon: Icons.cleaning_services_outlined, title: "Stain Removal", maxLines: 2),
      _SectionData(icon: Icons.sanitizer_outlined, title: "Detergents", maxLines: 1),
      _SectionData(icon: Icons.local_laundry_service, title: "Washers & Dryers", maxLines: 3),
    ];

    final child = Column(
      children: <Widget>[
        Expanded(
          flex: 15,
          child: Flex(
            direction: (landscape) ? Axis.horizontal : Axis.vertical,
            children: [
              const Spacer(),
              Expanded(
                flex: 12,
                child: Center(child: AutoSizeText("Menu", style: titleStyle, maxLines: 1)),
              ),
              Expanded(flex: 1, child: ((landscape ? VerticalDivider.new : Divider.new)(color: colorScheme.onSecondary))),
              Expanded(
                flex: 25,
                child: DefaultTextStyle(
                  style: subtitleStyle,
                  child: Column(
                    children: [
                      const Spacer(),
                      Expanded(
                        flex: 6,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: AutoSizeText(
                            [
                              "You have to complete all the sections in order.",
                              "After you've completed a section, you can move on to the next one.",
                            ].join(' '),
                            maxLines: 3,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: AutoSizeText(
                            "Select a section to get started.",
                            maxLines: 1,
                            style: subtitleStyle.copyWith(
                              color: colorScheme.primary,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Spacer()
            ],
          ),
        ),
        Expanded(
          flex: 60,
          child: Flex(
            direction: (landscape) ? Axis.horizontal : Axis.vertical,
            children: [
              for (int i = 0; i < sections.length; i++)
                (() {
                  final section = sections[i];
                  final number = i + 1;

                  return _Section(
                    icon: Icon(section.icon),
                    title: Text("$number".padLeft(2, '0')),
                    description: AutoSizeText(section.title, maxLines: section.maxLines),
                    onTap: () {
                      Navigator.pushNamed(context, "/$number");
                    },
                  );
                })(),
            ].map<Widget>((widget) => Expanded(flex: 20, child: widget)).inBetween((_) => const Spacer()).toList(),
          ),
        )
      ].inBetween((_) => const Spacer()).toList(),
    );

    return Scaffold(
      body: FlexPadded.symmetrical(
        childHorizontal: (landscape) ? 120 : 50,
        childVertical: 90,
        vertical: (landscape) ? 0 : 1,
        child: child,
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final Widget icon;
  final Widget title;
  final Widget description;
  final void Function()? onTap;

  const _Section({required this.icon, required this.title, required this.description, this.onTap, Key? key}) : super(key: key);

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

class _SectionData {
  final IconData icon;
  final String title;
  final int maxLines;

  const _SectionData({required this.icon, required this.title, required this.maxLines});
}
