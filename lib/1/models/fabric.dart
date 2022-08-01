import 'package:fabrics/1/models/fabric_type.dart';
import 'package:handy/handy.dart';

enum Fabric {
  cotton(FabricType.natural),
  glass(FabricType.mineral),
  nylon(FabricType.manMade),
  sisal(FabricType.natural),
  acrylic(FabricType.manMade),
  ramie(FabricType.natural);

  const Fabric(this.type);

  final FabricType type;

  String get value => toShortString().capitalize();
}
