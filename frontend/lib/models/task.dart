import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:fucking_do_it/models/comment.dart';
import 'package:fucking_do_it/models/person.dart';
import 'package:fucking_do_it/types/priority.dart';
import 'package:fucking_do_it/types/status.dart';
import 'package:fucking_do_it/utils/constants.dart';
import 'package:fucking_do_it/utils/formatter.dart';
import 'package:fucking_do_it/utils/palette.dart';

class Task implements Comparable<Task> {
  final String id;
  final String createdBy;
  final DateTime createdAt;
  final Status status;
  final Priority? priority;
  final String title;
  final List<String> assignedTo;
  final Map<String, dynamic> assignedInfo;
  final String description;
  final DateTime? deadline;
  final List<String> tags;
  final List<Map<String, dynamic>> comments;

  static const String FIELD_CREATED_BY = 'createdBy';
  static const String FIELD_CREATED_AT = 'createdAt';
  static const String FIELD_STATUS = 'status';
  static const String FIELD_PRIORITY = 'priority';
  static const String FIELD_TITLE = 'title';
  static const String FIELD_ASSIGNED_TO = 'assignedTo';
  static const String FIELD_ASSIGNED_INFO = 'assignedInfo';
  static const String FIELD_DESCRIPTION = 'description';
  static const String FIELD_DEADLINE = 'deadline';
  static const String FIELD_TAGS = 'tags';
  static const String FIELD_COMMENTS = 'comments';

  Task({
    required this.id,
    required this.createdBy,
    required this.createdAt,
    required this.status,
    required this.priority,
    required this.title,
    required this.assignedTo,
    required this.assignedInfo,
    required this.description,
    required this.deadline,
    required this.tags,
    required this.comments,
  });

  String url([String? taskId]) =>
      '${Constants.BASE_URL}?taskId=${taskId ?? id}';

  bool get canComment =>
      (status != Status.created) &&
      (assignedTo.contains(FirebaseAuth.instance.currentUser?.uid) ||
          (createdBy == FirebaseAuth.instance.currentUser?.uid));

  bool get canBeAccepted =>
      ((status == Status.created) || (status == Status.accepted)) &&
      (!assignedTo.contains(FirebaseAuth.instance.currentUser?.uid)) &&
      (createdBy != FirebaseAuth.instance.currentUser?.uid);

  bool get canBeCompleted =>
      (status == Status.accepted) &&
      (assignedTo.contains(FirebaseAuth.instance.currentUser?.uid));

  bool get canBeQuit =>
      assignedTo.contains(FirebaseAuth.instance.currentUser?.uid);

  bool get canBeReopened =>
      (status == Status.done) &&
      (createdBy == FirebaseAuth.instance.currentUser?.uid);

  bool get canBeCopied =>
      ((status == Status.created) || (status == Status.accepted)) &&
      (createdBy == FirebaseAuth.instance.currentUser?.uid);

  bool get canBeEdited => createdBy == FirebaseAuth.instance.currentUser?.uid;

  bool get canBeDeleted => createdBy == FirebaseAuth.instance.currentUser?.uid;

  String get deadlineText =>
      '${Formatter.dayLongMonthMonthYear(deadline!)} (${Formatter.deltaDate(deadline!)})';

  Color get deadlineTextColor {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final Duration difference = deadline!.difference(today);

    if (difference.inDays > 0) {
      return Palette.secondaryText;
    } else {
      return Palette.error;
    }
  }

  Person person(String id) => Person.fromMap(assignedInfo[id]);

  List<Comment> get commentsList {
    final List<Comment> result = comments.map(Comment.fromMap).toList();
    result.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return result;
  }

  factory Task.fromDocument(DocumentSnapshot<Map<String, dynamic>> document) {
    final map = document.data() ?? {};

    return Task(
      id: document.id,
      createdBy: map[FIELD_CREATED_BY],
      createdAt: (map[FIELD_CREATED_AT] as Timestamp).toDate(),
      status: Status.parse(map[FIELD_STATUS]),
      priority: (map[FIELD_PRIORITY] != null)
          ? Priority.parse(map[FIELD_PRIORITY])
          : null,
      title: map[FIELD_TITLE],
      assignedTo: (map[FIELD_ASSIGNED_TO] as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
      assignedInfo: map[FIELD_ASSIGNED_INFO] as Map<String, dynamic>,
      description: map[FIELD_DESCRIPTION],
      deadline: (map[FIELD_DEADLINE] != null)
          ? (map[FIELD_DEADLINE] as Timestamp).toDate()
          : null,
      tags:
          (map[FIELD_TAGS] as List<dynamic>).map((e) => e.toString()).toList(),
      comments: (map[FIELD_COMMENTS] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );
  }

  Map<String, dynamic> get document => <String, dynamic>{
        FIELD_CREATED_BY: createdBy,
        FIELD_CREATED_AT: Timestamp.fromDate(createdAt),
        FIELD_STATUS: status.name,
        FIELD_PRIORITY: priority?.name,
        FIELD_TITLE: title,
        FIELD_ASSIGNED_TO: assignedTo,
        FIELD_ASSIGNED_INFO: assignedInfo,
        FIELD_DESCRIPTION: description,
        FIELD_DEADLINE:
            (deadline != null) ? Timestamp.fromDate(deadline!) : null,
        FIELD_TAGS: tags,
        FIELD_COMMENTS: comments,
      };

  @override
  int compareTo(Task other) {
    final DateTime thisDate =
        deadline ?? DateTime.now().add(const Duration(days: 365));
    final DateTime otherDate =
        other.deadline ?? DateTime.now().add(const Duration(days: 365));

    return thisDate.compareTo(otherDate);
  }
}
