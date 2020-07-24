class PlanningPerPhaseModel {
  PlanningPerPhaseModel(
      {this.planningTimeInPlan,
        this.planningDefectsInPlan,
        this.planningTimeInDld,
        this.planningDefectsInDld,
        this.planningTimeInCode,
        this.planningDefectsInCode,
        this.planningTimeInCompile,
        this.planningDefectsInCompile,
        this.planningTimeInUt,
        this.planningDefectsInUt,
        this.planningTimeInPm,
        this.planningDefectsInPm});

  int planningTimeInPlan;
  int planningTimeInDld;
  int planningTimeInCode;
  int planningTimeInCompile;
  int planningTimeInUt;
  int planningTimeInPm;

  int planningDefectsInPlan;
  int planningDefectsInDld;
  int planningDefectsInCode;
  int planningDefectsInCompile;
  int planningDefectsInUt;
  int planningDefectsInPm;
}
