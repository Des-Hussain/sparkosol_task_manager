import 'package:get_it/get_it.dart';
import 'package:sparkosol_task_manager/data/repositories/mock_task_repository.dart';
import 'package:sparkosol_task_manager/domain/repositories/task_repository.dart';

class Injector {
  Injector._();

  static final _dependency = GetIt.instance;

  static void setup() {
    
    _dependency.registerLazySingleton<TaskRepository>(
        () => TaskRepositoryIml());
  }
}