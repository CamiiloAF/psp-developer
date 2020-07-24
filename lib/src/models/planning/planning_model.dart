import 'dart:convert';

PlanningModel planningModelFromJson(String str) =>
    PlanningModel.fromJson(json.decode(str));

String planningModelToJson(PlanningModel data) => json.encode(data.toJson());

class PlanningModel {
  PlanningModel({
    this.id,
    this.phasesId,
    this.programsId,
    this.planningTime,
    this.currentTime,
    this.planningDefect,
    this.currentDefect,
  });

  int id;
  int phasesId;
  int programsId;
  int planningTime;
  int currentTime;
  int planningDefect;
  int currentDefect;

  factory PlanningModel.fromJson(Map<String, dynamic> json) => PlanningModel(
        id: json['id'],
        phasesId: json['phases_id'],
        programsId: json['programs_id'],
        planningTime: json['planning_time'],
        currentTime: json['current_time'],
        planningDefect: json['planning_defect'],
        currentDefect: json['current_defect'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'phases_id': phasesId,
        'programs_id': programsId,
        'planning_time': planningTime,
        'current_time': currentTime,
        'planning_defect': planningDefect,
        'current_defect': currentDefect,
      };
}
