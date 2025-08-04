enum ExceptionEnum {
  generalException("GENERAL_EXCEPTION"),

  /// NETWORK EXCEPTIONS
  unAuthorized("UN_AUTHORIZED"),
  refreshTokenExpired("Refresh_Token_Expired"),
  serverError("SERVER_ERROR"),
  connectionErrorException("CONNECTION_ERROR_EXCEPTION"),
  connectionTimeOutException("CONNECTION_TIME_OUT_EXCEPTION"),
  sendTimeoutException("SEND_TIME_OUT_EXCEPTION"),
  receiveTimeoutException("RECEIVE_TIME_OUT_EXCEPTION"),
  cancelException("CANCEL_EXCEPTION"),
  badResponseException("BAD_RESPONSE_EXCEPTION"),
  badCertificateResponseException("BAD_CERTIFICATE_EXCEPTION"),
  unknownException("UNKNOWN_EXCEPTION"),
  formatException("FORMAT_EXCEPTION"),
  docTypeHtmlException("DOC_TYPE_HTML"),
  badRequest("Bad_Request"),
  blockedUser("Blocked_User"),
  pageNotFound("Page_Bot_Found"),

  // /// BACKEND EXCEPTIONS
  // LO_IUP_1002("LO_IUP_1002"), // This National Id has voted
  // FE_DNE_1002("FE_DNE_1002"), // File Not Found
  // FE_FD_1001("FE_FD_1001"), // File Deletion Failed
  // T_DNE_1001("T_DNE_1001"), // File Deletion Failed
  // T_DNA_1002("T_DNA_1002"), // File Deletion Failed
  // RT_INV_1005("RT_INV_1005")
  ; // File Deletion Failed

  final String value;

  const ExceptionEnum(this.value);

  factory ExceptionEnum.fromValue(String value) {
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => ExceptionEnum.generalException,
    );
  }
}
