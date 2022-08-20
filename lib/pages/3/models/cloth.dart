import 'package:fabrics/pages/3/models/detergent.dart';
import 'package:handy/handy.dart';

enum Cloth {
  cashmereSweater(
      "A guest has brought you a cashmere sweater to wash. It is not stained.", {Detergent.fabricSoftener, Detergent.nonBiologicalDetergent}),
  formalWhiteShirts("You have a basket of formal white shirts. They have a variety of stains including perspiration and greasy collars.",
      {Detergent.biologicalDetergent, Detergent.fabricSoftener, Detergent.laundryBooster}),
  wornBySensitiveSkinned(
      "A guest has come to you with an armful of clothing to be laundered. He suffers from eczema.", {Detergent.nonBiologicalDetergent});

  const Cloth(this.prompt, this.detergents);

  final String prompt;
  final Set<Detergent> detergents;

  String get value => toShortString().capitalize();
}
