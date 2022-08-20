import 'package:flutter/material.dart';

import 'package:fabrics/models/tests/question.dart';
import 'package:fabrics/models/tests/test.dart';

class TestProvider<A, P> extends Test<A, P> with ChangeNotifier {
  TestProvider(List<Question<A, P>> answers, {bool Function(A, A)? checkAnswer}) : super(answers, checkAnswer: checkAnswer);

  @override
  bool moveNext() {
    final canMove = super.moveNext();

    if (canMove) notifyListeners();

    return canMove;
  }
}
