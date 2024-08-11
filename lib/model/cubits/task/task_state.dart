import 'package:ToDoApp/model/task_model.dart';

abstract class TaskState {}

class InitialTaskState extends TaskState {}

class AddTaskState extends TaskState {}

class DeleteTaskLoadingState extends TaskState {}

class DeleteTaskSuccessState extends TaskState {}

class DeleteTaskFailedState extends TaskState {
  final String? error;
  DeleteTaskFailedState({this.error});
}

class UnauthenticatedState extends TaskState {
}

class UpdateTasksState extends TaskState {}

class GetAllTasksLoadingState extends TaskState {}

class GetAllTasksSuccessState extends TaskState {
  final List<TaskModel> tasks;
  GetAllTasksSuccessState(this.tasks);
}

class GetAllTasksFailedState extends TaskState {
  final String? error;
  GetAllTasksFailedState({this.error});
}

class AddTaskLoadingState extends TaskState {}

class AddTaskSuccessState extends TaskState {}

class AddTaskFailedState extends TaskState {
  final String? error;
  AddTaskFailedState({this.error});
}

class GetMoreTasksLoadingState extends TaskState {}

class GetMoreTasksSuccessState extends TaskState {
  final List<TaskModel> tasks;
  GetMoreTasksSuccessState(this.tasks);
}

class GetMoreTasksFailedState extends TaskState {
  final String? error;
  GetMoreTasksFailedState({this.error});
}

class PickImageState extends TaskState{}
