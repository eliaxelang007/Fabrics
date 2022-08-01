import 'package:fabrics/1/index.dart';
import 'package:fabrics/1/results.dart';
import 'package:fabrics/1/test.dart';
import 'package:fabrics/2/index.dart';
import 'package:fabrics/2/results.dart';
import 'package:fabrics/2/test.dart';
import 'package:fabrics/3/index.dart';
import 'package:fabrics/3/results.dart';
import 'package:fabrics/3/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  //debugPaintSizeEnabled = true;
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ProviderScope(
        child: MaterialApp(
          theme: ThemeData(textTheme: GoogleFonts.quicksandTextTheme(), scaffoldBackgroundColor: const Color(0xff52abc3)),
          initialRoute: "/3/",
          routes: {
            '/1/': (_) => const Intro1(),
            "/1/test/": (_) => const Test1(),
            "/1/results/": (_) => const Results1(),
            '/2/': (_) => const Intro2(),
            "/2/test/": (_) => const Test2(),
            "/2/results/": (_) => const Results2(),
            '/3/': (_) => const Intro3(),
            "/3/test/": (_) => const Test3(),
            "/3/results/": (_) => const Results3(),
          },
        ),
      );
}
