import 'package:fabrics/models/tests/equatable.dart';
import 'package:handy/handy.dart';

enum StainRemover implements Equatable {
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
