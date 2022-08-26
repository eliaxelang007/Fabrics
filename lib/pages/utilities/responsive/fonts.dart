import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension TextStyleExtension on TextStyle {
  TextStyle get responsive => copyWith(fontSize: fontSize!.sp);
}
