import 'package:fabrics/1/index.dart';
import 'package:fabrics/1/results.dart';
import 'package:fabrics/1/test/test.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ProviderScope(
        child: MaterialApp(
          theme: ThemeData(
              textTheme: GoogleFonts.quicksandTextTheme(),
              scaffoldBackgroundColor: const Color(0xff52abc3)),
          initialRoute: "/1/",
          routes: {
            '/1/': (_) => const Intro(),
            "/1/test/": (_) => const Test(),
            "/1/results/": (_) => const Results(),
          },
        ),
      );
}
