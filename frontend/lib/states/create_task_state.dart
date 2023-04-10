import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dafluta/dafluta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fucking_do_it/models/task.dart';
import 'package:fucking_do_it/types/priority.dart';
import 'package:fucking_do_it/types/status.dart';
import 'package:fucking_do_it/utils/clipboard.dart';
import 'package:fucking_do_it/utils/formatter.dart';
import 'package:fucking_do_it/utils/navigation.dart';
import 'package:fucking_do_it/utils/repository.dart';

class CreateTaskState extends BaseState {
  Task? originalTask;
  Priority? priority;
  DateTime? deadline;
  final List<String> tags = [];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController deadlineController = TextEditingController();
  final TextEditingController tagsController = TextEditingController();
  final FocusNode deadlineFocus = FocusNode();
  final FocusNode tagsFocus = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  CreateTaskState(this.originalTask);

  bool get canSubmit => titleController.text.trim().isNotEmpty;

  bool get isCreate => originalTask == null;

  @override
  void onLoad() {
    if (!isCreate) {
      titleController.text = originalTask!.title;
      descriptionController.text = originalTask!.description;
      priority = originalTask!.priority;
      deadline = originalTask!.deadline;
      tags.addAll(originalTask!.tags);
      _updateDeadlineInput();
      notify();
    }
  }

  void onTitleChanged() {
    notify();
  }

  void onSetPriority(Priority newPriority) {
    if (newPriority != priority) {
      priority = newPriority;
    } else {
      priority = null;
    }

    notify();
  }

  Future onSelectDeadline(BuildContext context) async {
    final DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    deadline = dateTime;
    deadlineFocus.nextFocus();
    _updateDeadlineInput();
  }

  void _updateDeadlineInput() {
    if (deadline != null) {
      deadlineController.text = Formatter.dayLongMonthMonthYear(deadline!);
    } else {
      deadlineController.text = '';
    }

    notify();
  }

  Future onSubmit() async {
    if (formKey.currentState!.validate()) {
      if (isCreate) {
        _createTask();
      } else {
        _updateTask();
      }
    }
  }

  Future _createTask() async {
    final Task task = Task(
      id: '',
      createdBy: FirebaseAuth.instance.currentUser?.uid ?? '',
      createdAt: DateTime.now(),
      status: Status.created,
      priority: priority,
      title: titleController.text.trim(),
      assignedTo: [],
      assignedInfo: {},
      description: descriptionController.text.trim(),
      deadline: deadline,
      tags: tags,
      comments: [],
    );

    Navigation.pop();
    final DocumentReference ref = await Repository.create(task);
    Clipboard.copy(task.url(ref.id));
  }

  Future _updateTask() async {
    final Task task = Task(
      id: originalTask!.id,
      createdBy: originalTask!.createdBy,
      createdAt: originalTask!.createdAt,
      status: originalTask!.status,
      priority: priority,
      title: titleController.text.trim(),
      assignedTo: originalTask!.assignedTo,
      assignedInfo: originalTask!.assignedInfo,
      description: descriptionController.text.trim(),
      deadline: deadline,
      tags: tags,
      comments: originalTask!.comments,
    );

    Navigation.pop();
    await Repository.update(task);
  }

  void onCreateTag(String tag) {
    if (tag.isNotEmpty && !tags.contains(tag)) {
      tags.add(tag);
      notify();
    }

    tagsController.text = '';
    Delayed.post(tagsFocus.requestFocus);
  }

  void onDeleteTag(String tag) {
    if (tags.contains(tag)) {
      tags.remove(tag);
      notify();
    }

    tagsController.text = '';
    Delayed.post(tagsFocus.requestFocus);
  }
}
