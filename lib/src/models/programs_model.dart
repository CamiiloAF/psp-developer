import 'dart:convert';

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

String programModelToJson(ProgramModel data) => json.encode(data.toJson());

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
    this.deliveryDate,
  });

  int id;
  int usersId;
  int languagesId;
  int modulesId;
  String name;
  String description;
  double totalLines;
  int planningDate;
  int startDate;
  int deliveryDate;

  factory ProgramModel.fromJson(Map<String, dynamic> json) => ProgramModel(
        id: json['id'],
        usersId: json['users_id'],
        languagesId: json['languages_id'],
        modulesId: json['modules_id'],
        name: json['name'],
        description: json['description'],
        totalLines: (json['total_lines'] != null)
            ? double.parse('${json['total_lines']}')
            : null,
        planningDate: int.parse(json['planning_date']),
        startDate: int.parse(json['start_date']),
        deliveryDate: (json['delivery_date'] != null)
            ? int.parse(json['delivery_date'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'users_id': usersId,
        'languages_id': languagesId,
        'modules_id': modulesId,
        'name': name,
        'description': description,
        'total_lines': totalLines,
        'planning_date': planningDate,
        'start_date': startDate,
        'delivery_date': deliveryDate,
      };
}
