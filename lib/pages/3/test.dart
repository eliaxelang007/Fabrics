import 'dart:async';

import 'package:fabrics/observers.dart';
import 'package:fabrics/pages/2/results.dart';
import 'package:fabrics/pages/hooks/use_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:fabrics/providers/test_provider.dart';
import 'package:fabrics/models/tests/question.dart';

import 'package:fabrics/pages/2/models/stain_remover.dart';
import 'package:fabrics/pages/2/models/stain.dart';

//final _nextRequestProvider = StateProvider<Timer?>((_) => null);
final _completeProvider = StateProvider((_) => false);

final testProvider = ChangeNotifierProvider(
  (_) => TestProvider(
    [
      for (final stain in Stain.values) Question(prompt: stain, answer: stain.remover),
    ],
  ),
);

class Test3 extends HookConsumerWidget {
  const Test3({Key? key}) : super(key: key);

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
      _Stain(stain),
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
