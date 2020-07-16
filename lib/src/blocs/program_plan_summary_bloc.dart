class ProgramPlanSummaryBloc{
  final items = {
    'base_planned': 1,
    'base_actual': 2,
    'deleted_planned': 3,
    'deleted_actual': 4,
    'modified_planned': 5,
    'modified_actual': 6,
    'added_planned': 7,
    'added_actual': 8,
    'reused_planned': 9,
    'reused_actual': 10
  };

  final itemsTime = [
    {'phaseId': 1, 'actualTime': 10, 'percent': 90},
    {'phaseId': 2, 'actualTime': 10, 'percent': 90},
    {'phaseId': 3, 'actualTime': 10, 'percent': 90},
    {'phaseId': 4, 'actualTime': 10, 'percent': 90},
    {'phaseId': 5, 'actualTime': 10, 'percent': 90}
  ];

  final defectsInjected = [
    {'phaseId': 1, 'defectsInjected': 10, 'percent': 90},
    {'phaseId': 2, 'defectsInjected': 10, 'percent': 90},
    {'phaseId': 3, 'defectsInjected': 10, 'percent': 90},
    {'phaseId': 4, 'defectsInjected': 10, 'percent': 90},
    {'phaseId': 5, 'defectsInjected': 10, 'percent': 90}
  ];

  final defectsRemoved = [
    {'phaseId': 1, 'defectsRemoved': 10, 'percent': 90},
    {'phaseId': 2, 'defectsRemoved': 10, 'percent': 90},
    {'phaseId': 3, 'defectsRemoved': 10, 'percent': 90},
    {'phaseId': 4, 'defectsRemoved': 10, 'percent': 90},
    {'phaseId': 5, 'defectsRemoved': 10, 'percent': 90}
  ];


}