// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:fabrics/pages/widgets/responsive/oriented_flex.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(0.8),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: OrientedFlex(
                children: [],
              ),
            ),
            Expanded(
              flex: 12,
              child: OrientedFlex(
                children: [],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
