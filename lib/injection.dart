import 'package:cleanarch_movie_app/core/presentation/provider/home_notifier.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  /// TODO Movie Bloc Search and TV
  ///

  // Provider
  locator.registerFactory(() => HomeNotifier());
}
