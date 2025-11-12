import 'package:get_it/get_it.dart';

import '../routing/app_router.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  if (locator.isRegistered<AppRouter>()) {
    return;
  }

  locator.registerLazySingleton<AppRouter>(AppRouter.new);
}

