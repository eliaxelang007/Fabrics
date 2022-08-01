import 'dart:async';
import 'dart:collection';

import 'package:fabrics/2/models/stain_remover.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:fabrics/2/models/stain.dart';

class Test2 extends HookConsumerWidget {
  const Test2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Stain fabric = ref.watch(testProvider);
    final ThemeData theme = Theme.of(context);

    useEffect(() {
      ref.read(testProvider.notifier).registerCallback(() {
        Navigator.pushNamed(context, "/2/results/");
      });
    }, []);

    const double verticalDistance = 30;

    return Scaffold(
      body: Stack(
        fit: StackFit.passthrough,
        children: [
          Center(child: Option(fabric: fabric)),
          const Positioned(
              top: verticalDistance,
              left: 300,
              child: Choice(type: StainRemover.sponging)),
          const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.only(left: 100),
                  child: Choice(type: StainRemover.brushing))),
          const Positioned(
              bottom: verticalDistance,
              left: 300,
              child: Choice(type: StainRemover.preSoaking)),
          const Positioned(
              top: verticalDistance,
              right: 300,
              child: Choice(type: StainRemover.flushing)),
          const Align(
              alignment: Alignment.centerRight,
              child: Padding(
                  padding: EdgeInsets.only(right: 100),
                  child: Choice(type: StainRemover.spatula))),
          const Positioned(
              bottom: verticalDistance,
              right: 300,
              child: Choice(type: StainRemover.freezing)),
        ],
      ),
    );
  }
}

class Choice extends HookConsumerWidget {
  final StainRemover type;

  const Choice({required this.type, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final TextStyle headline =
        textTheme.headline4!.copyWith(color: Colors.white);

    final ValueNotifier<bool?> correct = useState(null);

    return DragTarget<Stain>(
      onAccept: (Stain fabric) {
        if (ref.read(nextRequestProvider.notifier).state != null) return;

        correct.value = ref.read(testProvider.notifier).isCorrect(type);

        ref.read(testProvider.notifier).next();

        ref.read(nextRequestProvider.notifier).state ??=
            Timer(const Duration(seconds: 1), () {
          ref.read(nextRequestProvider.notifier).state = null;
          correct.value = null;
        });
      },
      builder: (_, __, ___) => SizedBox(
        width: 250,
        height: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                fit: StackFit.passthrough,
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ColoredBox(
                        color: Colors.transparent.withAlpha(
                          (255 * 0.2).toInt(),
                        ),
                        child: Icon(
                          type.icon,
                          color: Colors.white,
                          size: 85,
                        ),
                      ),
                    ),
                  ),
                  if (correct.value != null)
                    Positioned(
                      top: -1,
                      right: -1,
                      child: Container(
                        width: 75,
                        height: 65,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xff00779a),
                          border: Border.all(
                            color: Colors.white,
                            width: 4.0,
                          ),
                        ),
                        child: Icon(
                          (correct.value!)
                              ? Icons.check_outlined
                              : Icons.close_outlined,
                          color: Colors.white,
                          size: 58,
                        ),
                      ),
                    )
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  type.value,
                  style: headline,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Option extends StatelessWidget {
  final Stain fabric;

  const Option({required this.fabric, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final TextStyle headline = textTheme.headline4!;

    final Widget child = Container(
      width: 200,
      height: 200,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xff00779a),
      ),
      child: Center(
        child: Text(
          fabric.value,
          style: headline.copyWith(color: Colors.white),
        ),
      ),
    );

    return LayoutBuilder(builder: (_, BoxConstraints constraints) {
      return Draggable<Stain>(
        data: fabric,
        childWhenDragging: const SizedBox(),
        feedback: ConstrainedBox(constraints: constraints, child: child),
        child: child,
      );
    });
  }
}

class TestProvider extends StateNotifier<Stain> {
  final Queue<void Function()> _callbacks = Queue<void Function()>();
  int _score = 0;
  int _fabricIndex = 0;

  TestProvider() : super(Stain.values[0]);

  int get rank {
    final int maxScore = Stain.values.length;
    final int almostScore = maxScore - 1;

    return (_score >= maxScore)
        ? 1
        : (_score >= almostScore)
            ? 2
            : 3;
  }

  void registerCallback(void Function() callback) {
    _callbacks.add(callback);
  }

  void doneCallback() {
    while (_callbacks.isNotEmpty) {
      void Function() callback = _callbacks.removeLast();
      callback();
    }
  }

  bool isCorrect(StainRemover type) {
    bool correct = state.remover == type;
    _score += (correct) ? 1 : 0;
    return correct;
  }

  void next() {
    int next = ++_fabricIndex;

    List<Stain> fabrics = Stain.values;

    if (next >= fabrics.length) {
      doneCallback();
      return;
    }

    state = fabrics[next];
  }
}

final testProvider = StateNotifierProvider<TestProvider, Stain>((_) {
  return TestProvider();
});

final nextRequestProvider = StateProvider<Timer?>((_) {
  return null;
});

extension on StainRemover {
  IconData get icon {
    switch (this) {
      case StainRemover.sponging:
        return Icons.rectangle;
      case StainRemover.brushing:
        return Icons.brush_outlined;
      case StainRemover.preSoaking:
        return Icons.format_color_fill;
      case StainRemover.flushing:
        return Icons.storm_outlined;
      case StainRemover.spatula:
        return Icons.cleaning_services;
      case StainRemover.freezing:
        return Icons.ac_unit_outlined;
    }
  }
}
