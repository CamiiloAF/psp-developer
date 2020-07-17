import 'dart:convert';

import 'package:psp_developer/src/models/graphics/i_graphics_model.dart';
import 'package:psp_developer/src/utils/constants.dart';

GraphicsModel graphicsModelFromJson(String str) =>
    GraphicsModel.fromJson(json.decode(str));

String graphicsModelToJson(GraphicsModel data) => json.encode(data.toJson());

class GraphicsModel {
  GraphicsModel({
    this.sizes,
    this.totalDefects,
    this.totalTimes,
    this.totalDefectsInjected,
    this.totalDefectsRemoved,
  });

  List<SizeModel> sizes;
  List<TotalDefectsByProgramModel> totalDefects;
  List<TotalTimeInPhaseModel> totalTimes;
  List<TotalDefectsInPhaseModel> totalDefectsInjected;
  List<TotalDefectsInPhaseModel> totalDefectsRemoved;

  factory GraphicsModel.fromJson(Map<String, dynamic> json) => GraphicsModel(
        sizes: List<SizeModel>.from(
            json['sizes'].map((x) => SizeModel.fromJson(x))),
        totalDefects: List<TotalDefectsByProgramModel>.from(
            json['total_defects']
                .map((x) => TotalDefectsByProgramModel.fromJson(x))),
        totalTimes: List<TotalTimeInPhaseModel>.from(
            json['total_times'].map((x) => TotalTimeInPhaseModel.fromJson(x))),
        totalDefectsInjected: List<TotalDefectsInPhaseModel>.from(
            json['total_defects_injected']
                .map((x) => TotalDefectsInPhaseModel.fromJson(x))),
        totalDefectsRemoved: List<TotalDefectsInPhaseModel>.from(
            json['total_defects_removed']
                .map((x) => TotalDefectsInPhaseModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'sizes': List<dynamic>.from(sizes.map((x) => x.toJson())),
        'total_defects':
            List<dynamic>.from(totalDefects.map((x) => x.toJson())),
        'total_times': List<dynamic>.from(totalTimes.map((x) => x.toJson())),
        'total_defects_injected':
            List<dynamic>.from(totalDefectsInjected.map((x) => x.toJson())),
        'total_defects_removed':
            List<dynamic>.from(totalDefectsRemoved.map((x) => x.toJson())),
      };
}

class SizeModel implements IGraphicsModel {
  SizeModel({
    this.programName,
    this.totalLines,
  });

  String programName;
  int totalLines;

  factory SizeModel.fromJson(Map<String, dynamic> json) => SizeModel(
        programName: json['program_name'],
        totalLines: json['total_lines'],
      );

  Map<String, dynamic> toJson() => {
        'program_name': programName,
        'total_lines': totalLines,
      };

  @override
  String get domain => programName;

  @override
  int get measure => totalLines;
}

class TotalDefectsByProgramModel implements IGraphicsModel {
  TotalDefectsByProgramModel({
    this.programName,
    this.totalDefects,
  });

  String programName;
  int totalDefects;

  factory TotalDefectsByProgramModel.fromJson(Map<String, dynamic> json) =>
      TotalDefectsByProgramModel(
        programName: json['program_name'],
        totalDefects: json['total_defects'],
      );

  Map<String, dynamic> toJson() => {
        'program_name': programName,
        'total_defects': totalDefects,
      };

  @override
  String get domain => programName;

  @override
  int get measure => totalDefects;
}

class TotalDefectsInPhaseModel implements IGraphicsModel {
  TotalDefectsInPhaseModel({
    this.phaseId,
    this.totalDefects,
  });

  int phaseId;
  int totalDefects;

  factory TotalDefectsInPhaseModel.fromJson(Map<String, dynamic> json) =>
      TotalDefectsInPhaseModel(
        phaseId: json['phaseId'],
        totalDefects: json['total_defects'],
      );

  Map<String, dynamic> toJson() => {
        'phaseId': phaseId,
        'total_defects': totalDefects,
      };

  @override
  String get domain => Constants.PHASES[phaseId - 1].name;

  @override
  int get measure => throw totalDefects;
}

class TotalTimeInPhaseModel implements IGraphicsModel {
  TotalTimeInPhaseModel({
    this.programName,
    this.totalTime,
  });

  String programName;
  int totalTime;

  factory TotalTimeInPhaseModel.fromJson(Map<String, dynamic> json) =>
      TotalTimeInPhaseModel(
        programName: json['program_name'],
        totalTime: json['total_time'],
      );

  Map<String, dynamic> toJson() => {
        'program_name': programName,
        'total_time': totalTime,
      };

  @override
  String get domain => programName;

  @override
  int get measure => totalTime;
}
