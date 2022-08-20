import 'package:handy/handy.dart';

enum Detergent {
  biologicalDetergent,
  nonBiologicalDetergent,
  fabricSoftener,
  laundryBooster;

  String get value {
    switch (this) {
      case nonBiologicalDetergent:
        return "Non-biological Detergent";
      default:
        return toShortString().replaceAllMapped(RegExp("[a-z][A-Z]"), (match) {
          String text = match.group(0)!;
          return "${text[0]} ${text[1]}";
        }).capitalize();
    }
  }
}
