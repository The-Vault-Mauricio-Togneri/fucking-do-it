import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String avatar;
  final String name;
  final String content;
  final DateTime createdAt;

  static const String FIELD_AVATAR = 'avatar';
  static const String FIELD_NAME = 'name';
  static const String FIELD_CONTENT = 'content';
  static const String FIELD_CREATED_AT = 'createdAt';

  const Comment({
    required this.avatar,
    required this.name,
    required this.content,
    required this.createdAt,
  });

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      avatar: map[FIELD_AVATAR],
      name: map[FIELD_NAME],
      content: map[FIELD_CONTENT],
      createdAt: (map[FIELD_CREATED_AT] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> get document => <String, dynamic>{
        FIELD_AVATAR: avatar,
        FIELD_NAME: name,
        FIELD_CONTENT: content,
        FIELD_CREATED_AT: Timestamp.fromDate(createdAt),
      };
}
