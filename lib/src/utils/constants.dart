class Constants {
  static const baseUrl = 'https://psp-sena.herokuapp.com/api';
  static const httpCsrfToken = '998c9b2e73529d4015f2c2204eb56201';

  //Table names
  static const PROJECTS_TABLE_NAME = 'projects';
  static const MODULES_TABLE_NAME = 'modules';
  static const PROGRAMS_TABLE_NAME = 'programs';

  static const DEFECT_LOGS_TABLE_NAME = 'defect_log';
  static const TIME_LOGS_TABLE_NAME = 'time_log';

  static const TEST_REPORTS_TABLE_NAME = 'test_reports';

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
}
