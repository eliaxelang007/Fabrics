import 'package:fabrics/2/test.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:fabrics/2/models/stain.dart';

class Results2 extends ConsumerWidget {
  const Results2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int rank = ref.read(testProvider.notifier).rank;

    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final TextStyle headline = textTheme.headline2!;
    final TextStyle headline2 = textTheme.headline5!;
    final TextStyle bigText = textTheme.headline5!;

    const int sidesMargin = 1;

    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.85,
          heightFactor: 0.85,
          child: ColoredBox(
            color: Colors.white,
            child: DefaultTextStyle(
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
              child: Row(
                children: [
                  const Spacer(flex: sidesMargin),
                  Expanded(
                    flex: 7,
                    child: Column(
                      children: [
                        const Spacer(),
                        Expanded(
                          flex: 5,
                          child: Align(
                            alignment: Alignment.centerLeft,
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
                                (rank <= 2)
                                    ? Icons.check_outlined
                                    : Icons.close_outlined,
                                color: Colors.white,
                                size: 85,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          flex: 5,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Text(
                                    (rank <= 1)
                                        ? "WELL DONE"
                                        : (rank <= 2)
                                            ? "ALMOST"
                                            : "NOT QUITE",
                                    style: headline),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          flex: 6,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  textAlign: TextAlign.left,
                                  [
                                    (rank <= 1)
                                        ? "It seems you know the source of your fabrics."
                                        : "Take another look at where different fabrics derive from.",
                                    "If we can grasp this information, we can then choose the",
                                    "best-suited laundering and stain removal process.",
                                  ].join(' '),
                                  style: bigText,
                                ),
                              ),
                              const Spacer()
                            ],
                          ),
                        ),
                        const Spacer(flex: 5),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Column(
                      children: [
                        const Spacer(),
                        Expanded(
                          child: Text(
                            "THE CORRECT ANSWERS WERE:",
                            style: headline2.copyWith(
                                color: const Color(0xffa9abae)),
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: DefaultTextStyle(
                            style: const TextStyle(
                                fontSize: 35, color: Color(0xff363338)),
                            textAlign: TextAlign.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                for (Stain fabric in Stain.values) ...[
                                  const Spacer(),
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Expanded(
                                          child: ColoredBox(
                                            color: const Color(0xfff6f7f7),
                                            child: Center(
                                              child: Text(fabric.value),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: ColoredBox(
                                            color: const Color(0xffedebe1),
                                            child: Center(
                                              child: Text(fabric.remover.value),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ]
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  const Spacer(flex: sidesMargin),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
