import 'package:fabrics/models/tests/question.dart';

class Test<A, P> implements Iterator<Question<A, P>> {
  final bool Function(A, A) _checkAnswer;
  final List<Question<A, P>> _answers;

  int _previouslyAnswered = -1;
  int _questionIndex = 0;
  int _score = 0;

  /// [checkAnswer] defaults to ((A answer, A correctAnswer) => answer == correctAnswer);
  Test(
    this._answers, {
    bool Function(A, A)? checkAnswer,
  }) : _checkAnswer = checkAnswer ?? ((A answer, A correctAnswer) => answer == correctAnswer);

  @override
  Question<A, P> get current => _answers[_questionIndex];
  double get grade => _score / _answers.length;
  int get index => _questionIndex;

  bool isCorrect(A answer) {
    final correct = _checkAnswer(answer, _answers[_questionIndex].answer);

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
