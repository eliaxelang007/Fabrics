import 'dart:async';

import 'package:fabrics/observers.dart';
import 'package:fabrics/pages/2/results.dart';
import 'package:fabrics/pages/hooks/use_routes.dart';
import 'package:fabrics/pages/widgets/checkmark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:fabrics/providers/test_provider.dart';
import 'package:fabrics/models/tests/question.dart';

import 'package:fabrics/pages/2/models/stain_remover.dart';
import 'package:fabrics/pages/2/models/stain.dart';
import 'package:fabrics/pages/widgets/circle.dart';

final _nextRequestProvider = StateProvider<Timer?>((_) => null);
final _completeProvider = StateProvider((_) => false);

final testProvider = ChangeNotifierProvider(
  (_) => TestProvider(
    [
      for (final stain in Stain.values) Question(prompt: stain, answer: stain.remover),
    ],
  ),
);

class Test2 extends HookConsumerWidget {
  const Test2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    final testData = ref.watch(testProvider);
    final stain = testData.current;

    final complete = ref.watch(_completeProvider);

    useEffect(() {
      if (!complete) return;

      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          Navigator.push<void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const Results2(),
            ),
          );
        },
      );
    }, [complete]);

    useRoutes(routeObserver, onPop: () {});

    final landscape = MediaQuery.of(context).orientation == Orientation.landscape;

    final stainWidget = Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      _Stain(stain.prompt),
      const SizedBox(height: 5),
      Text(
        "Drag the stain to the correct box.",
        style: TextStyle(color: colorScheme.onPrimary, fontStyle: FontStyle.italic, fontSize: (landscape) ? 20 : 14),
      )
    ]);

    final children = <Widget>[
      const Align(
        alignment: FractionalOffset(0.2, 0.1),
        child: _StainRemover(StainRemover.sponging),
      ),
      const Align(
        alignment: FractionalOffset(0.1, 0.5),
        child: _StainRemover(StainRemover.brushing),
      ),
      const Align(
        alignment: FractionalOffset(0.2, 1 - 0.1),
        child: _StainRemover(StainRemover.preSoaking),
      ),
      const Align(
        alignment: FractionalOffset(1 - 0.2, 1 - 0.1),
        child: _StainRemover(StainRemover.flushing),
      ),
      const Align(
        alignment: FractionalOffset(1 - 0.1, 0.5),
        child: _StainRemover(StainRemover.spatula),
      ),
      const Align(
        alignment: FractionalOffset(1 - 0.2, 0.1),
        child: _StainRemover(StainRemover.freezing),
      ),
    ];

    if (landscape) children.add(Center(child: stainWidget));

    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: Column(
        children: [
          if (!landscape) Expanded(child: stainWidget),
          Expanded(
            flex: (landscape) ? 1 : 4,
            child: Stack(
              fit: StackFit.passthrough,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}

class _StainRemover extends HookConsumerWidget {
  final StainRemover remover;

  const _StainRemover(this.remover, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final colorScheme = theme.colorScheme;

    final textTheme = theme.textTheme;
    final titleStyle = textTheme.headline5!;
    final smallTitleStyle = textTheme.bodyMedium!;

    final landscape = MediaQuery.of(context).orientation == Orientation.landscape;

    final size = (landscape) ? 140.0 : 80.0;
    final checkmarkSize = (landscape) ? 70.0 : 60.0;

    final correctState = useState<bool?>(null);
    final correct = correctState.value;

    final test = ref.watch(testProvider);

    return SizedBox(
      width: size,
      height: (landscape) ? size : size * 1.9,
      child: Column(
        children: [
          Expanded(
            flex: 10,
            child: DragTarget<Stain>(
              onAccept: (stain) {
                if (ref.read(_nextRequestProvider) != null) return;

                correctState.value = test.isCorrect(remover);
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
              builder: (_, __, ___) => Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(
                    child: _DragCircle(
                      color: colorScheme.background,
                      child: Icon(remover.icon, color: colorScheme.onBackground),
                    ),
                  ),
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
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                remover.value,
                style: ((landscape) ? titleStyle : smallTitleStyle).copyWith(color: colorScheme.onPrimary),
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _Stain extends StatelessWidget {
  final Stain stain;

  const _Stain(this.stain, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final colorScheme = theme.colorScheme;

    final textTheme = theme.textTheme;
    final titleStyle = textTheme.headline4!;
    final smallTitleStyle = textTheme.headline6!;

    final landscape = MediaQuery.of(context).orientation == Orientation.landscape;

    final size = (landscape) ? 190.0 : 100.0;

    final child = SizedBox(
      width: size,
      height: size,
      child: Circle(
        decoration: BoxDecoration(color: colorScheme.secondary),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            stain.value,
            style: ((landscape) ? titleStyle : smallTitleStyle).copyWith(color: colorScheme.onSecondary),
          ),
        ),
      ),
    );

    return Draggable<Object>(
      data: Stain.bubblegum,
      feedback: child,
      childWhenDragging: const SizedBox(),
      child: child,
    );
  }
}

class _DragCircle extends StatelessWidget {
  final Color color;
  final Widget child;

  const _DragCircle({required this.child, this.color = const Color(0xff00779a), Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Circle(
      decoration: BoxDecoration(color: color),
      child: Center(
        child: child,
      ),
    );
  }
}

extension on StainRemover {
  IconData get icon {
    switch (this) {
      case StainRemover.sponging:
        return Icons.crop_16_9_outlined;
      case StainRemover.brushing:
        return Icons.brush_outlined;
      case StainRemover.preSoaking:
        return Icons.format_color_fill_outlined;
      case StainRemover.flushing:
        return Icons.storm_outlined;
      case StainRemover.spatula:
        return Icons.cleaning_services_outlined;
      case StainRemover.freezing:
        return Icons.ac_unit_outlined;
    }
  }
}
