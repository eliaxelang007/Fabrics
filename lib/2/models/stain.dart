import 'package:fabrics/2/models/stain_remover.dart';
import 'package:handy/handy.dart';

enum Stain {
  bubblegum(StainRemover.freezing),
  mud(StainRemover.brushing),
  wine(StainRemover.flushing);

  const Stain(this.remover);

  final StainRemover remover;

  String get value => toShortString().capitalize();
}
