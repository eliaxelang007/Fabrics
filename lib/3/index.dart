import 'package:flutter/material.dart';

class Intro3 extends StatelessWidget {
  const Intro3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final TextStyle headline = textTheme.headline3!;
    final TextStyle button = textTheme.headline4!;

    const int sidesMargin = 1;

    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.7,
          heightFactor: 0.7,
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
                          flex: 2,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("OFF THE SHELF", style: headline),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text.rich(
                              TextSpan(
                                text: [
                                  "Lets put what you've learned to the test!",
                                  "Take a look at the garment properties and level of soiling. Drag the products you would use to launder the items into the washing machine.\n\n",
                                ].join("\n\n"),
                                children: [
                                  TextSpan(
                                    text:
                                        "Press BEGIN when you're ready to start.",
                                    style: TextStyle(
                                        color: theme.scaffoldBackgroundColor,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              style:
                                  ElevatedButton.styleFrom(textStyle: button),
                              onPressed: () {
                                Navigator.pushNamed(context, "/3/test/");
                              },
                              child: const Text("BEGIN"),
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
