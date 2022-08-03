import 'package:flutter/material.dart';

class DeviceOrientationBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, Orientation orientation) builder;

  const DeviceOrientationBuilder({required this.builder, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => builder(context, MediaQuery.of(context).orientation);
}
