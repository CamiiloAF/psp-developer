class Constants {
  static const baseUrl = 'https://psp-sena.herokuapp.com/api';
  static const httpCsrfToken = '998c9b2e73529d4015f2c2204eb56201';

  //Table names
  static const PROJECTS_TABLE_NAME = 'projects';
  static const MODULES_TABLE_NAME = 'modules';
  static const PROGRAMS_TABLE_NAME = 'programs';

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
}
