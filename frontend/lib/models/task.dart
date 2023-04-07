import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fucking_do_it/types/priority.dart';
import 'package:fucking_do_it/types/status.dart';
import 'package:fucking_do_it/utils/formatter.dart';

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
  final DateTime? dueDate;

  static const String FIELD_CREATED_BY = 'createdBy';
  static const String FIELD_CREATED_AT = 'createdAt';
  static const String FIELD_STATUS = 'status';
  static const String FIELD_PRIORITY = 'priority';
  static const String FIELD_TITLE = 'title';
  static const String FIELD_ASSIGNED_TO = 'assignedTo';
  static const String FIELD_ASSIGNED_INFO = 'assignedInfo';
  static const String FIELD_DESCRIPTION = 'description';
  static const String FIELD_DUE_DATE = 'dueDate';

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
    required this.dueDate,
  });

  bool get canBeCompleted => (status == Status.accepted) && (assignedTo.contains(FirebaseAuth.instance.currentUser?.uid));

  bool get canBeReopened => (status == Status.done) && (createdBy == FirebaseAuth.instance.currentUser?.uid);

  bool get canBeCopied => ((status == Status.created) || (status == Status.accepted)) && (createdBy == FirebaseAuth.instance.currentUser?.uid);

  bool get canBeDeleted => ((status == Status.created) || (status == Status.done)) && (createdBy == FirebaseAuth.instance.currentUser?.uid);

  String get createdAtDateTime => Formatter.fullDateTime(createdAt);

  factory Task.fromDocument(DocumentSnapshot<Map<String, dynamic>> document) {
    final map = document.data() ?? {};

    return Task(
      id: document.id,
      createdBy: map[FIELD_CREATED_BY],
      createdAt: (map[FIELD_CREATED_AT] as Timestamp).toDate(),
      status: Status.parse(map[FIELD_STATUS]),
      priority: Priority.parse(map[FIELD_PRIORITY]),
      title: map[FIELD_TITLE],
      assignedTo: (map[FIELD_ASSIGNED_TO] as List<dynamic>).map((e) => e.toString()).toList(),
      assignedInfo: map[FIELD_ASSIGNED_INFO] as Map<String, dynamic>,
      description: map[FIELD_DESCRIPTION],
      dueDate: (map[FIELD_DUE_DATE] != null) ? (map[FIELD_DUE_DATE] as Timestamp).toDate() : null,
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
        FIELD_DUE_DATE: (dueDate != null) ? Timestamp.fromDate(dueDate!) : null,
      };

  @override
  int compareTo(Task other) => createdAt.compareTo(other.createdAt);
}
