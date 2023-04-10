import 'dart:async';
import 'package:dafluta/dafluta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fucking_do_it/app/initializer.dart';
import 'package:fucking_do_it/dialogs/create_task_dialog.dart';
import 'package:fucking_do_it/dialogs/task_details_dialog.dart';
import 'package:fucking_do_it/models/task.dart';
import 'package:fucking_do_it/utils/brightness_manager.dart';
import 'package:fucking_do_it/utils/localizations.dart';
import 'package:fucking_do_it/utils/navigation.dart';
import 'package:fucking_do_it/utils/repository.dart';

class MainState extends BaseState {
  List<Task>? tasksAssignedToMe;
  List<Task>? tasksCreated;
  List<Task>? tasksAccepted;
  List<Task>? tasksInReview;
  StreamSubscription? subscriptionAssignedToMe;
  StreamSubscription? subscriptionCreated;
  StreamSubscription? subscriptionAccepted;
  StreamSubscription? subscriptionInReview;

  String get title {
    final int assignedToMe = tasksAssignedToMe?.length ?? 0;

    return (assignedToMe > 0)
        ? '($assignedToMe) ${Localized.get.appName}'
        : Localized.get.appName;
  }

  @override
  void onLoad() {
    checkAcceptTask();
    subscriptionAssignedToMe ??=
        Repository.listenAssignedToMe(onTasksAssignedToMe);
    subscriptionCreated ??= Repository.listenCreated(onTasksCreated);
    subscriptionAccepted ??= Repository.listenAccepted(onTasksAccepted);
    subscriptionInReview ??= Repository.listenInReview(onTasksInReview);
  }

  @override
  void onDestroy() {
    subscriptionAssignedToMe?.cancel();
    subscriptionCreated?.cancel();
    subscriptionAccepted?.cancel();
    subscriptionInReview?.cancel();
  }

  Future checkAcceptTask() async {
    if (paramTaskId != null) {
      final Task task = await Repository.get(paramTaskId!);
      paramTaskId = null;

      TaskDetailsDialog.show(
        context: Navigation.context(),
        task: task,
      );
    }
  }

  Future onTasksAssignedToMe(List<Task> tasks) async {
    tasksAssignedToMe = tasks;
    notify();
  }

  Future onTasksCreated(List<Task> tasks) async {
    tasksCreated = tasks;
    notify();
  }

  Future onTasksAccepted(List<Task> tasks) async {
    tasksAccepted = tasks;
    notify();
  }

  Future onTasksInReview(List<Task> tasks) async {
    tasksInReview = tasks;
    notify();
  }

  void onTaskSelected(BuildContext context, Task task) =>
      TaskDetailsDialog.show(
        context: context,
        task: task,
      );

  void onTaskDeleted(Task task) {
    tasksAssignedToMe!.remove(task);
    notify();
    Repository.delete(task);
  }

  void onCreateTask(BuildContext context) =>
      CreateTaskDialog.show(context: context);

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigation.authScreen();
  }

  void onDarkMode() {
    BrightnessManager.darkMode();
    notify();
  }

  void onLightMode() {
    BrightnessManager.lightMode();
    notify();
  }
}
