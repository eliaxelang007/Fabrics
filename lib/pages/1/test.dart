import 'dart:math';

import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:fabrics/utilities/colored_background.dart';

import 'package:fabrics/providers/test_provider.dart';

import 'package:fabrics/models/tests/question.dart';

import 'package:fabrics/pages/1/models/fabric.dart';
import 'package:fabrics/pages/1/models/fabric_type.dart';

final testProvider = ChangeNotifierProvider(
  (_) => TestProvider(
    [
      for (final fabric in Fabric.values) Question(prompt: fabric, answer: fabric.type),
    ],
  ),
);

final smallestBoxProvider = StateProvider((_) => -1.0);

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final landscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: Column(
        children: [
          Expanded(
            child: ColoredBackground(
              color: colorScheme.background,
              child: const Center(
                child: _Fabric(
                  fabric: Fabric.cotton,
                ),
              ),
            ),
          ),
          Expanded(
            flex: (landscape) ? 1 : 4,
            child: Flex(
              direction: (landscape) ? Axis.horizontal : Axis.vertical,
              children: [
                for (final fabricType in FabricType.values) Center(child: _FabricType(type: fabricType)),
              ].map<Widget>((widget) => Expanded(flex: 100, child: widget)).toList(),
            ),
          )
        ],
      ),
    );
  }
}

class _Fabric extends StatelessWidget {
  final Fabric fabric;

  const _Fabric({required this.fabric, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final largeStyle = textTheme.headline3!;
    final smallSize = textTheme.headline4!;

    final landscape = MediaQuery.of(context).orientation == Orientation.landscape;

    final child = _DragBox(
      color: const Color(0xffededed),
      child: AutoSizeText(fabric.value, style: (landscape) ? largeStyle : smallSize),
    );

    return Draggable<Fabric>(data: fabric, feedback: child, child: child);
  }
}

class _FabricType extends StatelessWidget {
  final FabricType type;

  const _FabricType({required this.type, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final nameStyle = textTheme.headline4!;

    final landscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return DragTarget<Fabric>(
      onAccept: (fabric) {
        debugPrint("$type: ${fabric.value}");
      },
      builder: (_, __, ___) => Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 1, // (landscape) ? 6 : 20
              child: Center(
                child: _DragBox(
                  color: Colors.black.withAlpha((255 * 0.15).toInt()),
                  child: SizedBox.expand(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Icon(
                          type.icon,
                          color: colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1, // (landscape) ? 2 : 6
              child: AutoSizeText(type.value, style: nameStyle.copyWith(color: colorScheme.onPrimary)),
            ),
          ],
        ),
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

    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(6.0)),
        child: ColoredBackground(
          color: color,
          child: Center(child: child),
        ),
      ),
    );
  }
}

extension on FabricType {
  IconData get icon {
    switch (this) {
      case FabricType.natural:
        return Icons.eco_outlined;
      case FabricType.manMade:
        return Icons.memory_outlined;
      case FabricType.mineral:
        return Icons.diamond;
    }
  }
}
