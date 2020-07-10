import 'package:intl/intl.dart';
import 'package:psp_developer/src/models/phases_model.dart';
import 'package:psp_developer/src/models/standard_defects_model.dart';

class Constants {
  static const baseUrl = 'https://psp-sena.herokuapp.com/api';
  static const httpCsrfToken = '998c9b2e73529d4015f2c2204eb56201';

  static final format = DateFormat('d MMM yyyy / h:mm a');

  static const TIME_OUT_EXCEPTION_CODE = 1001;
  static const TIME_OUT_SECONDS = 30;

  static const EMAIL_ALREADY_IN_USE = 54;
  static const PHONE_ALREADY_IN_USE = 53;

  //Table names
  static const PROJECTS_TABLE_NAME = 'projects';
  static const MODULES_TABLE_NAME = 'modules';
  static const PROGRAMS_TABLE_NAME = 'programs';

  static const DEFECT_LOGS_TABLE_NAME = 'defect_log';
  static const TIME_LOGS_TABLE_NAME = 'time_log';

  static const TEST_REPORTS_TABLE_NAME = 'test_reports';
  static const PIP_TABLE_NAME = 'pip';
  static const EXPERIENCES_TABLE_NAME = 'experiences';

  static String token;

  static Map<String, String> getHeaders() => {
        'Content-Type': 'application/json; charset=UTF-8',
        'http_csrf_token': httpCsrfToken,
        'http_auth_token': token,
      };

  static const SQL_CREATE_TABLE_PROJECTS =
      'CREATE TABLE ${PROJECTS_TABLE_NAME}('
      'id INT (11) PRIMARY KEY NOT NULL,'
      'name VARCHAR (50) NOT NULL,'
      'description TEXT NOT NULL,'
      'planning_date VARCHAR NOT NULL,'
      'start_date VARCHAR NULL,'
      'finish_date VARCHAR NULL'
      ');';

  static const SQL_CREATE_TABLE_MODULES = 'CREATE TABLE ${MODULES_TABLE_NAME}('
      'id INT (11) PRIMARY KEY NOT NULL,'
      'projects_id INT (11) NOT NULL,'
      'name VARCHAR (50) NOT NULL,'
      'description TEXT NOT NULL,'
      'planning_date VARCHAR NOT NULL,'
      'start_date VARCHAR NULL,'
      'finish_date VARCHAR NULL);';

  static const SQL_CREATE_TABLE_PROGRAMS = 'CREATE TABLE $PROGRAMS_TABLE_NAME('
      'id INT (11) PRIMARY KEY NOT NULL,'
      'users_id INT (11) NOT NULL,'
      'languages_id INT (11) NOT NULL,'
      'modules_id INT(11) NOT NULL,'
      'name VARCHAR (50) NOT NULL,'
      'description TEXT NOT NULL,'
      'total_lines INT DEFAULT NULL,'
      'planning_date VARCHAR NOT NULL,'
      'start_date VARCHAR NOT NULL,'
      'update_date VARCHAR NULL,'
      'delivery_date VARCHAR NULL);';

  static const SQL_CREATE_TABLE_DEFECT_LOGS =
      'CREATE TABLE $DEFECT_LOGS_TABLE_NAME('
      'id INT (11) PRIMARY KEY NOT NULL,'
      'defect_log_chained_id INT (11) NULL,'
      'programs_id INT (11) NOT NULL,'
      'standard_defects_id INT (11) NULL,'
      'phase_added_id INT (11) NOT NULL,'
      'phase_removed_id INT (11) NULL,'
      'description TEXT NOT NULL,'
      'solution TEXT NULL,'
      'start_date VARCHAR NOT NULL,'
      'finish_date VARCHAR NULL,'
      'time_for_repair INT NULL);';

  static const SQL_CREATE_TABLE_TIME_LOGS =
      'CREATE TABLE $TIME_LOGS_TABLE_NAME('
      'id INT (11) PRIMARY KEY NOT NULL,'
      'programs_id INT (11) NOT NULL,'
      'phases_id INT (11) NOT NULL,'
      'start_date VARCHAR NOT NULL,'
      'delta_time DOUBLE NULL,'
      'finish_date VARCHAR NULL,'
      'interruption INT NOT NULL,'
      'comments TEXT NULL);';

  static const SQL_CREATE_TABLE_TEST_REPORTS =
      'CREATE TABLE $TEST_REPORTS_TABLE_NAME('
      'id INT (11) PRIMARY KEY NOT NULL,'
      'programs_id INT (11) NOT NULL,'
      'test_number INT (11) NOT NULL,'
      'test_name VARCHAR (50) NOT NULL,'
      'conditions TEXT NOT NULL,'
      'expected_result TEXT NOT NULL,'
      'current_result TEXT NULL,'
      'description TEXT NULL,'
      'objective TEXT NOT NULL);';

  static const SQL_CREATE_TABLE_PIP = 'CREATE TABLE $PIP_TABLE_NAME('
      'id INT (11) PRIMARY KEY NOT NULL,'
      'programs_id INT (11) NOT NULL,'
      'description TEXT NOT NULL,'
      'proposals TEXT NOT NULL,'
      'comments TEXT NULL,'
      'date VARCHAR NOT NULL);';

  static const SQL_CREATE_TABLE_EXPERIENCES =
      'CREATE TABLE $EXPERIENCES_TABLE_NAME('
      'id INT (11) PRIMARY KEY NOT NULL,'
      'users_id INT (11) NULL,'
      'positions TEXT NOT NULL,'
      'years_generals INT (11) NOT NULL,'
      'years_configuration INT (11) NOT NULL,'
      'years_integration INT (11) NOT NULL,'
      'years_requirements INT (11) NOT NULL,'
      'years_design INT (11) NOT NULL,'
      'years_tests INT (11) NOT NULL,'
      'years_support INT (11) NOT NULL);';

  static final PHASES = [
    PhasesModel(id: 1, name: 'PLAN'),
    PhasesModel(id: 2, name: 'DLD'),
    PhasesModel(id: 3, name: 'CODE'),
    PhasesModel(id: 4, name: 'COMPILE'),
    PhasesModel(id: 5, name: 'UT'),
    PhasesModel(id: 6, name: 'PM')
  ];

  static final STANDARD_DEFECTS = [
    StandardDefectsModel(id: 1, name: 'DOCUMENTATION'),
    StandardDefectsModel(id: 2, name: 'SYNTAX'),
    StandardDefectsModel(id: 3, name: 'BUILD'),
    StandardDefectsModel(id: 4, name: 'PACKAGE'),
    StandardDefectsModel(id: 5, name: 'ASSIGNMENT'),
    StandardDefectsModel(id: 6, name: 'INTERFACE'),
    StandardDefectsModel(id: 7, name: 'CHECKING'),
    StandardDefectsModel(id: 8, name: 'DATA'),
    StandardDefectsModel(id: 9, name: 'FUNCTION'),
    StandardDefectsModel(id: 10, name: 'SYSTEM'),
    StandardDefectsModel(id: 11, name: 'ENVIRONMENT')
  ];

  static final NEW_PART_TYPE = [
    'calculation',
    'data',
    'i/o',
    'logic',
    'setup',
    'text',
  ];

  static final NEW_PART_SIZE = [
    'vs',
    's',
    'm',
    'l',
    'vl',
  ];

  static const NEW_PART_TYPES_SIZE = {
    'calculation-vs': 1,
    'calculation-s': 2,
    'calculation-m': 3,
    'calculation-l': 4,
    'calculation-vl': 5,
    'data-vs': 6,
    'data-s': 7,
    'data-m': 8,
    'data-l': 9,
    'data-vl': 10,
    'i/o-vs': 11,
    'i/o-s': 12,
    'i/o-m': 13,
    'i/o-l': 14,
    'i/o-vl': 15,
    'logic-vs': 16,
    'logic-s': 17,
    'logic-m': 18,
    'logic-l': 19,
    'logic-vl': 20,
    'setup-vs': 21,
    'setup-s': 22,
    'setup-m': 23,
    'setup-l': 24,
    'setup-vl': 25,
    'text-vs': 26,
    'text-s': 27,
    'text-m': 28,
    'text-l': 29,
    'text-vl': 30,
  };
}
