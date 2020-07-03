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

  /// `Ingreso Desarrollador`
  String get loginFormTitle {
    return Intl.message(
      'Ingreso Desarrollador',
      name: 'loginFormTitle',
      desc: '',
      args: [],
    );
  }

  /// `Ingresar`
  String get loginButton {
    return Intl.message(
      'Ingresar',
      name: 'loginButton',
      desc: '',
      args: [],
    );
  }

  /// `ejemplo@correo.com`
  String get hintEmail {
    return Intl.message(
      'ejemplo@correo.com',
      name: 'hintEmail',
      desc: '',
      args: [],
    );
  }

  /// `Correo electrónico`
  String get labelEmail {
    return Intl.message(
      'Correo electrónico',
      name: 'labelEmail',
      desc: '',
      args: [],
    );
  }

  /// `Contraseña`
  String get labelPassword {
    return Intl.message(
      'Contraseña',
      name: 'labelPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirmar Contraseña`
  String get labelConfirmPassword {
    return Intl.message(
      'Confirmar Contraseña',
      name: 'labelConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Email inválido`
  String get invalidEmail {
    return Intl.message(
      'Email inválido',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Se requieren 8 o más caractéres`
  String get invalidPassword {
    return Intl.message(
      'Se requieren 8 o más caractéres',
      name: 'invalidPassword',
      desc: '',
      args: [],
    );
  }

  /// `Las contraseñas no coinciden`
  String get invalidConfirmPassword {
    return Intl.message(
      'Las contraseñas no coinciden',
      name: 'invalidConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Número inválido`
  String get invalidNumber {
    return Intl.message(
      'Número inválido',
      name: 'invalidNumber',
      desc: '',
      args: [],
    );
  }

  /// `Falló el login`
  String get dialogTitleLoginFailed {
    return Intl.message(
      'Falló el login',
      name: 'dialogTitleLoginFailed',
      desc: '',
      args: [],
    );
  }

  /// `Aceptar`
  String get dialogButtonOk {
    return Intl.message(
      'Aceptar',
      name: 'dialogButtonOk',
      desc: '',
      args: [],
    );
  }

  /// `Cancelar`
  String get dialogButtonCancel {
    return Intl.message(
      'Cancelar',
      name: 'dialogButtonCancel',
      desc: '',
      args: [],
    );
  }

  /// `Recuperar`
  String get dialogButtonRecover {
    return Intl.message(
      'Recuperar',
      name: 'dialogButtonRecover',
      desc: '',
      args: [],
    );
  }

  /// `Proyectos`
  String get appBarTitleProjects {
    return Intl.message(
      'Proyectos',
      name: 'appBarTitleProjects',
      desc: '',
      args: [],
    );
  }

  /// `Modulos`
  String get appBarTitleModules {
    return Intl.message(
      'Modulos',
      name: 'appBarTitleModules',
      desc: '',
      args: [],
    );
  }

  /// `Programas`
  String get appBarTitlePrograms {
    return Intl.message(
      'Programas',
      name: 'appBarTitlePrograms',
      desc: '',
      args: [],
    );
  }

  /// `Partes base`
  String get appBarTitleBaseParts {
    return Intl.message(
      'Partes base',
      name: 'appBarTitleBaseParts',
      desc: '',
      args: [],
    );
  }

  /// `Partes nuevas`
  String get appBarTitleNewParts {
    return Intl.message(
      'Partes nuevas',
      name: 'appBarTitleNewParts',
      desc: '',
      args: [],
    );
  }

  /// `Partes reutilizables`
  String get appBarTitleReusableParts {
    return Intl.message(
      'Partes reutilizables',
      name: 'appBarTitleReusableParts',
      desc: '',
      args: [],
    );
  }

  /// `Log de Defectos`
  String get appBarTitleDefectLogs {
    return Intl.message(
      'Log de Defectos',
      name: 'appBarTitleDefectLogs',
      desc: '',
      args: [],
    );
  }

  /// `Log de tiempos`
  String get appBarTitleTimeLogs {
    return Intl.message(
      'Log de tiempos',
      name: 'appBarTitleTimeLogs',
      desc: '',
      args: [],
    );
  }

  /// `Reportes de prueba`
  String get appBarTitleTestReports {
    return Intl.message(
      'Reportes de prueba',
      name: 'appBarTitleTestReports',
      desc: '',
      args: [],
    );
  }

  /// `Partes del programa`
  String get appBarTitleProgramParts {
    return Intl.message(
      'Partes del programa',
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

  /// `Perfil`
  String get appBarTitleProfile {
    return Intl.message(
      'Perfil',
      name: 'appBarTitleProfile',
      desc: '',
      args: [],
    );
  }

  /// `NO ESTÁS AUTORIZADO`
  String get titleNotAutorized {
    return Intl.message(
      'NO ESTÁS AUTORIZADO',
      name: 'titleNotAutorized',
      desc: '',
      args: [],
    );
  }

  /// `Cargando`
  String get progressDialogLoading {
    return Intl.message(
      'Cargando',
      name: 'progressDialogLoading',
      desc: '',
      args: [],
    );
  }

  /// `Guardando`
  String get progressDialogSaving {
    return Intl.message(
      'Guardando',
      name: 'progressDialogSaving',
      desc: '',
      args: [],
    );
  }

  /// `Por favor revise su conexión a internet`
  String get messageNotConnection {
    return Intl.message(
      'Por favor revise su conexión a internet',
      name: 'messageNotConnection',
      desc: '',
      args: [],
    );
  }

  /// `Actualizado con éxito`
  String get message204Update {
    return Intl.message(
      'Actualizado con éxito',
      name: 'message204Update',
      desc: '',
      args: [],
    );
  }

  /// `Solicitud creada incorrectamente`
  String get message400 {
    return Intl.message(
      'Solicitud creada incorrectamente',
      name: 'message400',
      desc: '',
      args: [],
    );
  }

  /// `No autorizado para solicitar recursos`
  String get message401 {
    return Intl.message(
      'No autorizado para solicitar recursos',
      name: 'message401',
      desc: '',
      args: [],
    );
  }

  /// `No tienes suficientes permisos`
  String get message403 {
    return Intl.message(
      'No tienes suficientes permisos',
      name: 'message403',
      desc: '',
      args: [],
    );
  }

  /// `No se encontró información`
  String get message404 {
    return Intl.message(
      'No se encontró información',
      name: 'message404',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected error occurred`
  String get messageUnexpectedError {
    return Intl.message(
      'An unexpected error occurred',
      name: 'messageUnexpectedError',
      desc: '',
      args: [],
    );
  }

  /// `Credenciales incorrectas`
  String get messageIncorrectCredentials {
    return Intl.message(
      'Credenciales incorrectas',
      name: 'messageIncorrectCredentials',
      desc: '',
      args: [],
    );
  }

  /// `¡Te hemos enviado un email!`
  String get messageWeHaveSentEmail {
    return Intl.message(
      '¡Te hemos enviado un email!',
      name: 'messageWeHaveSentEmail',
      desc: '',
      args: [],
    );
  }

  /// `¡Te hemos enviado un SMS!`
  String get messageWeHaveSentSMS {
    return Intl.message(
      '¡Te hemos enviado un SMS!',
      name: 'messageWeHaveSentSMS',
      desc: '',
      args: [],
    );
  }

  /// `Se ha guardado el PIP`
  String get messagePIPHasBeenSave {
    return Intl.message(
      'Se ha guardado el PIP',
      name: 'messagePIPHasBeenSave',
      desc: '',
      args: [],
    );
  }

  /// `No hay información`
  String get thereIsNoInformation {
    return Intl.message(
      'No hay información',
      name: 'thereIsNoInformation',
      desc: '',
      args: [],
    );
  }

  /// `Nombre`
  String get labelName {
    return Intl.message(
      'Nombre',
      name: 'labelName',
      desc: '',
      args: [],
    );
  }

  /// `Debe tener al menos 3 carateres`
  String get inputNameError {
    return Intl.message(
      'Debe tener al menos 3 carateres',
      name: 'inputNameError',
      desc: '',
      args: [],
    );
  }

  /// `Descripción`
  String get labelDescription {
    return Intl.message(
      'Descripción',
      name: 'labelDescription',
      desc: '',
      args: [],
    );
  }

  /// `Este campo es obligatorio`
  String get inputRequiredError {
    return Intl.message(
      'Este campo es obligatorio',
      name: 'inputRequiredError',
      desc: '',
      args: [],
    );
  }

  /// `Fecha de planeación`
  String get labelPlanningDate {
    return Intl.message(
      'Fecha de planeación',
      name: 'labelPlanningDate',
      desc: '',
      args: [],
    );
  }

  /// `Fecha de inicio`
  String get labelStartDate {
    return Intl.message(
      'Fecha de inicio',
      name: 'labelStartDate',
      desc: '',
      args: [],
    );
  }

  /// `Fecha de finalización`
  String get labelFinishDate {
    return Intl.message(
      'Fecha de finalización',
      name: 'labelFinishDate',
      desc: '',
      args: [],
    );
  }

  /// `Teléfono`
  String get labelPhone {
    return Intl.message(
      'Teléfono',
      name: 'labelPhone',
      desc: '',
      args: [],
    );
  }

  /// `Tiempo Delta`
  String get labelDeltaTime {
    return Intl.message(
      'Tiempo Delta',
      name: 'labelDeltaTime',
      desc: '',
      args: [],
    );
  }

  /// `Interrupción`
  String get labelInterruption {
    return Intl.message(
      'Interrupción',
      name: 'labelInterruption',
      desc: '',
      args: [],
    );
  }

  /// `Número:`
  String get labelNumber {
    return Intl.message(
      'Número:',
      name: 'labelNumber',
      desc: '',
      args: [],
    );
  }

  /// `Fase:`
  String get labelPhase {
    return Intl.message(
      'Fase:',
      name: 'labelPhase',
      desc: '',
      args: [],
    );
  }

  /// `Lo desencadenó:`
  String get labelChainedDefectLog {
    return Intl.message(
      'Lo desencadenó:',
      name: 'labelChainedDefectLog',
      desc: '',
      args: [],
    );
  }

  /// `Añadido en:`
  String get labelPhaseAdded {
    return Intl.message(
      'Añadido en:',
      name: 'labelPhaseAdded',
      desc: '',
      args: [],
    );
  }

  /// `Removido en:`
  String get labelPhaseRemoved {
    return Intl.message(
      'Removido en:',
      name: 'labelPhaseRemoved',
      desc: '',
      args: [],
    );
  }

  /// `Defecto estándar:`
  String get labelStandardDefect {
    return Intl.message(
      'Defecto estándar:',
      name: 'labelStandardDefect',
      desc: '',
      args: [],
    );
  }

  /// `No aplica`
  String get labelNone {
    return Intl.message(
      'No aplica',
      name: 'labelNone',
      desc: '',
      args: [],
    );
  }

  /// `Comentarios`
  String get labelComments {
    return Intl.message(
      'Comentarios',
      name: 'labelComments',
      desc: '',
      args: [],
    );
  }

  /// `Solución`
  String get labelSolution {
    return Intl.message(
      'Solución',
      name: 'labelSolution',
      desc: '',
      args: [],
    );
  }

  /// `Inicio de la interrupción`
  String get labelInterruptionStartAt {
    return Intl.message(
      'Inicio de la interrupción',
      name: 'labelInterruptionStartAt',
      desc: '',
      args: [],
    );
  }

  /// `Tiempo en reparar`
  String get labelTimeForRepair {
    return Intl.message(
      'Tiempo en reparar',
      name: 'labelTimeForRepair',
      desc: '',
      args: [],
    );
  }

  /// `Condiciones`
  String get labelConditions {
    return Intl.message(
      'Condiciones',
      name: 'labelConditions',
      desc: '',
      args: [],
    );
  }

  /// `Resultado esperado`
  String get labelExpectedResult {
    return Intl.message(
      'Resultado esperado',
      name: 'labelExpectedResult',
      desc: '',
      args: [],
    );
  }

  /// `Resultado actual`
  String get labelCurrentResult {
    return Intl.message(
      'Resultado actual',
      name: 'labelCurrentResult',
      desc: '',
      args: [],
    );
  }

  /// `Objetivo`
  String get labelObjective {
    return Intl.message(
      'Objetivo',
      name: 'labelObjective',
      desc: '',
      args: [],
    );
  }

  /// `Número del test`
  String get labelTestNumber {
    return Intl.message(
      'Número del test',
      name: 'labelTestNumber',
      desc: '',
      args: [],
    );
  }

  /// `Líneas base planeadas`
  String get labelPlannedLinesBase {
    return Intl.message(
      'Líneas base planeadas',
      name: 'labelPlannedLinesBase',
      desc: '',
      args: [],
    );
  }

  /// `Líneas borradas planeadas`
  String get labelPlannedLinesDeleted {
    return Intl.message(
      'Líneas borradas planeadas',
      name: 'labelPlannedLinesDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Líneas editadas planeadas`
  String get labelPlannedLinesEdits {
    return Intl.message(
      'Líneas editadas planeadas',
      name: 'labelPlannedLinesEdits',
      desc: '',
      args: [],
    );
  }

  /// `Líneas añadidas planeadas`
  String get labelPlannedLinesAdded {
    return Intl.message(
      'Líneas añadidas planeadas',
      name: 'labelPlannedLinesAdded',
      desc: '',
      args: [],
    );
  }

  /// `Programa Base:`
  String get labelBaseProgram {
    return Intl.message(
      'Programa Base:',
      name: 'labelBaseProgram',
      desc: '',
      args: [],
    );
  }

  /// `Programa Reutilizable:`
  String get labelReusableProgram {
    return Intl.message(
      'Programa Reutilizable:',
      name: 'labelReusableProgram',
      desc: '',
      args: [],
    );
  }

  /// `No hay otros programas`
  String get labelDoNotHavePrograms {
    return Intl.message(
      'No hay otros programas',
      name: 'labelDoNotHavePrograms',
      desc: '',
      args: [],
    );
  }

  /// `Métodos planeados`
  String get labelMethodsPlanned {
    return Intl.message(
      'Métodos planeados',
      name: 'labelMethodsPlanned',
      desc: '',
      args: [],
    );
  }

  /// `Tipo`
  String get labelType {
    return Intl.message(
      'Tipo',
      name: 'labelType',
      desc: '',
      args: [],
    );
  }

  /// `Tamaño`
  String get labelSize {
    return Intl.message(
      'Tamaño',
      name: 'labelSize',
      desc: '',
      args: [],
    );
  }

  /// `Recuperar contraseña mediante email`
  String get labelRestorePasswordByEmail {
    return Intl.message(
      'Recuperar contraseña mediante email',
      name: 'labelRestorePasswordByEmail',
      desc: '',
      args: [],
    );
  }

  /// `Recuperar contraseña mediante número telefónico`
  String get labelRestorePasswordByPhoneNumber {
    return Intl.message(
      'Recuperar contraseña mediante número telefónico',
      name: 'labelRestorePasswordByPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Recuperar contraseña`
  String get labelRestorePassword {
    return Intl.message(
      'Recuperar contraseña',
      name: 'labelRestorePassword',
      desc: '',
      args: [],
    );
  }

  /// `Propuestas`
  String get labelProposals {
    return Intl.message(
      'Propuestas',
      name: 'labelProposals',
      desc: '',
      args: [],
    );
  }

  /// `Fecha`
  String get labelDate {
    return Intl.message(
      'Fecha',
      name: 'labelDate',
      desc: '',
      args: [],
    );
  }

  /// `Apellido`
  String get labelLastName {
    return Intl.message(
      'Apellido',
      name: 'labelLastName',
      desc: '',
      args: [],
    );
  }

  /// `Cambiar contraseña`
  String get labelChangePassword {
    return Intl.message(
      'Cambiar contraseña',
      name: 'labelChangePassword',
      desc: '',
      args: [],
    );
  }

  /// `Número inválido`
  String get inputPhoneError {
    return Intl.message(
      'Número inválido',
      name: 'inputPhoneError',
      desc: '',
      args: [],
    );
  }

  /// `Mantenga presionado el icono para poner la fecha y hora actual`
  String get helperInputDate {
    return Intl.message(
      'Mantenga presionado el icono para poner la fecha y hora actual',
      name: 'helperInputDate',
      desc: '',
      args: [],
    );
  }

  /// `Tiempo en minutos`
  String get helperTimeInMinutes {
    return Intl.message(
      'Tiempo en minutos',
      name: 'helperTimeInMinutes',
      desc: '',
      args: [],
    );
  }

  /// `Iniciar la interrupción`
  String get buttonStartInterruption {
    return Intl.message(
      'Iniciar la interrupción',
      name: 'buttonStartInterruption',
      desc: '',
      args: [],
    );
  }

  /// `Detener la interrupción`
  String get buttonStopInterruption {
    return Intl.message(
      'Detener la interrupción',
      name: 'buttonStopInterruption',
      desc: '',
      args: [],
    );
  }

  /// `Guardar`
  String get save {
    return Intl.message(
      'Guardar',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Cerrar sesión`
  String get optionLogOut {
    return Intl.message(
      'Cerrar sesión',
      name: 'optionLogOut',
      desc: '',
      args: [],
    );
  }

  /// `Ajustes`
  String get optionSettings {
    return Intl.message(
      'Ajustes',
      name: 'optionSettings',
      desc: '',
      args: [],
    );
  }

  /// `Modo oscuro`
  String get darkMode {
    return Intl.message(
      'Modo oscuro',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `Modo claro`
  String get lightMode {
    return Intl.message(
      'Modo claro',
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