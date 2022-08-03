import 'package:fabrics/pages/1/intro.dart';
import 'package:fabrics/pages/1/test.dart';
import 'package:fabrics/pages/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final headline3 = textTheme.headline3;

    const colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff00779a),
      primaryContainer: Color(0xff52abc3),
      onPrimary: Colors.white,
      secondary: Color(0xff88D498),
      onSecondary: Color(0xff38353a),
      error: Color(0xffb00020),
      onError: Colors.white,
      background: Colors.black,
      onBackground: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
    );

    return ProviderScope(
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: colorScheme,
          textTheme: GoogleFonts.quicksandTextTheme(TextTheme(headline3: headline3!.copyWith(color: colorScheme.onSecondary))),
        ),
        initialRoute: '/menu',
        routes: {'/menu': (_) => const Menu(), '/1': (_) => const Intro(), '/1/test': (_) => const Test()},
      ),
    );
  }
}
