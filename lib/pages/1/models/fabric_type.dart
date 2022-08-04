import 'package:fabrics/models/tests/equatable.dart';
import 'package:handy/handy.dart';

enum FabricType implements Equatable {
  natural,
  manMade,
  mineral;

  String get value => (this != FabricType.manMade) ? toShortString().capitalize() : "Man-Made";
}
