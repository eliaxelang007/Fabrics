import 'package:flutter/cupertino.dart';

class SetProvider<T> extends ChangeNotifier {
  final Set<T> _elements;

  SetProvider(this._elements);

  Set<T> get elements => Set.unmodifiable(_elements);

  int get length => _elements.length;

  void add(T element) {
    _elements.add(element);
    notifyListeners();
  }

  void clear() {
    _elements.clear();
    notifyListeners();
  }

  bool contains(T element) => _elements.contains(element);
}
