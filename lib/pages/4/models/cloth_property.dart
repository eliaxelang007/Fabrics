import 'package:handy/handy.dart';

enum ClothProperty {
  fabric(true),
  gender(false),
  soiling(true),
  brand(false),
  denims(true);

  const ClothProperty(this.shouldSeparateBy);

  final bool shouldSeparateBy;

  String get value => toShortString().capitalize();
}
