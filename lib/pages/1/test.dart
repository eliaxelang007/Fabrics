import 'dart:async';
import 'dart:math';

import 'package:fabrics/pages/1/results.dart';
import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:fabrics/utilities/colored_background.dart';

import 'package:fabrics/models/tests/question.dart';
import 'package:fabrics/providers/test_provider.dart';

import 'package:fabrics/pages/1/models/fabric.dart';
import 'package:fabrics/pages/1/models/fabric_type.dart';
import 'package:fabrics/pages/widgets/checkmark.dart';

final testProvider = ChangeNotifierProvider(
  (_) => TestProvider(
    [
      for (final fabric in Fabric.values) Question(prompt: fabric, answer: fabric.type),
    ],
  ),
);

class Test extends HookConsumerWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    final landscape = MediaQuery.of(context).orientation == Orientation.landscape;

    final testData = ref.watch(testProvider);
    final fabric = testData.current;

    final complete = ref.watch(_completeProvider);

    useEffect(
      () {
        if (!complete) return;

        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            Navigator.push<void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const Results(),
              ),
            );
          },
        );
      },
    );

    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: Column(
        children: [
          Expanded(
            child: ColoredBackground(
              color: colorScheme.background,
              child: Center(
                child: _Fabric(
                  fabric: fabric,
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
      child: Center(
        child: AutoSizeText(
          fabric.value,
          style: (landscape) ? largeStyle : smallSize,
        ),
      ),
    );

    return Draggable<Fabric>(data: fabric, feedback: child, child: child);
  }
}

class _FabricType extends HookConsumerWidget {
  final FabricType type;

  const _FabricType({required this.type, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final colorScheme = theme.colorScheme;

    final textTheme = theme.textTheme;
    final nameStyle = textTheme.headline4!;

    final correctState = useState<bool?>(null);
    final correct = correctState.value;

    final test = ref.watch(testProvider);

    final landscape = MediaQuery.of(context).orientation == Orientation.landscape;

    final checkmarkSize = (landscape) ? 70.0 : 60.0;

    return DragTarget<Fabric>(
      onAccept: (_) {
        if (ref.read(_nextRequestProvider) != null) return;

        correctState.value = test.isCorrect(type);
        if (!ref.read(testProvider).moveNext()) {
          ref.read(_completeProvider.notifier).state = true;
        }

        ref.read(_nextRequestProvider.notifier).state = Timer(
          const Duration(seconds: 1),
          () {
            correctState.value = null;
            ref.read(_nextRequestProvider.notifier).state = null;
          },
        );
      },
      builder: (_, __, ___) => Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: Center(
                child: _DragBox(
                  color: Colors.black.withAlpha((255 * 0.15).toInt()),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      if (correct != null)
                        Positioned(
                          top: -(checkmarkSize * 0.4),
                          right: -(checkmarkSize * 0.4),
                          child: SizedBox(
                            width: checkmarkSize,
                            height: checkmarkSize,
                            child: Checkmark(correct),
                          ),
                        ),
                      Positioned.fill(
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
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
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

final _nextRequestProvider = StateProvider<Timer?>((_) => null);
final _completeProvider = StateProvider((_) => false);
