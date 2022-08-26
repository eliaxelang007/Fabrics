import 'package:fabrics/pages/utilities/responsive/fonts.dart';
import 'package:fabrics/pages/widgets/responsive/oriented_divider.dart';
import 'package:fabrics/pages/widgets/responsive/oriented_flex.dart';
import 'package:fabrics/pages/widgets/responsive/oriented_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handy/handy.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            Expanded(flex: 1, child: _Header()),
            Expanded(flex: 4, child: _Sections()),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final colorScheme = theme.colorScheme;

    final textTheme = theme.textTheme;
    final titleStyle = textTheme.headline4!.responsive.copyWith(color: colorScheme.onBackground);
    final subtitleStyle = textTheme.bodyLarge!.responsive.copyWith(color: colorScheme.onBackground);

    return OrientedFlex(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Menu", style: titleStyle),
        OrientedDivider(thickness: 1.h),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 500.w),
          child: Text(
              [
                "You have to complete all the sections in order.",
                "After you've completed a section, you can move on to the next one.",
              ].join(' '),
              style: subtitleStyle),
        )
      ].inBetween((_) => const OrientedSpacer(8)).toList(),
    );
  }
}

class _Sections extends StatelessWidget {
  const _Sections({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const OrientedFlex(
      children: [],
    );
  }
}
