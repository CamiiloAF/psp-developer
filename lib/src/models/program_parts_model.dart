import 'dart:convert';

import 'package:psp_developer/src/models/base_parts_model.dart';
import 'package:psp_developer/src/models/new_parts_model.dart';
import 'package:psp_developer/src/models/reusable_parts_model.dart';

String programPartsModelToJson(ProgramPartsModel data) =>
    json.encode(data.toJson());

class ProgramPartsModel {
  ProgramPartsModel({
    this.baseParts,
    this.reusableParts,
    this.newParts,
  });

  List<BasePartModel> baseParts;
  List<ReusablePartModel> reusableParts;
  List<NewPartModel> newParts;

  Map<String, dynamic> toJson() => {
        'base_parts': baseParts ?? [],
        'reusable_parts': reusableParts ?? [],
        'new_parts': newParts,
      };
}
