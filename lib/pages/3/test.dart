import 'dart:async';

import 'package:fabrics/models/tests/question.dart';
import 'package:fabrics/observers.dart';
import 'package:fabrics/pages/3/models/detergent.dart';
import 'package:fabrics/pages/3/models/cloth.dart';
import 'package:fabrics/pages/3/results.dart';
import 'package:fabrics/pages/hooks/use_routes.dart';
import 'package:fabrics/pages/widgets/checkmark.dart';
import 'package:fabrics/providers/ordered_set_provider.dart';
import 'package:fabrics/providers/test_provider.dart';
import 'package:fabrics/utilities/colored_background.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:ordered_set/ordered_set.dart';

final _completeProvider = StateProvider((_) => false);
final _nextRequestProvider = StateProvider<Timer?>((_) => null);

final testProvider = ChangeNotifierProvider(
  (_) => TestProvider(
    [
      for (final cloth in Cloth.values) Question(prompt: cloth.prompt, answer: cloth.detergents),
    ],
    checkAnswer: (Set<Detergent> possibleAnswer, Set<Detergent> correctAnswer) {
      if (possibleAnswer.length != correctAnswer.length) return false;
      return correctAnswer.containsAll(possibleAnswer);
    },
  ),
);

final inWashingMachineProvider = ChangeNotifierProvider((_) => SetProvider<Detergent>(OrderedSet()));

class Test3 extends HookConsumerWidget {
  const Test3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final textTheme = theme.textTheme;

    final titleStyle = textTheme.headline3!.copyWith(color: colorScheme.onPrimary);
    final smallTitleStyle = textTheme.headline5!.copyWith(color: colorScheme.onPrimary);

    final subtitleStyle = textTheme.headline6!.copyWith(color: colorScheme.onPrimary);
    final smallSubtitleStyle = textTheme.bodyMedium!.copyWith(color: colorScheme.onPrimary);

    final testData = ref.watch(testProvider);

    final complete = ref.watch(_completeProvider);

    useEffect(() {
      if (!complete) return;

      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          Navigator.push<void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const Results3(),
            ),
          );
        },
      );
    }, [complete]);

    useRoutes(routeObserver, onPop: () {});

    final landscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: (landscape) ? 1 : 2,
            child: ColoredBackground(
              color: colorScheme.primary,
              child: Row(
                children: [
                  Expanded(
                    flex: (landscape) ? 3 : 4,
                    child: Center(
                      child: Text(
                        "Load ${testData.index + 1}",
                        style: (landscape) ? titleStyle : smallTitleStyle,
                      ),
                    ),
                  ),
                  const VerticalDivider(),
                  const Spacer(),
                  Expanded(
                    flex: 5,
                    child: Center(
                      child: Text(
                        testData.current.prompt,
                        style: (landscape) ? subtitleStyle : smallSubtitleStyle,
                      ),
                    ),
                  ),
                  Spacer(flex: (landscape) ? 6 : 1),
                ],
              ),
            ),
          ),
          Expanded(
            flex: (landscape) ? 4 : 7,
            child: Flex(
              direction: (landscape) ? Axis.horizontal : Axis.vertical,
              children: [
                Expanded(
                  flex: 3,
                  child: Stack(
                    children: const [
                      Align(
                        alignment: FractionalOffset(0.25, 0.10),
                        child: _Detergent(Detergent.biologicalDetergent),
                      ),
                      Align(
                        alignment: FractionalOffset(0.75, 0.10),
                        child: _Detergent(Detergent.fabricSoftener),
                      ),
                      Align(
                        alignment: FractionalOffset(0.25, 0.90),
                        child: _Detergent(Detergent.nonBiologicalDetergent),
                      ),
                      Align(
                        alignment: FractionalOffset(0.75, 0.90),
                        child: _Detergent(Detergent.laundryBooster),
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  flex: 2,
                  child: _WashingMachine(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _WashingMachine extends ConsumerWidget {
  const _WashingMachine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final buttonTextStyle = theme.textTheme.headline5!.copyWith(color: colorScheme.onPrimary);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: DragTarget<Detergent>(
            onAccept: (Detergent detergent) {
              ref.read(inWashingMachineProvider).add(detergent);
            },
            builder: (_, __, ___) => const FittedBox(
              child: Icon(Icons.local_laundry_service_outlined),
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  ref.read(inWashingMachineProvider).clear();
                },
                child: Text(
                  "Reset",
                  style: buttonTextStyle,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (ref.read(_nextRequestProvider) != null) return;

                  ref.read(testProvider).isCorrect(ref.read(inWashingMachineProvider).elements);

                  ref.read(_nextRequestProvider.notifier).state = Timer(
                    const Duration(seconds: 1),
                    () {
                      if (!ref.read(testProvider).moveNext()) {
                        ref.read(_completeProvider.notifier).state = true;
                      }

                      ref.read(_nextRequestProvider.notifier).state = null;
                      ref.read(inWashingMachineProvider).clear();
                    },
                  );
                },
                child: Text(
                  "Submit",
                  style: buttonTextStyle,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _Detergent extends ConsumerWidget {
  final Detergent detergent;

  const _Detergent(this.detergent, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inMachine = ref.watch(inWashingMachineProvider);
    final nextRequest = ref.watch(_nextRequestProvider);
    final testData = ref.watch(testProvider);

    final child = (!inMachine.contains(detergent))
        ? FittedBox(
            child: Icon(detergent.icon),
          )
        : const SizedBox();

    final landscape = MediaQuery.of(context).orientation == Orientation.landscape;

    final nameStyle = Theme.of(context).textTheme.bodyLarge!;
    final smallNameStyle = Theme.of(context).textTheme.bodyMedium!;

    final checkmarkSize = (landscape) ? 70.0 : 40.0;
    final size = (landscape) ? 250.0 : 100.0;

    return Stack(
      fit: StackFit.passthrough,
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: LayoutBuilder(
                  builder: (_, BoxConstraints constraints) {
                    return Draggable<Detergent>(
                      data: detergent,
                      feedback: ConstrainedBox(constraints: constraints, child: child),
                      childWhenDragging: const SizedBox(),
                      child: child,
                    );
                  },
                ),
              ),
              Expanded(
                child: Text(
                  detergent.value,
                  style: (landscape) ? nameStyle : smallNameStyle,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
        ),
        if (nextRequest != null)
          Positioned(
            top: -(checkmarkSize * 0.4),
            right: -(checkmarkSize * 0.4),
            child: SizedBox(
              width: checkmarkSize,
              height: checkmarkSize,
              child: Checkmark(testData.current.answer.contains(detergent)),
            ),
          ),
      ],
    );
  }
}

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
        return Icons.inventory_2_outlined;
    }
  }
}
