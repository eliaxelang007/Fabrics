import 'package:fabrics/models/tests/equatable.dart';
import 'package:fabrics/models/tests/question.dart';

class Test<A extends Equatable, P> implements Iterator<P> {
  final List<Question<A, P>> _answers;

  int _previouslyAnswered = -1;
  int _questionIndex = -1;
  int _score = 0;

  Test(this._answers);

  @override
  P get current => _answers[_questionIndex].prompt;
  double get grade => _score / _answers.length;

  bool isCorrect(A answer) {
    final correct = answer == _answers[_questionIndex];

    if (_previouslyAnswered != _questionIndex) {
      _previouslyAnswered = _questionIndex;

      if (correct) {
        _score++;
      }
    }

    return correct;
  }

  @override
  bool moveNext() {
    if ((_questionIndex + 1) >= _answers.length) return false;
    _questionIndex++;
    return true;
  }
}
