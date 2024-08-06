// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:sparkosol_task_manager/domain/usecases/task_use_cases.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sparkosol_task_manager/domain/entities/task.dart';
import 'package:sparkosol_task_manager/data/repositories/mock_task_repository.dart';

void main() {
  late TaskUseCases useCases;
  late TaskRepositoryIml repository;

  setUp(() {
    repository = TaskRepositoryIml();
    useCases = TaskUseCases(repository);
  });

  test('Add and get tasks', () async {
    final task = Task(id: '1', title: 'Test Task');
    await useCases.addTask(task);
    final tasks = await useCases.getTasks();
    expect(tasks, [task]);
  });

  test('Delete task', () async {
    final task = Task(id: '1', title: 'Test Task');
    await useCases.addTask(task);
    await useCases.deleteTask('1');
    final tasks = await useCases.getTasks();
    expect(tasks, []);
  });

}

