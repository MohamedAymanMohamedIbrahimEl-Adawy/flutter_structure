// class ApiEndpointsConstants {
//   static const String baseUrl = 'http://10.105.196.12:7112/';
//   // static const String baseUrl = 'http://10.30.12.117:7112/';
//   static const String login = 'Authentication';
//   static const String logout = 'Logout/Logout';
//   static const String register = 'register';
//   static const String banners = 'Banner';
//   static const String dailyNews = 'DailyNews';
//   static const String userResponseHeader = 'User/GetUserInfo';
//   static const String calendarEvents = 'Calendar/EventDetails';
//   static const String calendarView = 'Calendar';
//   static const String employeeTypes = 'Lookups/EmployeeTypes';
//   static const String branchs = 'Lookups/Branches';
//   static const String sectors = 'Lookups/Departments';
//   static const String suggestedFields = 'Lookups/SuggesstionTypes';
//   static const String searchGuide = 'searchGuide';
//   static const String notifications = 'Notifications';
//   static const String deleteNotifications = 'Notifications';
//   static const String readNotifications = 'Notifications/ReadNotification';
//   static const String searchForEmployee = 'User/SearchForEmployee';
//   static const String news = 'MediaCenter/News';
//   static const String activities = 'MediaCenter/Events';
//   static const String getEmplyeeDetails = 'User/GetEmplyeeDetails';
//   static const String monthlySalaries = 'EmployeeFinancial/Salaries';
//   static const String getMyDataDetails = 'User/GetUserServiceInfo';
//   static const String myHolidays = 'Vacation/EmployeeVacationData';
//   static const String allHolidays = 'Vacation/EmployeeVacationDetails';
//   static const String allowances = 'EmployeeFinancial/Allowances';
//   static const String alternatives = 'EmployeeFinancial/SalaryAllowances';
//   static const String deductions = 'EmployeeFinancial/SalaryDeductions';
//   static const String availableMaintenanceServices =
//       '/availableMaintenanceServices';
//   static const String availableMaintenanceServicesLocations =
//       '/availableMaintenanceServicesLocations';
//   // static const String maintenanceRequests = 'maintenanceRequests';
//   static const String maintenanceRequests = 'GeneralMaintenance/Requests';
//   static const String getDetailsIdentyCard =
//       'User/GetEmplyeeInfoForBusinessCard';
//   static const String requestService = 'RequestSerivce/SendBusinessCardRequest';
//   static const String createMaintenanceRequest = 'createMaintenanceRequest';
//   static const String servicesTypes = 'servicesTypes';
//   static const String servicesLocations = 'servicesLocations';
//   static const String allTechnicalRequest =
//       'RequestSerivce/SendReportProblemRequest';
//   static const String availableMaintenanceTypes =
//       'GeneralMaintenance/GetEligibleUserMaintainanceInfo';
//   static const String allTechnicalSupportRequestsList =
//       'RequestService/GetTechnicalSupportRequestsPaginatedList';
//   static const String servicesApp = "ServicesApp";
//   static const String pointsMap = 'PointsMap';
//   static const String documentReport = 'VoiceHeard/SendReport';
//   static const String note = 'Notes';

//   static const String suggestion =
//       'VoiceHeard/SendSuggestionOrInitiativeRequest';
//   static const String query = 'VoiceHeard/SendInquiryRequest';
//   static const String complaint = 'VoiceHeard/SendComplaintRequest';
//   static const String favouriteList = 'Features';
//   static const String allFavourites = 'Favorites';
//   static const String previousRequests = 'VoiceHeard/GetRequests';
//   static const String vacationTypes = 'Lookups/VacationTypes';
//   static const String salariesBasicInformation =
//       'EmployeeFinancial/SalariesBasicInformation';
//   static const String voiceHeardGetDetails = 'VoiceHeard/GetDetails';
//   static const String getTechnicalSupportServiceModel =
//       'RequestService/GetTechnicalSupportCategoryTemplate';
//   static const String techSupportServices =
//       'RequestService/GetTechnicalSupportServicesTypes';
//   static const String getTechnicalSupportSubCategoryTemplate =
//       'RequestService/GetTechnicalSupportSubCategoryTemplate';
//   static const String getTechnicalSupportSubCategoryTemplateItems =
//       'RequestService/GetTechnicalSupportSubCategoryTemplateItems';
//   static const String createTechnicalSupportRequestOrReport =
//       'RequestService/CreateTechnicalSupportRequestOrReport';
//   static const String maintenanceForm =
//       'GeneralMaintenance/GetMaintainanceProps';
// }

import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpointsConstants {
  static String get baseUrl => dotenv.env['BASE_URL_DEV']!;

  static String get dailyInstituteBaseUrl =>
      dotenv.env['dailyInstituteBaseUrl']!;

  // Authentication
  static String get login => dotenv.env['LOGIN_ENDPOINT']!;
  static String get getRefreshToken => dotenv.env['REFRESH_LOGIN_ENDPOINT']!;
  static String get logout => dotenv.env['LOGOUT_ENDPOINT']!;
  static String get register => dotenv.env['REGISTER_ENDPOINT']!;

  // Banner & News
  static String get banners => dotenv.env['BANNERS_ENDPOINT']!;
  static String get dailyNews => dotenv.env['DAILY_NEWS_ENDPOINT']!;
  static String get dailyNewsDetails =>
      dotenv.env['DAILY_NEWS_DETAILS_ENDPOINT']!;
  static String get dailyNewsWeb => dotenv.env['DAILY_NEWS_WEB_ENDPOINT']!;
  static String get userResponseHeader =>
      dotenv.env['USER_RESPONSE_HEADER_ENDPOINT']!;
  static String get news => dotenv.env['NEWS_ENDPOINT']!;
  static String get activities => dotenv.env['ACTIVITIES_ENDPOINT']!;

  // Calendar
  static String get calendarEvents => dotenv.env['CALENDAR_EVENTS_ENDPOINT']!;
  static String get calendarEventsTypes =>
      dotenv.env['CALENDAR_EVENTS_TYPES_ENDPOINT']!;
  static String get calendarView => dotenv.env['CALENDAR_VIEW_ENDPOINT']!;

  // Lookups
  static String get employeeTypes => dotenv.env['EMPLOYEE_TYPES_ENDPOINT']!;
  static String get branchs => dotenv.env['BRANCHES_ENDPOINT']!;
  static String get sectors => dotenv.env['SECTORS_ENDPOINT']!;
  static String get suggestedFields => dotenv.env['SUGGESTED_FIELDS_ENDPOINT']!;
  static String get vacationTypes => dotenv.env['VACATION_TYPES_ENDPOINT']!;

  // Notifications
  static String get notifications => dotenv.env['NOTIFICATIONS_ENDPOINT']!;
  static String get deleteNotifications =>
      dotenv.env['DELETE_NOTIFICATIONS_ENDPOINT']!;
  static String get readNotifications =>
      dotenv.env['READ_NOTIFICATIONS_ENDPOINT']!;

  // User
  static String get searchGuide => dotenv.env['SEARCH_GUIDE_ENDPOINT']!;
  static String get searchForEmployee =>
      dotenv.env['SEARCH_EMPLOYEE_ENDPOINT']!;
  static String get getEmplyeeDetails =>
      dotenv.env['EMPLOYEE_DETAILS_ENDPOINT']!;
  static String get getMyDataDetails => dotenv.env['MY_DATA_DETAILS_ENDPOINT']!;
  static String get getDetailsIdentyCard =>
      dotenv.env['GET_DETAILS_ID_CARD_ENDPOINT']!;

  // Financial
  static String get monthlySalaries => dotenv.env['MONTHLY_SALARIES_ENDPOINT']!;
  static String get allowances => dotenv.env['ALLOWANCES_ENDPOINT']!;
  static String get alternatives => dotenv.env['ALTERNATIVES_ENDPOINT']!;
  static String get deductions => dotenv.env['DEDUCTIONS_ENDPOINT']!;
  static String get salariesBasicInformation =>
      dotenv.env['SALARIES_BASIC_INFO_ENDPOINT']!;

  // Vacation
  static String get myHolidays => dotenv.env['MY_HOLIDAYS_ENDPOINT']!;
  static String get allHolidays => dotenv.env['ALL_HOLIDAYS_ENDPOINT']!;

  // Maintenance
  static String get maintenanceRequests =>
      dotenv.env['MAINTENANCE_REQUESTS_ENDPOINT']!;
  static String get availableMaintenanceServices =>
      dotenv.env['AVAILABLE_MAINTENANCE_SERVICES_ENDPOINT']!;
  static String get availableMaintenanceLocations =>
      dotenv.env['AVAILABLE_MAINTENANCE_LOCATIONS_ENDPOINT']!;
  static String get availableMaintenanceTypes =>
      dotenv.env['AVAILABLE_MAINTENANCE_TYPES_ENDPOINT']!;
  static String get maintenanceForm => dotenv.env['MAINTENANCE_FORM_ENDPOINT']!;
  static String get createMaintenanceRequest =>
      dotenv.env['CREATE_MAINTENANCE_REQUEST_ENDPOINT']!;

  // Technical Support
  static String get allTechnicalSupportRequestsList =>
      dotenv.env['ALL_TECH_REQUESTS_ENDPOINT']!;
  static String get techSupportServices =>
      dotenv.env['TECH_SUPPORT_SERVICES_ENDPOINT']!;
  static String get getTechnicalSupportServiceModel =>
      dotenv.env['TECH_SUPPORT_MODEL_ENDPOINT']!;
  static String get getTechnicalSupportSubCategoryTemplate =>
      dotenv.env['TECH_SUPPORT_SUBCATEGORY_TEMPLATE_ENDPOINT']!;
  static String get getTechnicalSupportSubCategoryTemplateItems =>
      dotenv.env['TECH_SUPPORT_SUBCATEGORY_ITEMS_ENDPOINT']!;
  static String get createTechnicalSupportRequestOrReport =>
      dotenv.env['CREATE_TECH_SUPPORT_REQUEST_ENDPOINT']!;

  // Voice Heard
  static String get documentReport => dotenv.env['DOCUMENT_REPORT_ENDPOINT']!;
  static String get suggestion => dotenv.env['SUGGESTION_ENDPOINT']!;
  static String get query => dotenv.env['QUERY_ENDPOINT']!;
  static String get complaint => dotenv.env['COMPLAINT_ENDPOINT']!;
  static String get previousRequests =>
      dotenv.env['PREVIOUS_REQUESTS_ENDPOINT']!;
  static String get voiceHeardGetDetails =>
      dotenv.env['VOICE_HEARD_GET_DETAILS_ENDPOINT']!;

  // Other
  static String get requestService => dotenv.env['REQUEST_SERVICE_ENDPOINT']!;
  static String get allTechnicalRequest =>
      dotenv.env['ALL_TECHNICAL_REQUEST_ENDPOINT']!;
  static String get favouriteList => dotenv.env['FEATURES_ENDPOINT']!;
  static String get allFavourites => dotenv.env['FAVORITES_ENDPOINT']!;
  static String get pointsMap => dotenv.env['POINTS_MAP_ENDPOINT']!;
  static String get note => dotenv.env['NOTES_ENDPOINT']!;
  static String get servicesApp => dotenv.env['SERVICES_APP_ENDPOINT']!;
  static String get servicesTypes => dotenv.env['SERVICES_TYPES_ENDPOINT']!;
  static String get servicesLocations =>
      dotenv.env['SERVICES_LOCATIONS_ENDPOINT']!;
  static String get checkIsServiceAvailable =>
      dotenv.env['SERVICE_AVAILABILITY_ENDPOINT']!;
}
