// creating the task model

import 'package:image_picker/image_picker.dart';

class TaskModel {
  String? title;
  String? description;
  String? image;
  XFile? myImage;
  String? startDate;
  String? endDate;
  int? id;
  String? status;
// the constructor of the taskModel
  TaskModel({
    this.title,
    this.description,
    this.image,
    this.myImage,
    this.startDate,
    this.endDate,
    this.id,
    this.status,
  });
  // creating named constructor to transform the response from json to dart (we can generate this automatically by 'from json to dart' website) ..
  TaskModel.fromJson(Map<String?, dynamic> json) {
    title = json['title'];
    description = json['description'];
    image = json['image'];
    id = json['id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      if (image != null) 'image': image,
      // if (startDate != null) 'start_date': startDate,
      // if ( endDate!= null) 'end_date': endDate,
      'start_date': startDate,
      'end_date': endDate,
      'status': status,
    };
  }
}

// we need to get all tasks in the end point ({{base_url}}/tasks) we have many kinds of status,
// we created this Because we have many kind of status that we need to add to taskModel .
enum TaskStatus { newTask, outDated, completed, doing }
