import 'dart:convert';

PIPModel pipModelFromJson(String str) => PIPModel.fromJson(json.decode(str));

String pipModelToJson(PIPModel data) => json.encode(data.toJson());

class PIPModel {
  PIPModel({
    this.id,
    this.programsId,
    this.description,
    this.proposals,
    this.comments,
    this.date,
  });

  int id;
  int programsId;
  String description;
  String proposals;
  String comments;
  int date;

  factory PIPModel.fromJson(Map<String, dynamic> json) => PIPModel(
        id: json['id'],
        programsId: json['programs_id'],
        description: json['description'],
        proposals: json['proposals'],
        comments: json['comments'],
        date: int.parse(json['date']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'programs_id': programsId,
        'description': description,
        'proposals': proposals,
        'comments': comments,
        'date': date,
      };
}
