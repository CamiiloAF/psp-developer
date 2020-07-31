// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Developer Login`
  String get loginFormTitle {
    return Intl.message(
      'Developer Login',
      name: 'loginFormTitle',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginButton {
    return Intl.message(
      'Login',
      name: 'loginButton',
      desc: '',
      args: [],
    );
  }

  /// `exmaple@mail.com`
  String get hintEmail {
    return Intl.message(
      'exmaple@mail.com',
      name: 'hintEmail',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get labelEmail {
    return Intl.message(
      'Email',
      name: 'labelEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get labelPassword {
    return Intl.message(
      'Password',
      name: 'labelPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get labelConfirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'labelConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email`
  String get invalidEmail {
    return Intl.message(
      'Invalid email',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `8 or more characters are required`
  String get invalidPassword {
    return Intl.message(
      '8 or more characters are required',
      name: 'invalidPassword',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get invalidConfirmPassword {
    return Intl.message(
      'Passwords do not match',
      name: 'invalidConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Invalid number`
  String get invalidNumber {
    return Intl.message(
      'Invalid number',
      name: 'invalidNumber',
      desc: '',
      args: [],
    );
  }

  /// `Login Failed`
  String get dialogTitleLoginFailed {
    return Intl.message(
      'Login Failed',
      name: 'dialogTitleLoginFailed',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get dialogButtonOk {
    return Intl.message(
      'Ok',
      name: 'dialogButtonOk',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get dialogButtonCancel {
    return Intl.message(
      'Cancel',
      name: 'dialogButtonCancel',
      desc: '',
      args: [],
    );
  }

  /// `Recover`
  String get dialogButtonRecover {
    return Intl.message(
      'Recover',
      name: 'dialogButtonRecover',
      desc: '',
      args: [],
    );
  }

  /// `Experiences`
  String get appBarTitleExperiences {
    return Intl.message(
      'Experiences',
      name: 'appBarTitleExperiences',
      desc: '',
      args: [],
    );
  }

  /// `Projects`
  String get appBarTitleProjects {
    return Intl.message(
      'Projects',
      name: 'appBarTitleProjects',
      desc: '',
      args: [],
    );
  }

  /// `Modules`
  String get appBarTitleModules {
    return Intl.message(
      'Modules',
      name: 'appBarTitleModules',
      desc: '',
      args: [],
    );
  }

  /// `Programs`
  String get appBarTitlePrograms {
    return Intl.message(
      'Programs',
      name: 'appBarTitlePrograms',
      desc: '',
      args: [],
    );
  }

  /// `Base parts`
  String get appBarTitleBaseParts {
    return Intl.message(
      'Base parts',
      name: 'appBarTitleBaseParts',
      desc: '',
      args: [],
    );
  }

  /// `New parts`
  String get appBarTitleNewParts {
    return Intl.message(
      'New parts',
      name: 'appBarTitleNewParts',
      desc: '',
      args: [],
    );
  }

  /// `Reusable parts`
  String get appBarTitleReusableParts {
    return Intl.message(
      'Reusable parts',
      name: 'appBarTitleReusableParts',
      desc: '',
      args: [],
    );
  }

  /// `Defect log`
  String get appBarTitleDefectLogs {
    return Intl.message(
      'Defect log',
      name: 'appBarTitleDefectLogs',
      desc: '',
      args: [],
    );
  }

  /// `Time log`
  String get appBarTitleTimeLogs {
    return Intl.message(
      'Time log',
      name: 'appBarTitleTimeLogs',
      desc: '',
      args: [],
    );
  }

  /// `Test reports`
  String get appBarTitleTestReports {
    return Intl.message(
      'Test reports',
      name: 'appBarTitleTestReports',
      desc: '',
      args: [],
    );
  }

  /// `Program parts`
  String get appBarTitleProgramParts {
    return Intl.message(
      'Program parts',
      name: 'appBarTitleProgramParts',
      desc: '',
      args: [],
    );
  }

  /// `PIP`
  String get appBarTitlePIP {
    return Intl.message(
      'PIP',
      name: 'appBarTitlePIP',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get appBarTitleProfile {
    return Intl.message(
      'Profile',
      name: 'appBarTitleProfile',
      desc: '',
      args: [],
    );
  }

  /// `Planning`
  String get appBarTitlePlanning {
    return Intl.message(
      'Planning',
      name: 'appBarTitlePlanning',
      desc: '',
      args: [],
    );
  }

  /// `Analysis tools`
  String get appBarTitleAnalysisTools {
    return Intl.message(
      'Analysis tools',
      name: 'appBarTitleAnalysisTools',
      desc: '',
      args: [],
    );
  }

  /// `Program summary`
  String get appBarTitleProgramSummary {
    return Intl.message(
      'Program summary',
      name: 'appBarTitleProgramSummary',
      desc: '',
      args: [],
    );
  }

  /// `YOU ARE NOT AUTHORIZED`
  String get titleNotAuthorized {
    return Intl.message(
      'YOU ARE NOT AUTHORIZED',
      name: 'titleNotAuthorized',
      desc: '',
      args: [],
    );
  }

  /// `Program size`
  String get titleProgramSize {
    return Intl.message(
      'Program size',
      name: 'titleProgramSize',
      desc: '',
      args: [],
    );
  }

  /// `Time per phase (min)`
  String get titleTimePerPhase {
    return Intl.message(
      'Time per phase (min)',
      name: 'titleTimePerPhase',
      desc: '',
      args: [],
    );
  }

  /// `Defects injected per phase`
  String get titleDefectsInjectedPerPhase {
    return Intl.message(
      'Defects injected per phase',
      name: 'titleDefectsInjectedPerPhase',
      desc: '',
      args: [],
    );
  }

  /// `Defects removed per phase`
  String get titleDefectsRemovedPerPhase {
    return Intl.message(
      'Defects removed per phase',
      name: 'titleDefectsRemovedPerPhase',
      desc: '',
      args: [],
    );
  }

  /// `Size of programs`
  String get titleSizeOfPrograms {
    return Intl.message(
      'Size of programs',
      name: 'titleSizeOfPrograms',
      desc: '',
      args: [],
    );
  }

  /// `Total defects`
  String get titleTotalDefects {
    return Intl.message(
      'Total defects',
      name: 'titleTotalDefects',
      desc: '',
      args: [],
    );
  }

  /// `Total times`
  String get titleTotalTimes {
    return Intl.message(
      'Total times',
      name: 'titleTotalTimes',
      desc: '',
      args: [],
    );
  }

  /// `Loading`
  String get progressDialogLoading {
    return Intl.message(
      'Loading',
      name: 'progressDialogLoading',
      desc: '',
      args: [],
    );
  }

  /// `Saving`
  String get progressDialogSaving {
    return Intl.message(
      'Saving',
      name: 'progressDialogSaving',
      desc: '',
      args: [],
    );
  }

  /// `Please check your internet connection`
  String get messageNotConnection {
    return Intl.message(
      'Please check your internet connection',
      name: 'messageNotConnection',
      desc: '',
      args: [],
    );
  }

  /// `Updated successfully`
  String get message204Update {
    return Intl.message(
      'Updated successfully',
      name: 'message204Update',
      desc: '',
      args: [],
    );
  }

  /// `Request created incorrectly`
  String get message400 {
    return Intl.message(
      'Request created incorrectly',
      name: 'message400',
      desc: '',
      args: [],
    );
  }

  /// `Not authorized to request resources`
  String get message401 {
    return Intl.message(
      'Not authorized to request resources',
      name: 'message401',
      desc: '',
      args: [],
    );
  }

  /// `There are not enough permissions`
  String get message403 {
    return Intl.message(
      'There are not enough permissions',
      name: 'message403',
      desc: '',
      args: [],
    );
  }

  /// `Resource not found`
  String get message404 {
    return Intl.message(
      'Resource not found',
      name: 'message404',
      desc: '',
      args: [],
    );
  }

  /// `Internal server error`
  String get message500 {
    return Intl.message(
      'Internal server error',
      name: 'message500',
      desc: '',
      args: [],
    );
  }

  /// `Has been occurred an unexpected error, try again`
  String get messageUnexpectedError {
    return Intl.message(
      'Has been occurred an unexpected error, try again',
      name: 'messageUnexpectedError',
      desc: '',
      args: [],
    );
  }

  /// `Bad credentials`
  String get messageIncorrectCredentials {
    return Intl.message(
      'Bad credentials',
      name: 'messageIncorrectCredentials',
      desc: '',
      args: [],
    );
  }

  /// `Exceeded maximum number of session attempts per hour`
  String get messageExceededMaximumNumberSessionAttempts {
    return Intl.message(
      'Exceeded maximum number of session attempts per hour',
      name: 'messageExceededMaximumNumberSessionAttempts',
      desc: '',
      args: [],
    );
  }

  /// `¡We've sent you an email!`
  String get messageWeHaveSentEmail {
    return Intl.message(
      '¡We\'ve sent you an email!',
      name: 'messageWeHaveSentEmail',
      desc: '',
      args: [],
    );
  }

  /// `¡We've sent you a SMS!`
  String get messageWeHaveSentSMS {
    return Intl.message(
      '¡We\'ve sent you a SMS!',
      name: 'messageWeHaveSentSMS',
      desc: '',
      args: [],
    );
  }

  /// `The PIP has been saved`
  String get messagePIPHasBeenSave {
    return Intl.message(
      'The PIP has been saved',
      name: 'messagePIPHasBeenSave',
      desc: '',
      args: [],
    );
  }

  /// `There is already a test with that number, try another`
  String get messageAlreadyExistTestNumber {
    return Intl.message(
      'There is already a test with that number, try another',
      name: 'messageAlreadyExistTestNumber',
      desc: '',
      args: [],
    );
  }

  /// `The request took a long time, please try again`
  String get messageTimeOutException {
    return Intl.message(
      'The request took a long time, please try again',
      name: 'messageTimeOutException',
      desc: '',
      args: [],
    );
  }

  /// `There can be no negative difference between dates`
  String get messageNoNegativeDifferenceBetweenDates {
    return Intl.message(
      'There can be no negative difference between dates',
      name: 'messageNoNegativeDifferenceBetweenDates',
      desc: '',
      args: [],
    );
  }

  /// `Email is already in use`
  String get messageEmailIsAlreadyInUse {
    return Intl.message(
      'Email is already in use',
      name: 'messageEmailIsAlreadyInUse',
      desc: '',
      args: [],
    );
  }

  /// `Phone is already in use`
  String get messagePhoneIsAlreadyInUse {
    return Intl.message(
      'Phone is already in use',
      name: 'messagePhoneIsAlreadyInUse',
      desc: '',
      args: [],
    );
  }

  /// `You must have at least 3 completed programs`
  String get messageYouMustHaveCompletedPrograms {
    return Intl.message(
      'You must have at least 3 completed programs',
      name: 'messageYouMustHaveCompletedPrograms',
      desc: '',
      args: [],
    );
  }

  /// `Current program does not meet records to end`
  String get messageProgramDoesNotMeetAllRecords {
    return Intl.message(
      'Current program does not meet records to end',
      name: 'messageProgramDoesNotMeetAllRecords',
      desc: '',
      args: [],
    );
  }

  /// `The program does not have the current parts`
  String get messageProgramDoesNotHaveCurrentParts {
    return Intl.message(
      'The program does not have the current parts',
      name: 'messageProgramDoesNotHaveCurrentParts',
      desc: '',
      args: [],
    );
  }

  /// `The program does not have the delta times`
  String get messageProgramDoesNotHaveDeltaTimes {
    return Intl.message(
      'The program does not have the delta times',
      name: 'messageProgramDoesNotHaveDeltaTimes',
      desc: '',
      args: [],
    );
  }

  /// `There is no information`
  String get thereIsNoInformation {
    return Intl.message(
      'There is no information',
      name: 'thereIsNoInformation',
      desc: '',
      args: [],
    );
  }

  /// `Must be at least 3 characters`
  String get inputNameError {
    return Intl.message(
      'Must be at least 3 characters',
      name: 'inputNameError',
      desc: '',
      args: [],
    );
  }

  /// `This input is required`
  String get inputRequiredError {
    return Intl.message(
      'This input is required',
      name: 'inputRequiredError',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get labelName {
    return Intl.message(
      'Name',
      name: 'labelName',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get labelDescription {
    return Intl.message(
      'Description',
      name: 'labelDescription',
      desc: '',
      args: [],
    );
  }

  /// `Planning date`
  String get labelPlanningDate {
    return Intl.message(
      'Planning date',
      name: 'labelPlanningDate',
      desc: '',
      args: [],
    );
  }

  /// `Update date`
  String get labelUpdateDate {
    return Intl.message(
      'Update date',
      name: 'labelUpdateDate',
      desc: '',
      args: [],
    );
  }

  /// `Delivery date`
  String get labelDeliveryDate {
    return Intl.message(
      'Delivery date',
      name: 'labelDeliveryDate',
      desc: '',
      args: [],
    );
  }

  /// `Start date`
  String get labelStartDate {
    return Intl.message(
      'Start date',
      name: 'labelStartDate',
      desc: '',
      args: [],
    );
  }

  /// `Finish date`
  String get labelFinishDate {
    return Intl.message(
      'Finish date',
      name: 'labelFinishDate',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get labelPhone {
    return Intl.message(
      'Phone',
      name: 'labelPhone',
      desc: '',
      args: [],
    );
  }

  /// `Delta time`
  String get labelDeltaTime {
    return Intl.message(
      'Delta time',
      name: 'labelDeltaTime',
      desc: '',
      args: [],
    );
  }

  /// `Interruption`
  String get labelInterruption {
    return Intl.message(
      'Interruption',
      name: 'labelInterruption',
      desc: '',
      args: [],
    );
  }

  /// `Number:`
  String get labelNumber {
    return Intl.message(
      'Number:',
      name: 'labelNumber',
      desc: '',
      args: [],
    );
  }

  /// `Phase:`
  String get labelPhase {
    return Intl.message(
      'Phase:',
      name: 'labelPhase',
      desc: '',
      args: [],
    );
  }

  /// `ID of the defect that unchained it:`
  String get labelIdChainedDefectLog {
    return Intl.message(
      'ID of the defect that unchained it:',
      name: 'labelIdChainedDefectLog',
      desc: '',
      args: [],
    );
  }

  /// `Added in:`
  String get labelPhaseAdded {
    return Intl.message(
      'Added in:',
      name: 'labelPhaseAdded',
      desc: '',
      args: [],
    );
  }

  /// `Removed in:`
  String get labelPhaseRemoved {
    return Intl.message(
      'Removed in:',
      name: 'labelPhaseRemoved',
      desc: '',
      args: [],
    );
  }

  /// `Standard defect:`
  String get labelStandardDefect {
    return Intl.message(
      'Standard defect:',
      name: 'labelStandardDefect',
      desc: '',
      args: [],
    );
  }

  /// `Does not apply`
  String get labelNone {
    return Intl.message(
      'Does not apply',
      name: 'labelNone',
      desc: '',
      args: [],
    );
  }

  /// `Comments`
  String get labelComments {
    return Intl.message(
      'Comments',
      name: 'labelComments',
      desc: '',
      args: [],
    );
  }

  /// `Solution`
  String get labelSolution {
    return Intl.message(
      'Solution',
      name: 'labelSolution',
      desc: '',
      args: [],
    );
  }

  /// `Start of interruption`
  String get labelInterruptionStartAt {
    return Intl.message(
      'Start of interruption',
      name: 'labelInterruptionStartAt',
      desc: '',
      args: [],
    );
  }

  /// `Time to repair`
  String get labelTimeForRepair {
    return Intl.message(
      'Time to repair',
      name: 'labelTimeForRepair',
      desc: '',
      args: [],
    );
  }

  /// `Conditions`
  String get labelConditions {
    return Intl.message(
      'Conditions',
      name: 'labelConditions',
      desc: '',
      args: [],
    );
  }

  /// `Expected result`
  String get labelExpectedResult {
    return Intl.message(
      'Expected result',
      name: 'labelExpectedResult',
      desc: '',
      args: [],
    );
  }

  /// `Current result`
  String get labelCurrentResult {
    return Intl.message(
      'Current result',
      name: 'labelCurrentResult',
      desc: '',
      args: [],
    );
  }

  /// `Objective`
  String get labelObjective {
    return Intl.message(
      'Objective',
      name: 'labelObjective',
      desc: '',
      args: [],
    );
  }

  /// `Test number`
  String get labelTestNumber {
    return Intl.message(
      'Test number',
      name: 'labelTestNumber',
      desc: '',
      args: [],
    );
  }

  /// `Planned base lines`
  String get labelPlannedLinesBase {
    return Intl.message(
      'Planned base lines',
      name: 'labelPlannedLinesBase',
      desc: '',
      args: [],
    );
  }

  /// `Planned deleted lines`
  String get labelPlannedLinesDeleted {
    return Intl.message(
      'Planned deleted lines',
      name: 'labelPlannedLinesDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Planned edited lines`
  String get labelPlannedLinesEdits {
    return Intl.message(
      'Planned edited lines',
      name: 'labelPlannedLinesEdits',
      desc: '',
      args: [],
    );
  }

  /// `Planned added lines`
  String get labelPlannedLinesAdded {
    return Intl.message(
      'Planned added lines',
      name: 'labelPlannedLinesAdded',
      desc: '',
      args: [],
    );
  }

  /// `Planned lines:`
  String get labelPlannedLines {
    return Intl.message(
      'Planned lines:',
      name: 'labelPlannedLines',
      desc: '',
      args: [],
    );
  }

  /// `Current base lines`
  String get labelCurrentLinesBase {
    return Intl.message(
      'Current base lines',
      name: 'labelCurrentLinesBase',
      desc: '',
      args: [],
    );
  }

  /// `Current deleted lines`
  String get labelCurrentLinesDeleted {
    return Intl.message(
      'Current deleted lines',
      name: 'labelCurrentLinesDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Current edited lines`
  String get labelCurrentLinesEdits {
    return Intl.message(
      'Current edited lines',
      name: 'labelCurrentLinesEdits',
      desc: '',
      args: [],
    );
  }

  /// `Current added lines`
  String get labelCurrentLinesAdded {
    return Intl.message(
      'Current added lines',
      name: 'labelCurrentLinesAdded',
      desc: '',
      args: [],
    );
  }

  /// `Base Program:`
  String get labelBaseProgram {
    return Intl.message(
      'Base Program:',
      name: 'labelBaseProgram',
      desc: '',
      args: [],
    );
  }

  /// `Reusable Program:`
  String get labelReusableProgram {
    return Intl.message(
      'Reusable Program:',
      name: 'labelReusableProgram',
      desc: '',
      args: [],
    );
  }

  /// `There are no other programs`
  String get labelDoNotHavePrograms {
    return Intl.message(
      'There are no other programs',
      name: 'labelDoNotHavePrograms',
      desc: '',
      args: [],
    );
  }

  /// `Planned methods`
  String get labelMethodsPlanned {
    return Intl.message(
      'Planned methods',
      name: 'labelMethodsPlanned',
      desc: '',
      args: [],
    );
  }

  /// `Current methods`
  String get labelMethodsCurrent {
    return Intl.message(
      'Current methods',
      name: 'labelMethodsCurrent',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get labelType {
    return Intl.message(
      'Type',
      name: 'labelType',
      desc: '',
      args: [],
    );
  }

  /// `Size`
  String get labelSize {
    return Intl.message(
      'Size',
      name: 'labelSize',
      desc: '',
      args: [],
    );
  }

  /// `Restore password by email`
  String get labelRestorePasswordByEmail {
    return Intl.message(
      'Restore password by email',
      name: 'labelRestorePasswordByEmail',
      desc: '',
      args: [],
    );
  }

  /// `Restore password by phone number`
  String get labelRestorePasswordByPhoneNumber {
    return Intl.message(
      'Restore password by phone number',
      name: 'labelRestorePasswordByPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Restore password`
  String get labelRestorePassword {
    return Intl.message(
      'Restore password',
      name: 'labelRestorePassword',
      desc: '',
      args: [],
    );
  }

  /// `Proposals`
  String get labelProposals {
    return Intl.message(
      'Proposals',
      name: 'labelProposals',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get labelDate {
    return Intl.message(
      'Date',
      name: 'labelDate',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get labelLastName {
    return Intl.message(
      'Last name',
      name: 'labelLastName',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get labelChangePassword {
    return Intl.message(
      'Change password',
      name: 'labelChangePassword',
      desc: '',
      args: [],
    );
  }

  /// `Positions`
  String get labelPositions {
    return Intl.message(
      'Positions',
      name: 'labelPositions',
      desc: '',
      args: [],
    );
  }

  /// `Organization`
  String get labelOrganization {
    return Intl.message(
      'Organization',
      name: 'labelOrganization',
      desc: '',
      args: [],
    );
  }

  /// `Years in general`
  String get labelYearsGenerals {
    return Intl.message(
      'Years in general',
      name: 'labelYearsGenerals',
      desc: '',
      args: [],
    );
  }

  /// `Years in configuration`
  String get labelYearsConfiguration {
    return Intl.message(
      'Years in configuration',
      name: 'labelYearsConfiguration',
      desc: '',
      args: [],
    );
  }

  /// `Years in integration`
  String get labelYearsIntegration {
    return Intl.message(
      'Years in integration',
      name: 'labelYearsIntegration',
      desc: '',
      args: [],
    );
  }

  /// `Years in requirements`
  String get labelYearsRequirements {
    return Intl.message(
      'Years in requirements',
      name: 'labelYearsRequirements',
      desc: '',
      args: [],
    );
  }

  /// `Years in design`
  String get labelYearsDesign {
    return Intl.message(
      'Years in design',
      name: 'labelYearsDesign',
      desc: '',
      args: [],
    );
  }

  /// `Years in tests`
  String get labelYearsTests {
    return Intl.message(
      'Years in tests',
      name: 'labelYearsTests',
      desc: '',
      args: [],
    );
  }

  /// `Years in support`
  String get labelYearsSupport {
    return Intl.message(
      'Years in support',
      name: 'labelYearsSupport',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get labelLoading {
    return Intl.message(
      'Loading...',
      name: 'labelLoading',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get labelLanguage {
    return Intl.message(
      'Language',
      name: 'labelLanguage',
      desc: '',
      args: [],
    );
  }

  /// `System language`
  String get labelSystemLanguage {
    return Intl.message(
      'System language',
      name: 'labelSystemLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Estimated time in {phase}`
  String labelWithPlaceHolderEstimatedTimeIn(Object phase) {
    return Intl.message(
      'Estimated time in $phase',
      name: 'labelWithPlaceHolderEstimatedTimeIn',
      desc: '',
      args: [phase],
    );
  }

  /// `Estimated defects in {phase}`
  String labelWithPlaceHolderEstimatedDefectsIn(Object phase) {
    return Intl.message(
      'Estimated defects in $phase',
      name: 'labelWithPlaceHolderEstimatedDefectsIn',
      desc: '',
      args: [phase],
    );
  }

  /// `Finish program`
  String get labelFinishProgram {
    return Intl.message(
      'Finish program',
      name: 'labelFinishProgram',
      desc: '',
      args: [],
    );
  }

  /// `Planned`
  String get labelPlanned {
    return Intl.message(
      'Planned',
      name: 'labelPlanned',
      desc: '',
      args: [],
    );
  }

  /// `Current`
  String get labelCurrent {
    return Intl.message(
      'Current',
      name: 'labelCurrent',
      desc: '',
      args: [],
    );
  }

  /// `Base`
  String get labelBase {
    return Intl.message(
      'Base',
      name: 'labelBase',
      desc: '',
      args: [],
    );
  }

  /// `Deleted`
  String get labelDeleted {
    return Intl.message(
      'Deleted',
      name: 'labelDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Modified`
  String get labelModified {
    return Intl.message(
      'Modified',
      name: 'labelModified',
      desc: '',
      args: [],
    );
  }

  /// `Added`
  String get labelAdded {
    return Intl.message(
      'Added',
      name: 'labelAdded',
      desc: '',
      args: [],
    );
  }

  /// `Reused`
  String get labelReused {
    return Intl.message(
      'Reused',
      name: 'labelReused',
      desc: '',
      args: [],
    );
  }

  /// `New`
  String get labelNew {
    return Intl.message(
      'New',
      name: 'labelNew',
      desc: '',
      args: [],
    );
  }

  /// `To date`
  String get labelToDate {
    return Intl.message(
      'To date',
      name: 'labelToDate',
      desc: '',
      args: [],
    );
  }

  /// `Percent`
  String get labelPercent {
    return Intl.message(
      'Percent',
      name: 'labelPercent',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get labelTotal {
    return Intl.message(
      'Total',
      name: 'labelTotal',
      desc: '',
      args: [],
    );
  }

  /// `Press and hold the icon to set the current date and time`
  String get helperInputDate {
    return Intl.message(
      'Press and hold the icon to set the current date and time',
      name: 'helperInputDate',
      desc: '',
      args: [],
    );
  }

  /// `Time in minutes`
  String get helperTimeInMinutes {
    return Intl.message(
      'Time in minutes',
      name: 'helperTimeInMinutes',
      desc: '',
      args: [],
    );
  }

  /// `Start interruption`
  String get buttonStartInterruption {
    return Intl.message(
      'Start interruption',
      name: 'buttonStartInterruption',
      desc: '',
      args: [],
    );
  }

  /// `Stop interruption`
  String get buttonStopInterruption {
    return Intl.message(
      'Stop interruption',
      name: 'buttonStopInterruption',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get optionLogOut {
    return Intl.message(
      'Log out',
      name: 'optionLogOut',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get optionSettings {
    return Intl.message(
      'Settings',
      name: 'optionSettings',
      desc: '',
      args: [],
    );
  }

  /// `Dark mode`
  String get darkMode {
    return Intl.message(
      'Dark mode',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `Light mode`
  String get lightMode {
    return Intl.message(
      'Light mode',
      name: 'lightMode',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}