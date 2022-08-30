import 'package:cleanarch_movie_app/core/utils/state_enum.dart';
import 'package:flutter/foundation.dart';

class HomeNotifier extends ChangeNotifier {
  GeneralContentType _state = GeneralContentType.movie;

  GeneralContentType get state => _state;

  void setState(GeneralContentType newState) {
    _state = newState;
    notifyListeners();
  }
}
