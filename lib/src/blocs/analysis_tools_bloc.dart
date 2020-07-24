import 'package:psp_developer/src/models/analysis_tools/analysis_tools_model.dart';
import 'package:psp_developer/src/models/analysis_tools/graphics_item_model.dart';
import 'package:psp_developer/src/repositories/analysis_tools_repository.dart';
import 'package:psp_developer/src/utils/constants.dart';
import 'package:psp_developer/src/utils/utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

class AnalysisToolsBloc {
  final _analysisToolsRepository = AnalysisToolsRepository();

  final _analysisToolsController =
      BehaviorSubject<Tuple2<int, List<AnalysisToolsModel>>>();

  Stream<Tuple2<int, List<AnalysisToolsModel>>> get analysisToolsStream =>
      _analysisToolsController.stream;

  Tuple2<int, List<AnalysisToolsModel>>
      get lastValueAnalysisToolsModelController =>
          _analysisToolsController.value;

  void getAnalysisTools(int userId) async {
    final analysisToolsWithStatusCode =
        await _analysisToolsRepository.getAnalysisTools(userId);

    if (analysisToolsWithStatusCode.item1 == 404) {
      _analysisToolsController.sink.add(Tuple2(
          Constants.MUST_BE_HAVE_AT_LEAST_3_COMPLETED_PROGRAMS,
          analysisToolsWithStatusCode.item2));
    } else {
      _analysisToolsController.sink.add(analysisToolsWithStatusCode);
    }
  }

  List<GraphicsItemModel> getTotalSizesByProgram() {
    final items = <GraphicsItemModel>[];

    if (!isNullOrEmpty(lastValueAnalysisToolsModelController.item2)) {
      lastValueAnalysisToolsModelController.item2.forEach((element) {
        items.add(GraphicsItemModel(
            domain: element.programName, measure: element.size));
      });
    }

    return items;
  }

  List<GraphicsItemModel> getTotalTimesByProgram() {
    final items = <GraphicsItemModel>[];

    if (!isNullOrEmpty(lastValueAnalysisToolsModelController.item2)) {
      lastValueAnalysisToolsModelController.item2.forEach((element) {
        items.add(GraphicsItemModel(
            domain: element.programName, measure: element.time));
      });
    }

    return items;
  }

  List<GraphicsItemModel> getTotalDefectsByProgram() {
    final items = <GraphicsItemModel>[];

    if (!isNullOrEmpty(lastValueAnalysisToolsModelController.item2)) {
      lastValueAnalysisToolsModelController.item2.forEach((element) {
        items.add(GraphicsItemModel(
            domain: element.programName, measure: element.defects));
      });
    }

    return items;
  }

  List<GraphicsItemModel> getDefectsInjectedByPhase() {
    var defectsInjected = <DefectsModel>[];

    if (!isNullOrEmpty(lastValueAnalysisToolsModelController.item2)) {
      lastValueAnalysisToolsModelController.item2.forEach((element) {
        if (!isNullOrEmpty(element.defectsInjected)) {
          defectsInjected += element.defectsInjected;
        }
      });
    }

    return _getTotalDefectsInPhase(defectsInjected);
  }

  List<GraphicsItemModel> getDefectsRemovedByPhase() {
    var defectsRemoved = <DefectsModel>[];

    if (!isNullOrEmpty(lastValueAnalysisToolsModelController.item2)) {
      lastValueAnalysisToolsModelController.item2.forEach((element) {
        if (!isNullOrEmpty(element.defectsRemoved)) {
          defectsRemoved += element.defectsRemoved;
        }
      });
    }

    return _getTotalDefectsInPhase(defectsRemoved);
  }

  List<GraphicsItemModel> _getTotalDefectsInPhase(List<DefectsModel> defects) {
    var defectsInPlan = 0;
    var defectsInDld = 0;
    var defectsInCode = 0;
    var defectsInCompile = 0;
    var defectsInUt = 0;
    var defectsInPm = 0;

    defects.forEach((defect) {
      switch (defect.phasesId) {
        case 1:
          defectsInPlan += defect.amount;
          break;
        case 2:
          defectsInDld += defect.amount;
          break;
        case 3:
          defectsInCode += defect.amount;
          break;
        case 4:
          defectsInCompile += defect.amount;
          break;
        case 5:
          defectsInUt += defect.amount;
          break;
        default:
          defectsInPm += defect.amount;
      }
    });

    return [
      GraphicsItemModel(domain: _getPhaseName(1), measure: defectsInPlan),
      GraphicsItemModel(domain: _getPhaseName(2), measure: defectsInDld),
      GraphicsItemModel(domain: _getPhaseName(3), measure: defectsInCode),
      GraphicsItemModel(domain: _getPhaseName(4), measure: defectsInCompile),
      GraphicsItemModel(domain: _getPhaseName(5), measure: defectsInUt),
      GraphicsItemModel(domain: _getPhaseName(6), measure: defectsInPm),
    ];
  }

  String _getPhaseName(int phaseId) => Constants.PHASES[phaseId - 1].name;

  void dispose() => _analysisToolsController?.sink?.add(null);
}
