// class CalendarEventsResponseModel {
//   List<Model>? model;
//
//   CalendarEventsResponseModel({this.model});
//
//   CalendarEventsResponseModel fromMap(dynamic json) {
//     if (json != null) {
//       model = <Model>[];
//       json.forEach((v) {
//         model!.add( Model().fromMap(v));
//       });
//     }
//     return CalendarEventsResponseModel(model:model);
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (model != null) {
//       data['model'] = this.model!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Model {
//   String? title;
//   String? description;
//   String? date;
//   int? eventType;
//   String? attachmentUrl;
//
//   Model(
//       {this.title,
//         this.description,
//         this.date,
//         this.eventType,
//         this.attachmentUrl});
//
//   Model fromMap(Map<String, dynamic> json) {
//     title = json['title'];
//     description = json['description'];
//     date = json['date'];
//     eventType = json['eventType'];
//     attachmentUrl = json['attachmentUrl'];
//     return Model(attachmentUrl:attachmentUrl,date:date,description:description,eventType:eventType,
//     title:title);
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['title'] = this.title;
//     data['description'] = this.description;
//     data['date'] = this.date;
//     data['eventType'] = this.eventType;
//     data['attachmentUrl'] = this.attachmentUrl;
//     return data;
//   }
// }