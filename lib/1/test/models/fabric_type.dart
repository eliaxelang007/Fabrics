import 'package:handy/handy.dart';

enum FabricType {
  natural,
  manMade,
  mineral,
}

extension FabricTypeExtension on FabricType {
  String toStringValue() {
    return (this != FabricType.manMade)
        ? toShortString().capitalize()
        : "Man-Made";
  }
}
