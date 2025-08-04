import 'dart:convert';

class OnboardModel {
  final String title;
  final String body;
  final String imagePath;
  OnboardModel({
    required this.title,
    required this.body,
    required this.imagePath,
  });

  OnboardModel copyWith({
    String? title,
    String? body,
    String? imagePath,
  }) {
    return OnboardModel(
      title: title ?? this.title,
      body: body ?? this.body,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'body': body,
      'imagePath': imagePath,
    };
  }

  factory OnboardModel.fromMap(Map<String, dynamic> map) {
    return OnboardModel(
      title: map['title'] as String,
      body: map['body'] as String,
      imagePath: map['imagePath'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OnboardModel.fromJson(String source) =>
      OnboardModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'OnboardModel(title: $title, body: $body, imagePath: $imagePath)';

  @override
  bool operator ==(covariant OnboardModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.body == body &&
        other.imagePath == imagePath;
  }

  @override
  int get hashCode => title.hashCode ^ body.hashCode ^ imagePath.hashCode;
}
