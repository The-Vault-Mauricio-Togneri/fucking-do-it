import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:fucking_do_it/types/priority.dart';
import 'package:fucking_do_it/types/status.dart';
import 'package:fucking_do_it/utils/formatter.dart';
import 'package:fucking_do_it/utils/localizations.dart';
import 'package:fucking_do_it/utils/palette.dart';

class Task implements Comparable<Task> {
  final String id;
  final String createdBy;
  final DateTime createdAt;
  final Status status;
  final Priority priority;
  final String title;
  final List<String> assignedTo;
  final Map<String, dynamic> assignedInfo;
  final String description;
  final DateTime? deadline;

  static const String FIELD_CREATED_BY = 'createdBy';
  static const String FIELD_CREATED_AT = 'createdAt';
  static const String FIELD_STATUS = 'status';
  static const String FIELD_PRIORITY = 'priority';
  static const String FIELD_TITLE = 'title';
  static const String FIELD_ASSIGNED_TO = 'assignedTo';
  static const String FIELD_ASSIGNED_INFO = 'assignedInfo';
  static const String FIELD_DESCRIPTION = 'description';
  static const String FIELD_DEADLINE = 'deadline';

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
  });

  bool get canBeAccepted =>
      ((status == Status.created) || (status == Status.accepted)) &&
      (!assignedTo.contains(FirebaseAuth.instance.currentUser?.uid)) &&
      (createdBy != FirebaseAuth.instance.currentUser?.uid);

  bool get canBeCompleted =>
      (status == Status.accepted) &&
      (assignedTo.contains(FirebaseAuth.instance.currentUser?.uid));

  bool get canBeReopened =>
      (status == Status.done) &&
      (createdBy == FirebaseAuth.instance.currentUser?.uid);

  bool get canBeCopied =>
      ((status == Status.created) || (status == Status.accepted)) &&
      (createdBy == FirebaseAuth.instance.currentUser?.uid);

  bool get canBeDeleted =>
      ((status == Status.created) || (status == Status.done)) &&
      (createdBy == FirebaseAuth.instance.currentUser?.uid);

  String get deadlineText {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final String date = Formatter.dayLongMonthMonthYear(deadline!);
    final Duration difference = deadline!.difference(today);
    String delta = '';

    if (difference.inDays > 0) {
      delta = Localized.get.labelDeltaDaysFuture(difference.inDays.toString());
    } else if (difference.inDays == 0) {
      delta = Localized.get.labelDeltaToday.toLowerCase();
    } else {
      delta =
          Localized.get.labelDeltaDaysPast(difference.inDays.abs().toString());
    }

    return '$date ($delta)';
  }

  Color get deadlineTextColor {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final Duration difference = deadline!.difference(today);

    if (difference.inDays > 0) {
      return Palette.grey;
    } else {
      return Palette.red;
    }
  }

  factory Task.fromDocument(DocumentSnapshot<Map<String, dynamic>> document) {
    final map = document.data() ?? {};

    return Task(
      id: document.id,
      createdBy: map[FIELD_CREATED_BY],
      createdAt: (map[FIELD_CREATED_AT] as Timestamp).toDate(),
      status: Status.parse(map[FIELD_STATUS]),
      priority: Priority.parse(map[FIELD_PRIORITY]),
      title: map[FIELD_TITLE],
      assignedTo: (map[FIELD_ASSIGNED_TO] as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
      assignedInfo: map[FIELD_ASSIGNED_INFO] as Map<String, dynamic>,
      description: map[FIELD_DESCRIPTION],
      deadline: (map[FIELD_DEADLINE] != null)
          ? (map[FIELD_DEADLINE] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> get document => <String, dynamic>{
        FIELD_CREATED_BY: createdBy,
        FIELD_CREATED_AT: Timestamp.fromDate(createdAt),
        FIELD_STATUS: status.name,
        FIELD_PRIORITY: priority.name,
        FIELD_TITLE: title,
        FIELD_ASSIGNED_TO: assignedTo,
        FIELD_ASSIGNED_INFO: assignedInfo,
        FIELD_DESCRIPTION: description,
        FIELD_DEADLINE:
            (deadline != null) ? Timestamp.fromDate(deadline!) : null,
      };

  @override
  int compareTo(Task other) => createdAt.compareTo(other.createdAt);
}
