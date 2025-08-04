class InspectorModel{
   int? statusCode;
   String? startTime;
   String? contentType;
   String? authorization;
   String? endTime;
   String? error;
   String? method;
   DateTime? startTimeDate;
   String? callingTime;
   Uri? uri;
   String? path;
   String? baseUrl;
   dynamic data;
   dynamic responseBody;
   Map<String, dynamic>? queryParameters;
   Map<String, dynamic>? extra;

  InspectorModel({this.uri, this.path,this.callingTime ,this.baseUrl, this.data,
    this.queryParameters, this.extra,this.statusCode,this.method,this.endTime,
     this.error,this.responseBody,this.authorization,this.contentType,this.startTimeDate,
     this.startTime,});

}