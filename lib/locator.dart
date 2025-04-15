import 'package:get_it/get_it.dart';
import 'package:vocabbook/layer/data/db_services.dart';

import 'layer/data/database/vocab_database.dart';
import 'layer/domain/repository/vocab_repository.dart';
import 'layer/domain/use_case/vocab_services.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  // ثبت سینگلتون‌ها
  locator.registerSingleton<VocabDatabase>(VocabDatabase());
  // ثبت با وابستگی
  locator.registerSingleton<DbServices>(DbServices(db: locator<VocabDatabase>().database));
  // ثبت با وابستگی
  locator.registerSingleton<VocabRepository>(VocabRepository(dbServices: locator<DbServices>()));
  // ثبت با وابستگی
  locator.registerSingleton<VocabServices>(VocabServices(vocabRepository: locator<VocabRepository>()));

}