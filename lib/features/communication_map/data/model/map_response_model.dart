
class MapResponseModel {
  List<MapData>? model;

  MapResponseModel({this.model});

  MapResponseModel fromMap(Map<String, dynamic> json) {
    if (json['model'] != null) {
      model = <MapData>[];
      json['model'].forEach((v) {
        model!.add( MapData.fromMap(v));
      });
    }
    return MapResponseModel(model:model);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (model != null) {
      data['model'] = model!.map((v) => v.toMap()).toList();
    }
    return data;
  }
}

class MapData {
  String? id;
  String? title;
  String? text;
  String? attachmentUrl;
  String? link;
  dynamic latitude;
  dynamic longitude;

  MapData(
      {this.id,
        this.title,
        this.text,
        this.attachmentUrl,
        this.link,
        this.latitude,
        this.longitude});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['text'] = text;
    data['attachmentUrl'] = attachmentUrl;
    data['link'] = link;
    data['latitude'] = double.parse(latitude.toString());
    data['longitude'] = double.parse(longitude.toString());
    return data;
  }

  factory MapData.fromMap(Map<String, dynamic> map) {
    return MapData(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      text: map['text'] != null ? map['text'] as String : null,
      attachmentUrl: map['attachmentUrl'] != null ? map['attachmentUrl'] as String : null,
      link: map['link'] != null ? map['link'] as String : null,
      latitude: double.parse((map['latitude'] != null ? map['latitude'] as dynamic : '0').toString()),
      longitude: double.parse((map['longitude'] != null ? map['longitude'] as dynamic : '0').toString()),
    );
  }
}