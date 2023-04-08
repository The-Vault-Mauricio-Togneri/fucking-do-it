import 'package:dafluta/dafluta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fucking_do_it/models/task.dart';
import 'package:fucking_do_it/types/priority.dart';
import 'package:fucking_do_it/types/status.dart';
import 'package:fucking_do_it/utils/formatter.dart';
import 'package:fucking_do_it/utils/navigation.dart';
import 'package:fucking_do_it/utils/repository.dart';

class CreateTaskState extends BaseState {
  Priority? priority;
  DateTime? deadline;
  final List<String> tags = [];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController deadlineController = TextEditingController();
  final TextEditingController tagsController = TextEditingController();
  final FocusNode tagsFocus = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool get canSubmit =>
      (priority != null) && titleController.text.trim().isNotEmpty;

  void onTitleChanged() {
    notify();
  }

  void onSetPriority(Priority newPriority) {
    priority = newPriority;
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

    if (dateTime != null) {
      deadlineController.text = Formatter.dayLongMonthMonthYear(dateTime);
    } else {
      deadlineController.text = '';
    }

    notify();
  }

  Future onSubmit() async {
    if (formKey.currentState!.validate()) {
      Keyboard.hide(Navigation.context());

      final Task task = Task(
        id: '',
        createdBy: FirebaseAuth.instance.currentUser?.uid ?? '',
        createdAt: DateTime.now(),
        status: Status.created,
        priority: priority!,
        title: titleController.text.trim(),
        assignedTo: [],
        assignedInfo: {},
        description: descriptionController.text.trim(),
        deadline: deadline,
      );

      await Repository.create(task);
      Navigation.pop();
    }
  }

  void onCreateTag(String tag) {
    if (!tags.contains(tag)) {
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
