abstract class TaskStates {}

class TaskInitialState extends TaskStates {}

class TaskLoadingState extends TaskStates {}

class TaskSuccessState extends TaskStates {
  TaskSuccessState({this.message});

  final String? message;
}

class TaskErrorState extends TaskStates {
  TaskErrorState({required this.error, required this.errorMessage});

  final String error;
  final String errorMessage;
}
