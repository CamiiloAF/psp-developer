import 'dart:convert';

import 'package:psp_developer/src/models/base_parts_model.dart';
import 'package:psp_developer/src/models/new_parts_model.dart';
import 'package:psp_developer/src/models/reusable_parts_model.dart';

class ProgramsModel {
  List<ProgramModel> programs = [];

  ProgramsModel();

  ProgramsModel.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final program = ProgramModel.fromJson(item);
      programs.add(program);
    }
  }
}

ProgramModel programModelFromJson(String str) =>
    ProgramModel.fromJson(json.decode(str));

String programModelToJson(ProgramModel data) =>
    json.encode(data.toJson(isForDoOperationInNetwork: true));

class ProgramModel {
  ProgramModel({
    this.id,
    this.usersId,
    this.languagesId,
    this.modulesId,
    this.name,
    this.description,
    this.totalLines,
    this.planningDate,
    this.startDate,
    this.updateDate,
    this.deliveryDate,
  });

  int id;
  int usersId;
  int languagesId;
  int modulesId;
  String name;
  String description;
  int totalLines;
  int planningDate;
  int startDate;
  int updateDate;
  int deliveryDate;

  List<BasePartModel> baseParts = [];
  List<ReusablePartModel> reusableParts = [];
  List<NewPartModel> newParts = [];

  factory ProgramModel.fromJson(Map<String, dynamic> json) => ProgramModel(
        id: json['id'],
        usersId: json['users_id'],
        languagesId: json['languages_id'],
        modulesId: json['modules_id'],
        name: json['name'],
        description: json['description'],
        totalLines: json['total_lines'],
        planningDate: int.parse(json['planning_date']),
        startDate: int.parse(json['start_date']),
        updateDate: (json['update_date'] != null)
            ? int.parse(json['update_date'])
            : null,
        deliveryDate: (json['delivery_date'] != null)
            ? int.parse(json['delivery_date'])
            : null,
      );

  Map<String, dynamic> toJson({bool isForDoOperationInNetwork = false}) =>
      (isForDoOperationInNetwork)
          ? {
              'id': id,
              'users_id': usersId,
              'languages_id': languagesId,
              'modules_id': modulesId,
              'name': name,
              'description': description,
              'total_lines': totalLines,
              'planning_date': planningDate,
              'start_date': startDate,
              'update_date': updateDate,
              'delivery_date': deliveryDate,
              'base_parts': baseParts,
              'reusable_parts': reusableParts,
              'new_parts': newParts,
            }
          : {
              'id': id,
              'users_id': usersId,
              'languages_id': languagesId,
              'modules_id': modulesId,
              'name': name,
              'description': description,
              'total_lines': totalLines,
              'planning_date': planningDate,
              'start_date': startDate,
              'update_date': updateDate,
              'delivery_date': deliveryDate,
            };
}
