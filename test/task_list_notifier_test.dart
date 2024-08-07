import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sparkosol_task_manager/domain/entities/task.dart';
import 'package:sparkosol_task_manager/domain/usecases/task_use_cases.dart';
import 'package:sparkosol_task_manager/presentation/providers/task_providers.dart';

// Mock class for TaskUseCases
class MockTaskUseCases extends Mock implements TaskUseCases {}

void main() {
  late TaskListNotifier provider;
  late MockTaskUseCases mockTaskUseCases;
  late ProviderContainer container;

  setUp(() {
    mockTaskUseCases = MockTaskUseCases();
    container = ProviderContainer();
    provider = container.read(taskListProvider.notifier);
  });

  test('Load tasks provider', () async {
    final task = Task(id: '1', title: 'Test Task');
    when(mockTaskUseCases.getTasks()).thenAnswer((_) async => [task]);

    await provider.loadTasks();

    expect(provider.state, [task]);
    verify(mockTaskUseCases.getTasks()).called(1);
  });

  test('Add task provider', () async {
    final task = Task(id: '1', title: 'Test Task');
    when(mockTaskUseCases.addTask(task)).thenAnswer((_) async => {});

    await provider.addTask(task);

    expect(provider.state, [task]);
    verify(mockTaskUseCases.addTask(task)).called(1);
  });

  test('Delete task provider', () async {
    final task = Task(id: '1', title: 'Test Task');
    when(mockTaskUseCases.addTask(task)).thenAnswer((_) async => {});
    when(mockTaskUseCases.deleteTask(task.id)).thenAnswer((_) async => {});

    await provider.addTask(task);
    await provider.deleteTask(task.id);

    expect(provider.state, []);
    verify(mockTaskUseCases.deleteTask(task.id)).called(1);
  });
}