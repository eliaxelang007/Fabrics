import 'package:fabrics/observers.dart';
import 'package:fabrics/pages/1/intro.dart';
import 'package:fabrics/pages/1/test.dart';
import 'package:fabrics/pages/2/intro.dart';
import 'package:fabrics/pages/2/test.dart';
import 'package:fabrics/pages/3/intro.dart';
import 'package:fabrics/pages/3/test.dart';
import 'package:fabrics/pages/4/intro.dart';
import 'package:fabrics/pages/4/test.dart';
import 'package:fabrics/pages/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      secondary: Color(0xffeee5ce),
      onSecondary: Color(0xff38353a),
      error: Color(0xffb00020),
      onError: Colors.white,
      background: Colors.white,
      onBackground: Colors.black,
      surface: Colors.white,
      onSurface: Colors.black,
    );

    return ProviderScope(
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: colorScheme,
          textTheme: GoogleFonts.quicksandTextTheme(TextTheme(headline3: headline3!.copyWith(color: colorScheme.onSecondary))),
        ),
        initialRoute: '/',
        routes: {
          '/': const Menu(),
          '/1': const Intro(),
          '/1/test': const Test(),
          '/2': const Intro2(),
          '/2/test': const Test2(),
          '/3': const Intro3(),
          '/3/test': const Test3(),
          '/4': const Intro4(),
          '/4/test': const Test4()
        }.map(
          (String route, Widget page) => MapEntry(
            route,
            (_) => Builder(builder: (context) {
              final landscape = MediaQuery.of(context).orientation == Orientation.landscape;

              ScreenUtil.init(context, designSize: (landscape) ? const Size(1536, 754) : const Size(393, 851));

              return page;
            }),
          ),
        ),
        navigatorObservers: [routeObserver],
      ),
    );
  }
}
