import 'package:flutter/material.dart';

extension AxisExtension on Axis {
  Axis get opposite => (this == Axis.horizontal) ? Axis.vertical : Axis.horizontal;
}
