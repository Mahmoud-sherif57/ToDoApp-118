import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/model/cubits/task/task_state.dart';
import '../../task_model.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(InitialTaskState());

  static TaskCubit get(context) => BlocProvider.of(context);
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  List<TaskModel> tasks = [];

  void addTask() {
    TaskModel newTask = TaskModel(
      title: titleController.text,
      description: descriptionController.text,
      startDate: startDateController.text,
      endDate: endDateController.text,
      image: imageController.text,
    );
    tasks.add(newTask);
    clearControllers();
    emit(AddTaskState());
  }

  void clearControllers() {
    titleController.clear();
    descriptionController.clear();
    startDateController.clear();
    endDateController.clear();
    imageController.clear();
  }

  void deleteTask(int index) {
    tasks.removeAt(index);
    emit(DeleteTaskState());
  }


}


// to edit the textFormField
// void updateTask(TaskModel updatedTask) {
//   final index = tasks.indexWhere((tasks) => tasks.title == updatedTask.title);
//   if (index != -1) {
//     tasks[index] = updatedTask;
//     emit(TasksUpdated());
//   }
// }