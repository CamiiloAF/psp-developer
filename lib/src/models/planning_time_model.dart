import 'dart:convert';

PlanningTimeModel planningTimeModelFromJson(String str) =>
    PlanningTimeModel.fromJson(json.decode(str));

String planningTimeModelToJson(PlanningTimeModel data) =>
    json.encode(data.toJson());

class TimePlanningInPhases {
  TimePlanningInPhases(
      {this.planningTimeInPlan,
      this.planningTimeInDld,
      this.planningTimeInCode,
      this.planningTimeInCompile,
      this.planningTimeInUt,
      this.planningTimeInPm});

  int planningTimeInPlan;
  int planningTimeInDld;
  int planningTimeInCode;
  int planningTimeInCompile;
  int planningTimeInUt;
  int planningTimeInPm;
}

class PlanningTimeModel {
  PlanningTimeModel({
    this.id,
    this.phasesId,
    this.programsId,
    this.planningTime,
    this.currentTime,
  });

  int id;
  int phasesId;
  int programsId;
  int planningTime;
  int currentTime;

  factory PlanningTimeModel.fromJson(Map<String, dynamic> json) =>
      PlanningTimeModel(
        id: json['id'],
        phasesId: json['phases_id'],
        programsId: json['programs_id'],
        planningTime: json['planning_time'],
        currentTime: json['current_time'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'phases_id': phasesId,
        'programs_id': programsId,
        'planning_time': planningTime,
        'current_time': currentTime,
      };
}
