import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ToDoApp/model/cubits/task/task_state.dart';
import 'package:ToDoApp/view-model/data/network/dio_helper.dart';
import 'package:ToDoApp/view-model/data/network/end_points.dart';
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

  //  start 1st function (addTask) ..
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
  //  end of 1st function (addTask) ..

  //  start 2d function (clearControllers) ..
  void clearControllers() {
    titleController.clear();
    descriptionController.clear();
    startDateController.clear();
    endDateController.clear();
    imageController.clear();
    image = null ; // to remove the picked image form add task widget ..
  }
  //  end of 2d function (clearControllers) ..

  // start of 3d function (deleteTask)
  void deleteTask(int index) {
    tasks.removeAt(index);
    emit(DeleteTaskSuccessState());
  }
  // end of 3d function (deleteTask)..

  //start of 4th function (getAllTasks)..
  Future<void> getAllTasks() async {
    emit(GetAllTasksLoadingState());
    page = 1;
    await DioHelper.get(
        endPoint: EndPoints.tasks,
        withToken: true,
        params: {'page': page}).then(
      (value) {
        //to clear the tasks list an add the tasks again otherwise everytime we call (getAllTasks) the list add the same tasks again..
        tasks.clear();
        page = 1;
        hasMore = true;
        for (var element in value.data['data']['tasks']) {
          TaskModel task = TaskModel.fromJson(element);
          tasks.add(task);
        }
        if (tasks.length < 15) {
          hasMore = false;
        }
        emit(GetAllTasksSuccessState(tasks));
      },
    ).catchError((error) {
      if (error is DioException) {
        debugPrint(error.response?.data.toString() ?? 'something went wrong 1');
        // if the token is expired we need to get another new one .
        // (.toLowerCase)=> both sides to convert both the words to lowerCase to match each other..
        if (error.response?.data['message']?.toString().trim().toLowerCase() ==
            'Unauthenticated'.toLowerCase()) {
          emit(
              UnauthenticatedState()); // then send this emit to blocConsumer in (homePage)..
        }
        emit(GetAllTasksFailedState(
            error:
                error.response?.data.toString() ?? "something went wrong 2"));
        return;
      }
      debugPrint(error.response?.data.toString() ?? '');
      emit(GetAllTasksFailedState(error: "something went wrong 3"));
      throw error;
    });
  }
  //end of 4th function (getAllTasks)..

  // start of 5th function (addTaskToAPI)..
  Future<void> addTaskToAPI() async {
    emit(AddTaskLoadingState());
    TaskModel newTask = TaskModel(
      title: titleController.text,
      description: descriptionController.text,
      startDate: startDateController.text,
      endDate: endDateController.text,
      status: 'new',
    );
    // the next step equal (newTask) but i need to do it to send the image i picked (which it's type is File );
    FormData formData =FormData.fromMap({
      ...newTask.toJson(),
      if(image!= null)
      'image': await MultipartFile.fromFile(image?.path?? "")
    });

    await DioHelper.post(
      endPoint: EndPoints.tasks,
      withToken: true,
      body: formData,
    ).then(
      (value) {
        TaskModel task = TaskModel.fromJson(value.data[
            'data']); // to get the data from response and save it in (task) then add to list(tasks)
        tasks.add(task);
        clearControllers();
        emit(AddTaskSuccessState());
      },
    ).catchError((error) {
      if (error is DioException) {
        emit(AddTaskFailedState(
            error:
                error.response?.data.toString() ?? "something went wrong 2"));
        return;
      }
      emit(AddTaskFailedState(error: "something went wrong 3"));
      throw error;
    });
  }

  // start of 6th function (deleteTaskFromAPI)..
  Future<void> deleteTaskFromAPI(int taskIndex) async {
    emit(DeleteTaskLoadingState());
    await DioHelper.delete(
      endPoint: '${EndPoints.tasks}/${tasks[taskIndex].id}',
      withToken: true,
    ).then(
      (value) {
        tasks.removeAt(taskIndex);
        emit(DeleteTaskSuccessState());
      },
    ).catchError((error) {
      if (error is DioException) {
        emit(DeleteTaskFailedState(
            error: error.response?.data?['message'] ?? ''));
      }
    });
  }
  // end of 6th function (deleteTaskFromAPI)..

  // start 7th function (initScrollController) to send request to get more tasks when i reach the bottom of the page (Pagination)..
  ScrollController controller = ScrollController();
  void initScrollController() {
    controller.addListener(() {
      if (controller.position.atEdge &&
          controller.position.pixels != 0 &&
          hasMore &&
          state is GetMoreTasksLoadingState) {
        debugPrint('you are in the bottom');
        getMoreTasks();
      }
    });

    //controller.position.atEdge => it means when i touch the top or the bottom ,
    //controller.position.pixels != 0 => pixels 0 means i am in the top in the first pixel of screen , so != 0 means any where else ,
  }

  // start the 8 function (used in function 7 Pagination)
  int page = 1;
  bool hasMore = true;
  Future<void> getMoreTasks() async {
    emit(GetMoreTasksLoadingState());
    await DioHelper.get(
        endPoint: EndPoints.tasks,
        withToken: true,
        params: {'page': ++page}).then(
      (value) {
        for (var element in value.data['data']['tasks']) {
          TaskModel task = TaskModel.fromJson(element);
          tasks.add(task);
        }
        if ((value.data['data']['tasks'] as List<dynamic>).length < 15) {
          hasMore = false;
        }
        emit(GetMoreTasksSuccessState(tasks));
      },
    ).catchError((error) {
      if (error is DioException) {
        // if the token is expired we need to get another new one ..
        if (error.response?.data['message'] == 'unauthenticated') {
          emit(UnauthenticatedState());
          // then send this emit to blocConsumer in (homePage)..
        }
        emit(GetAllTasksFailedState(
            error: error.response?.data ?? "something went wrong 2"));
        return;
      }
      emit(GetMoreTasksFailedState(error: "something went wrong 3"));
      throw error;
    });
  }
  // end of the 8 function ..

  // start the 9 function (Image Picker)..
  final ImagePicker picker = ImagePicker();
  XFile? image;
  void pickImageFromGallery() async {
    image = await picker.pickImage(source: ImageSource.gallery,imageQuality: 50);
    emit(PickImageState());
  }
  // end of the 9 function
}
