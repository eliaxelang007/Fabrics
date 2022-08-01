import 'dart:async';
import 'dart:collection';

import 'package:fabrics/3/models/detergent.dart';
import 'package:fabrics/util/list_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:fabrics/3/models/fabric.dart';

final draggedDetergents = ChangeNotifierProvider<SetProvider<Detergent>>((ref) {
  return SetProvider({});
});

//final correct = StateProvider<bool?>((_) => null);

class Test3 extends HookConsumerWidget {
  const Test3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Fabric fabric = ref.watch(testProvider);
    final ThemeData theme = Theme.of(context);

    useEffect(() {
      ref.read(testProvider.notifier).registerCallback(() {
        Navigator.pushNamed(context, "/3/results/");
      });
    }, []);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: SizedBox.expand(
              child: ColoredBox(
                color: const Color(0xffeee5ce),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 100),
                      child: Text(ref.read(testProvider).prompt, style: Theme.of(context).textTheme.headline5)),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Choice(type: Detergent.biologicalDetergent),
                          const Choice(type: Detergent.fabricSoftener),
                        ].map((row) => Expanded(child: row)).toList(),
                      ),
                      Row(
                        children: [
                          const Choice(type: Detergent.nonBiologicalDetergent),
                          const Choice(type: Detergent.laundryBooster),
                        ].map((row) => Expanded(child: row)).toList(),
                      )
                    ].map((row) => Expanded(child: row)).toList(),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Expanded(flex: 5, child: Option()),
                      Expanded(
                        child: Row(
                          children: [
                            const Spacer(),
                            Expanded(
                              flex: 4,
                              child: ElevatedButton(
                                  onPressed: () {
                                    ref.read(draggedDetergents).clear();
                                  },
                                  child: const Text("Reset")),
                            ),
                            const Spacer(),
                            Expanded(
                              flex: 4,
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (ref.read(nextRequestProvider.notifier).state != null) return;

                                    ref.read(testProvider.notifier).isCorrect(ref.read(draggedDetergents).elements);

                                    ref.read(nextRequestProvider.notifier).state ??= Timer(const Duration(seconds: 1), () {
                                      ref.read(testProvider.notifier).next();
                                      ref.read(draggedDetergents).clear();
                                      ref.read(nextRequestProvider.notifier).state = null;
                                    });
                                  },
                                  child: const Text("Submit")),
                            ),
                            const Spacer(),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Choice extends HookConsumerWidget {
  final Detergent type;

  const Choice({required this.type, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final TextStyle headline = textTheme.headline4!.copyWith(color: Colors.white);

    final showCorrect = ref.watch(nextRequestProvider);

    final dragged = ref.watch(draggedDetergents);

    final child = Stack(
      fit: StackFit.passthrough,
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          child: Icon(
            type.icon,
            color: Colors.white,
            size: 85,
          ),
        ),
        if (showCorrect != null)
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
                (ref.read(testProvider).detergents.contains(type)) ? Icons.check_outlined : Icons.close_outlined,
                color: Colors.white,
                size: 85,
              ),
            ),
          )
      ],
    );

    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          Expanded(
            flex: 2,
            child: LayoutBuilder(builder: (_, BoxConstraints constraints) {
              return Draggable<Detergent>(
                data: type,
                // onAccept: (Stain fabric) {
                //   if (ref.read(nextRequestProvider.notifier).state != null) return;

                //   correct.value = ref.read(testProvider.notifier).isCorrect(type);

                //   ref.read(testProvider.notifier).next();

                //   ref.read(nextRequestProvider.notifier).state ??=
                //       Timer(const Duration(seconds: 1), () {
                //     ref.read(nextRequestProvider.notifier).state = null;
                //     correct.value = null;
                //   });
                // },
                feedback: ConstrainedBox(constraints: constraints, child: child),
                childWhenDragging: const SizedBox(),
                child: (dragged.contains(type) && ref.read(nextRequestProvider) == null) ? const SizedBox() : child,
              );
            }),
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
          const Spacer(),
        ],
      ),
    );
  }
}

class Option extends ConsumerWidget {
  const Option({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    //final TextStyle headline = textTheme.headline4!;

    return LayoutBuilder(builder: (_, BoxConstraints constraints) {
      return DragTarget<Detergent>(
        onAccept: (data) {
          ref.read(draggedDetergents).add(data);
        },
        builder: (_, __, ___) {
          return LayoutBuilder(builder: (_, BoxConstraints constraints) {
            return Icon(Icons.local_laundry_service_outlined, size: constraints.maxWidth * 0.92);
          });
        },
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

  bool isCorrect(Set<Detergent> type) {
    bool correct = setEquals(Set.from(state.detergents), type);
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

extension on Detergent {
  IconData get icon {
    switch (this) {
      case Detergent.biologicalDetergent:
        return Icons.sanitizer_outlined;
      case Detergent.fabricSoftener:
        return Icons.bed_outlined;
      case Detergent.laundryBooster:
        return Icons.rocket_launch_outlined;
      case Detergent.nonBiologicalDetergent:
        return Icons.inventory_2;
    }
  }
}
