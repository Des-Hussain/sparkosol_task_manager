import 'package:sparkosol_task_manager/domain/entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();
  Future<void> addTask(Task task);
  Future<void> deleteTask(String id);
}