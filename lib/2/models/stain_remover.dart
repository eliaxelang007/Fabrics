import 'package:handy/handy.dart';

enum StainRemover {
  sponging,
  brushing,
  preSoaking,
  flushing,
  spatula,
  freezing;

  String get value {
    switch (this) {
      case preSoaking:
        return "Pre-soaking";
      default:
        return toShortString().capitalize();
    }
  }
}
