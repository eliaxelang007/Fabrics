import 'package:auto_size_text/auto_size_text.dart';
import 'package:fabrics/pages/menu/section.dart';
import 'package:fabrics/utilities/device_orientation_builder.dart';
import 'package:fabrics/utilities/flex_padded.dart';
import 'package:flutter/material.dart';
import 'package:handy/handy.dart';

class _Section {
  final IconData icon;
  final String title;
  final int maxLines;

  const _Section({required this.icon, required this.title, required this.maxLines});
}

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => DeviceOrientationBuilder(
        builder: (_, Orientation orientation) {
          final landscape = orientation == Orientation.landscape;

          final theme = Theme.of(context);

          final colorScheme = theme.colorScheme;
          final textTheme = theme.textTheme;
          final titleStyle = textTheme.headline3!;
          final subtitleStyle = textTheme.headline6!;

          const sections = [
            _Section(icon: Icons.checkroom_outlined, title: "Fabrics, Fibres, & Weaves", maxLines: 4),
            _Section(icon: Icons.cleaning_services_outlined, title: "Stain Removal", maxLines: 2),
            _Section(icon: Icons.sanitizer_outlined, title: "Detergents", maxLines: 1),
            _Section(icon: Icons.local_laundry_service, title: "Washers & Dryers", maxLines: 3),
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
                                child: AutoSizeText("Select a section to get started.",
                                    maxLines: 1, style: subtitleStyle.copyWith(color: colorScheme.primary, fontStyle: FontStyle.italic)),
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

                        return Section(
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
            body: FlexPadded(
              horizontal: (landscape) ? 120 : 50,
              vertical: 90,
              verticalPadding: (landscape) ? 0 : 1,
              child: child,
            ),
          );
        },
      );
}
