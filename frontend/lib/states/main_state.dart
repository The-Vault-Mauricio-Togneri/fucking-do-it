import 'dart:async';
import 'package:dafluta/dafluta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fucking_do_it/dialogs/confirmation_dialog.dart';
import 'package:fucking_do_it/dialogs/create_task_dialog.dart';
import 'package:fucking_do_it/dialogs/options_dialog.dart';
import 'package:fucking_do_it/models/task.dart';
import 'package:fucking_do_it/utils/navigation.dart';
import 'package:fucking_do_it/utils/repository.dart';

class MainState extends BaseState {
  List<Task>? _tasksAssignedToMe;
  StreamSubscription? subscriptionAssignedToMe;

  List<Task> get tasks => _tasksAssignedToMe ?? [];

  bool get hasTasks => _tasksAssignedToMe != null;

  @override
  void onLoad() => subscriptionAssignedToMe ??= Repository.listenAssignedToMe(onTasksAssignedToMe);

  @override
  void onDestroy() {
    subscriptionAssignedToMe?.cancel();
  }

  Future onTasksAssignedToMe(List<Task> tasks) async {
    _tasksAssignedToMe = tasks;
    _tasksAssignedToMe!.sort((a, b) => a.compareTo(b));
    notify();
  }

  void onTaskSelected(Task task) {
    onOptionsSelected(task);
  }

  void onOptionsSelected(Task task) {
    OptionsDialog.show(options: [
      Option(
        text: 'Option 1',
        callback: () => onTaskSelected(task),
      ),
      /*Option(
        text: Localized.get.optionUpdate,
        callback: () => onUpdateTask(task),
      ),*/
      Option(
        text: 'Option 2',
        callback: () => ConfirmationDialog.show(
          message: 'Really?',
          callback: () => onTaskDeleted(task),
        ),
      ),
    ]);
  }

  void onTaskDeleted(Task task) {
    _tasksAssignedToMe!.remove(task);
    notify();
    Repository.delete(task);
  }

  void onCreateTask(BuildContext context) => CreateTaskDialog.show(context);

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigation.authScreen();
  }
}
