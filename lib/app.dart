import 'package:fabrics/pages/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Theme.of(context).copyWith(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xff00779a),
          onPrimary: Colors.white,
          secondary: Color(0xffeee5ce),
          onSecondary: Color(0xff38353a),
          error: Color(0xffb00020),
          onError: Colors.white,
          background: Colors.white,
          onBackground: Colors.black,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
        textTheme: GoogleFonts.quicksandTextTheme(),
      ),
      initialRoute: '/',
      routes: {
        '/': const Menu(),
      }.map(
        (key, value) => MapEntry(
          key,
          (_) => Builder(
            builder: (context) {
              final landscape = MediaQuery.of(context).orientation == Orientation.landscape;

              ScreenUtil.init(
                context,
                designSize: (landscape) ? const Size(1280, 800) : const Size(360, 690),
              );

              return value;
            },
          ),
        ),
      ),
    );
  }
}
