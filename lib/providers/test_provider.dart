import 'package:flutter/material.dart';

import 'package:fabrics/models/tests/equatable.dart';
import 'package:fabrics/models/tests/question.dart';
import 'package:fabrics/models/tests/test.dart';

class TestProvider<A extends Equatable, P> extends Test<A, P> with ChangeNotifier {
  TestProvider(List<Question<A, P>> answers) : super(answers);

  @override
  bool moveNext() {
    final canMove = super.moveNext();

    if (canMove) notifyListeners();

    return canMove;
  }
}
