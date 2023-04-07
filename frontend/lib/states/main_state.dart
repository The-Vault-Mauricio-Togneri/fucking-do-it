import 'dart:async';
import 'package:dafluta/dafluta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fucking_do_it/dialogs/confirmation_dialog.dart';
import 'package:fucking_do_it/dialogs/create_task_dialog.dart';
import 'package:fucking_do_it/dialogs/options_dialog.dart';
import 'package:fucking_do_it/models/task.dart';
import 'package:fucking_do_it/utils/localizations.dart';
import 'package:fucking_do_it/utils/navigation.dart';
import 'package:fucking_do_it/utils/repository.dart';

class MainState extends BaseState {
  List<Task>? _tasks;
  StreamSubscription? subscription;

  List<Task> get tasks => _tasks!;

  bool get hasTasks => _tasks != null;

  @override
  void onLoad() => subscription ??= Repository.listen(onTasksLoaded);

  @override
  void onDestroy() {
    subscription?.cancel();
    subscription = null;
  }

  Future onTasksLoaded(List<Task> tasks) async {
    _tasks = tasks;
    _tasks!.sort((a, b) => a.compareTo(b));
    notify();
  }

  void onTaskSelected(Task task) {
    onOptionsSelected(task);
  }

  void onOptionsSelected(Task task) {
    OptionsDialog.show(options: [
      Option(
        text: Localized.get.optionDone,
        callback: () => onTaskSelected(task),
      ),
      /*Option(
        text: Localized.get.optionUpdate,
        callback: () => onUpdateTask(task),
      ),*/
      Option(
        text: Localized.get.optionDelete,
        callback: () => ConfirmationDialog.show(
          message: Localized.get.confirmationDeleteTask,
          callback: () => onTaskDeleted(task),
        ),
      ),
    ]);
  }

  void onTaskDeleted(Task task) {
    _tasks!.remove(task);
    notify();
    Repository.delete(task);
  }

  void onCreateTask(BuildContext context) => CreateTaskDialog.show(context);

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigation.authScreen();
  }
}
