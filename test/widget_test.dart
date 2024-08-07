import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sparkosol_task_manager/domain/entities/task.dart';
import 'package:sparkosol_task_manager/presentation/views/home_screen.dart';

import 'task_use_cases_test.mocks.mocks.dart';

void main() {
  late MockTaskUseCases mockTaskUseCases;
  late ProviderContainer container;
  

  setUp(() {
    mockTaskUseCases = MockTaskUseCases();
    container = ProviderContainer();
    
  });

    testWidgets('displays a list of tasks', (WidgetTester tester) async {
    // Arrange
    final tasks = [
      Task(id: '1', title: 'Test Task 1'),
      Task(id: '2', title: 'Test Task 2'),
    ];
    when(mockTaskUseCases.getTasks()).thenAnswer((_) async => tasks);

    // Act
    await tester.pumpWidget(
      ProviderScope(
        parent: container,
        child: const MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle(); // Wait for the state to settle

    // Assert
    expect(find.text('Test Task 1'), findsOneWidget);
    expect(find.text('Test Task 2'), findsOneWidget);
  });

  testWidgets('adds a task', (WidgetTester tester) async {
    // Arrange
    when(mockTaskUseCases.getTasks()).thenAnswer((_) async => []);
    when(mockTaskUseCases.addTask(any)).thenAnswer((_) async {});
    final task = Task(id: '1', title: 'New Task');

    // Act
    await tester.pumpWidget(
      ProviderScope(
        parent: container,
        child: const MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.tap(find.text('Add Task'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), task.title);
    await tester.tap(find.text('Add Task'));
    await tester.pumpAndSettle();

    // Assert
    verify(mockTaskUseCases.addTask(any)).called(1);
    expect(find.text(task.title), findsOneWidget);
  });

  testWidgets('deletes a task', (WidgetTester tester) async {
    // Arrange
    final tasks = [
      Task(id: '1', title: 'Test Task 1'),
    ];
    when(mockTaskUseCases.getTasks()).thenAnswer((_) async => tasks);
    when(mockTaskUseCases.deleteTask(any)).thenAnswer((_) async {});

    // Act
    await tester.pumpWidget(
      ProviderScope(
        parent: container,
        child: const MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();

    // Assert
    verify(mockTaskUseCases.deleteTask(any)).called(1);
    expect(find.text('Test Task 1'), findsNothing);
  });

}

