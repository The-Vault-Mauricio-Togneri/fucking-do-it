import 'package:dafluta/dafluta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fucking_do_it/models/task.dart';
import 'package:fucking_do_it/types/priority.dart';
import 'package:fucking_do_it/types/status.dart';
import 'package:fucking_do_it/utils/navigation.dart';
import 'package:fucking_do_it/utils/repository.dart';

class TaskState extends BaseState {
  Priority priority = Priority.high;
  final TextEditingController titleController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void onSetPriority(Priority newPriority) {
    priority = newPriority;
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
        priority: priority,
        title: titleController.text.trim(),
        assignedTo: [],
        description: 'Description',
        dueDate: DateTime.now().add(const Duration(days: 7)),
      );

      await Repository.add(task);
      Navigation.pop();
    }
  }
}
