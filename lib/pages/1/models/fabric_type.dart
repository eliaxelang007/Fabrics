import 'package:handy/handy.dart';

enum FabricType {
  natural,
  manMade,
  mineral;

  String get value => (this != FabricType.manMade) ? toShortString().capitalize() : "Man-Made";
}
