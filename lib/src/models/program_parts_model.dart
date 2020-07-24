import 'dart:convert';

import 'package:psp_developer/src/models/base_parts_model.dart';
import 'package:psp_developer/src/models/new_parts_model.dart';
import 'package:psp_developer/src/models/planning/planning_model.dart';
import 'package:psp_developer/src/models/reusable_parts_model.dart';

ProgramPartsModel programPartsModelFromJson(String str) =>
    ProgramPartsModel.fromJson(json.decode(str));

String programPartsModelToJson(ProgramPartsModel data) =>
    json.encode(data.toJson());

class ProgramPartsModel {
  ProgramPartsModel({
    this.baseParts,
    this.reusableParts,
    this.newParts,
    this.planning,
  });

  List<BasePartModel> baseParts;
  List<ReusablePartModel> reusableParts;
  List<NewPartModel> newParts;
  List<PlanningModel> planning;

  factory ProgramPartsModel.fromJson(Map<String, dynamic> json) =>
      ProgramPartsModel(
        baseParts: List<BasePartModel>.from(
            json['base_parts'].map((x) => BasePartModel.fromJson(x))),
        reusableParts: List<ReusablePartModel>.from(
            json['reusable_parts'].map((x) => ReusablePartModel.fromJson(x))),
        newParts: List<NewPartModel>.from(
            json['new_parts'].map((x) => NewPartModel.fromJson(x))),
        planning: List<PlanningModel>.from(
            json['planning'].map((x) => PlanningModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'base_parts': List<dynamic>.from(baseParts.map((x) => x.toJson())),
        'reusable_parts':
            List<dynamic>.from(reusableParts.map((x) => x.toJson())),
        'new_parts': List<dynamic>.from(newParts.map((x) => x.toJson())),
        'planning': List<dynamic>.from(planning.map((x) => x.toJson())),
      };
}
