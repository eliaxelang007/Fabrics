// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:math';

import 'package:fabrics/observers.dart';
import 'package:fabrics/pages/4/models/cloth_property.dart';
import 'package:fabrics/pages/4/results.dart';
import 'package:fabrics/pages/hooks/use_routes.dart';
import 'package:fabrics/providers/ordered_set_provider.dart';
import 'package:fabrics/utilities/debug.dart';
import 'package:fabrics/utilities/flex_padded.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:fabrics/utilities/colored_background.dart';

import 'package:fabrics/providers/test_provider.dart';
import 'package:fabrics/models/tests/question.dart';

//import 'package:fabrics/pages/1/models/fabric_type.dart';
import 'package:fabrics/pages/1/models/fabric.dart';
import 'package:ordered_set/ordered_set.dart';
//import 'package:fabrics/pages/1/results.dart';

final _nextRequestProvider = StateProvider<Timer?>((_) => null);
final _completeProvider = StateProvider((_) => false);

final _separateByProvider = ChangeNotifierProvider((_) => SetProvider<ClothProperty>(OrderedSet((a, b) => a == b ? 0 : 1)));
final _dontSeparateByProvider = ChangeNotifierProvider((_) => SetProvider<ClothProperty>(OrderedSet((a, b) => a == b ? 0 : 1)));

final testProvider = ChangeNotifierProvider(
  (ref) {
    return TestProvider(
      [
        for (final fabric in Fabric.values) Question(prompt: fabric, answer: fabric.type),
      ],
    );
  },
);

class Test4 extends HookConsumerWidget {
  const Test4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final colorScheme = theme.colorScheme;

    final textTheme = theme.textTheme;
    final titleStyle = textTheme.headline3!;
    final subtitleStyle = textTheme.headline5!;

    final landscape = MediaQuery.of(context).orientation == Orientation.landscape;

    final testData = ref.watch(testProvider);
    final fabric = testData.current;

    final complete = ref.watch(_completeProvider);

    final separateBy = ref.watch(_separateByProvider);
    final dontSeparateBy = ref.watch(_dontSeparateByProvider);

    useEffect(() {
      if (!complete) return;

      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const Results4(),
            ),
          );
        },
      );
    }, [complete]);

    useRoutes(routeObserver, onPop: () {});

    return Scaffold(
      body: Flex(
        direction: (landscape) ? Axis.horizontal : Axis.vertical,
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      "Don't separate",
                      style: (landscape) ? subtitleStyle : subtitleStyle.copyWith(fontSize: subtitleStyle.fontSize! * 0.6),
                    ),
                  ),
                ),
                Expanded(
                  flex: 12,
                  child: _Section(_dontSeparateByProvider),
                ),
              ],
            ),
          ),
          Expanded(
            child: ColoredBackground(
              color: colorScheme.secondary,
              child: FlexPadded(
                childHorizontal: (landscape) ? 18 : 40,
                childVertical: 27,
                child: Flex(
                  direction: (landscape) ? Axis.vertical : Axis.horizontal,
                  children: [
                    Expanded(
                      flex: (landscape) ? 3 : 15,
                      child: DefaultTextStyle(
                        style: DefaultTextStyle.of(context).style,
                        textAlign: TextAlign.center,
                        child: Column(
                          children: [
                            if (!landscape) const Spacer(),
                            Expanded(
                              flex: (landscape) ? 3 : 7,
                              child: Align(
                                alignment: (landscape) ? Alignment.center : Alignment.bottomCenter,
                                child: Text(
                                  "TO SEPARATE OR NOT",
                                  style: (landscape) ? titleStyle : titleStyle.copyWith(fontSize: titleStyle.fontSize! * 0.5),
                                ),
                              ),
                            ),
                            const Divider(),
                            if (landscape)
                              Expanded(
                                flex: 3,
                                child: Center(
                                  child: Text(
                                    "Decide if the following items should be separated into the following categories.",
                                    style: subtitleStyle,
                                  ),
                                ),
                              ),
                            Expanded(
                              flex: (landscape) ? 3 : 6,
                              child: Align(
                                alignment: (landscape) ? Alignment.center : Alignment.topCenter,
                                child: Text(
                                  "Drag each statement to the correct section, then select SUBMIT.",
                                  style: ((landscape) ? subtitleStyle : subtitleStyle.copyWith(fontSize: subtitleStyle.fontSize! * 0.6))
                                      .copyWith(color: colorScheme.primary, fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                            if (!landscape) const Spacer(),
                          ],
                        ),
                      ),
                    ),
                    if (!landscape) const Spacer(),
                    Expanded(
                      flex: (landscape) ? 1 : 15,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              "SUBMIT",
                              style: ((landscape) ? subtitleStyle : subtitleStyle.copyWith(fontSize: subtitleStyle.fontSize! * 0.6))
                                  .copyWith(color: colorScheme.onPrimary),
                            ),
                          ),
                          for (final property in ClothProperty.values)
                            if (!separateBy.contains(property) && !dontSeparateBy.contains(property)) _DraggableClothProperty(property),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      "Separate",
                      style: (landscape) ? subtitleStyle : subtitleStyle.copyWith(fontSize: subtitleStyle.fontSize! * 0.6),
                    ),
                  ),
                ),
                Expanded(
                  flex: 12,
                  child: _Section(_separateByProvider),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Section extends ConsumerWidget {
  final ChangeNotifierProvider<SetProvider<ClothProperty>> groupProvider;

  const _Section(this.groupProvider, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final landscape = MediaQuery.of(context).orientation == Orientation.landscape;

    final group = ref.watch(groupProvider);

    return Flex(
      direction: (landscape) ? Axis.vertical : Axis.horizontal,
      children: List.generate(
        2,
        (_) => Expanded(
          child: Column(
            children: List.generate(
              2,
              (_) => Expanded(
                child: Center(
                  child: _Target(
                    onAccept: (property) {
                      group.add(property);
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Target extends StatelessWidget {
  final void Function(ClothProperty) onAccept;

  const _Target({required this.onAccept, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DragTarget<ClothProperty>(
      onAccept: onAccept,
      builder: (_, __, ___) => _DragBox(
        color: Colors.transparent.withAlpha((255 * 0.2).toInt()),
        child: const SizedBox(),
      ),
    );
  }
}

class _DraggableClothProperty extends StatelessWidget {
  final ClothProperty property;

  const _DraggableClothProperty(this.property, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final child = _ClothProperty(property);
    return Draggable(data: property, childWhenDragging: const SizedBox(), feedback: child, child: child);
  }
}

class _ClothProperty extends StatelessWidget {
  final ClothProperty property;

  const _ClothProperty(this.property, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.headline5;

    return _DragBox(
      color: Colors.white,
      child: Center(
        child: Text(property.value, style: titleStyle),
      ),
    );
  }
}

class _DragBox extends StatelessWidget {
  final Color color;
  final Widget child;

  const _DragBox({required this.color, required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaInfo = MediaQuery.of(context);
    final landscape = mediaInfo.orientation == Orientation.landscape;

    final screenWidth = mediaInfo.size.width;
    final maxWidth = (landscape) ? (screenWidth / 3) : (screenWidth / 2);

    final width = min((landscape) ? 318.0 : 200.0, maxWidth);

    final height = width * 0.40880503144;

    return Padding(
      padding: EdgeInsets.all(7),
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                child: ColoredBox(
                  color: color,
                ),
              ),
            ),
            child
          ],
        ),
      ),
    );
  }
}
