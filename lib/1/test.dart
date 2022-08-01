import 'dart:async';
import 'dart:collection';

import 'package:fabrics/1/models/fabric_type.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:fabrics/1/models/fabric.dart';

class Test1 extends HookConsumerWidget {
  const Test1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Fabric fabric = ref.watch(testProvider);
    final ThemeData theme = Theme.of(context);

    useEffect(() {
      ref.read(testProvider.notifier).registerCallback(() {
        Navigator.pushNamed(context, "/1/results/");
      });
    }, []);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SizedBox.expand(
              child: ColoredBox(
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Spacer(flex: 4),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Spacer(flex: 7),
                          Expanded(
                            flex: 10,
                            child: Option(fabric: fabric),
                          ),
                          Expanded(
                            flex: 4,
                            child: Center(
                                child: Text(
                                    "Drag the fibre to the correct box.",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: theme.scaffoldBackgroundColor,
                                        fontStyle: FontStyle.italic))),
                          ),
                          const Spacer(flex: 6),
                        ],
                      ),
                    ),
                    const Spacer(flex: 4),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const Spacer(),
                Expanded(
                  flex: 3,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Spacer(),
                      for (FabricType type in FabricType.values) ...[
                        Expanded(
                          flex: 7,
                          child: Choice(type: type),
                        ),
                        const Spacer(),
                      ],
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Choice extends HookConsumerWidget {
  final FabricType type;

  const Choice({required this.type, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final TextStyle headline =
        textTheme.headline4!.copyWith(color: Colors.white);

    final ValueNotifier<bool?> correct = useState(null);

    return DragTarget<Fabric>(
      onAccept: (Fabric fabric) {
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
                  if (correct.value != null)
                    Positioned(
                      top: -42.5,
                      right: -42.5,
                      child: Container(
                        width: 100.0,
                        height: 100.0,
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
                          size: 85,
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
  final Fabric fabric;

  const Option({required this.fabric, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final TextStyle headline = textTheme.headline4!;

    final Widget child = ColoredBox(
      color: Colors.grey[300]!,
      child: Center(
        child: Text(fabric.value, style: headline),
      ),
    );

    return LayoutBuilder(builder: (_, BoxConstraints constraints) {
      return Draggable<Fabric>(
        data: fabric,
        childWhenDragging: const SizedBox(),
        feedback: ConstrainedBox(constraints: constraints, child: child),
        child: child,
      );
    });
  }
}

class TestProvider extends StateNotifier<Fabric> {
  final Queue<void Function()> _callbacks = Queue<void Function()>();
  int _score = 0;
  int _fabricIndex = 0;

  TestProvider() : super(Fabric.values[0]);

  int get rank {
    final int maxScore = Fabric.values.length;
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

  bool isCorrect(FabricType type) {
    bool correct = state.type == type;
    _score += (correct) ? 1 : 0;
    return correct;
  }

  void next() {
    int next = ++_fabricIndex;

    List<Fabric> fabrics = Fabric.values;

    if (next >= fabrics.length) {
      doneCallback();
      return;
    }

    state = fabrics[next];
  }
}

final testProvider = StateNotifierProvider<TestProvider, Fabric>((_) {
  return TestProvider();
});

final nextRequestProvider = StateProvider<Timer?>((_) {
  return null;
});

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
