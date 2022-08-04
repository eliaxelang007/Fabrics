import 'package:fabrics/models/tests/equatable.dart';

class Question<A extends Equatable, P> {
  final A answer;
  final P prompt;

  Question({required this.prompt, required this.answer});
}
