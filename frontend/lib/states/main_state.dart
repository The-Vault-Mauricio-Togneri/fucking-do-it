import 'dart:async';
import 'package:dafluta/dafluta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fucking_do_it/app/initializer.dart';
import 'package:fucking_do_it/dialogs/create_task_dialog.dart';
import 'package:fucking_do_it/dialogs/task_details_dialog.dart';
import 'package:fucking_do_it/models/task.dart';
import 'package:fucking_do_it/utils/localizations.dart';
import 'package:fucking_do_it/utils/navigation.dart';
import 'package:fucking_do_it/utils/repository.dart';

class MainState extends BaseState {
  List<Task>? tasksAssignedToMe;
  List<Task>? tasksCreated;
  List<Task>? tasksInProgress;
  List<Task>? tasksInReview;
  StreamSubscription? subscriptionAssignedToMe;
  StreamSubscription? subscriptionCreated;
  StreamSubscription? subscriptionInProgress;
  StreamSubscription? subscriptionInReview;

  String get title {
    final int assignedToMe = tasksAssignedToMe?.length ?? 0;

    return (assignedToMe > 0) ? '($assignedToMe) ${Localized.get.appName}' : Localized.get.appName;
  }

  @override
  void onLoad() {
    checkAcceptTask();
    subscriptionAssignedToMe ??= Repository.listenAssignedToMe(onTasksAssignedToMe);
    subscriptionCreated ??= Repository.listenCreated(onTasksCreated);
    subscriptionInProgress ??= Repository.listenInProgress(onTasksInProgress);
    subscriptionInReview ??= Repository.listenInReview(onTasksInReview);
  }

  Future checkAcceptTask() async {
    if (paramTaskId != null) {
      final Task task = await Repository.get(paramTaskId!);
      paramTaskId = null;

      if (task.canBeAccepted) {
        TaskDetailsDialog.show(
          context: Navigation.context(),
          task: task,
        );
      }
    }
  }

  @override
  void onDestroy() {
    subscriptionAssignedToMe?.cancel();
    subscriptionCreated?.cancel();
    subscriptionInProgress?.cancel();
    subscriptionInReview?.cancel();
  }

  Future onTasksAssignedToMe(List<Task> tasks) async {
    tasksAssignedToMe = tasks;
    tasksAssignedToMe!.sort((a, b) => a.compareTo(b));
    notify();
  }

  Future onTasksCreated(List<Task> tasks) async {
    tasksCreated = tasks;
    tasksCreated!.sort((a, b) => a.compareTo(b));
    notify();
  }

  Future onTasksInProgress(List<Task> tasks) async {
    tasksInProgress = tasks;
    tasksInProgress!.sort((a, b) => a.compareTo(b));
    notify();
  }

  Future onTasksInReview(List<Task> tasks) async {
    tasksInReview = tasks;
    tasksInReview!.sort((a, b) => a.compareTo(b));
    notify();
  }

  void onTaskSelected(BuildContext context, Task task) => TaskDetailsDialog.show(
        context: context,
        task: task,
      );

  void onTaskDeleted(Task task) {
    tasksAssignedToMe!.remove(task);
    notify();
    Repository.delete(task);
  }

  void onCreateTask(BuildContext context) => CreateTaskDialog.show(context);

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigation.authScreen();
  }
}
