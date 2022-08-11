import 'package:cleanarch_movie_app/core/utils/state_enum.dart';
import 'package:flutter/cupertino.dart';

class HomeNotifier extends ChangeNotifier {
  GeneralContentType _state = GeneralContentType.movie;

  GeneralContentType get state => _state;

  void setState(GeneralContentType newState) {
    _state = state;
    notifyListeners();
  }
}
