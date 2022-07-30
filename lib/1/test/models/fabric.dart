import 'package:fabrics/1/test/models/fabric_type.dart';
import 'package:handy/handy.dart';

enum Fabric {
  cotton,
  glass,
  nylon,
  sisal,
  acrylic,
  ramie,
}

extension FabricExtension on Fabric {
  FabricType get type {
    switch (this) {
      case Fabric.cotton:
        return FabricType.natural;
      case Fabric.glass:
        return FabricType.mineral;
      case Fabric.nylon:
        return FabricType.manMade;
      case Fabric.sisal:
        return FabricType.natural;
      case Fabric.acrylic:
        return FabricType.manMade;
      case Fabric.ramie:
        return FabricType.natural;
    }
  }

  String toStringValue() {
    return toShortString().capitalize();
  }
}
