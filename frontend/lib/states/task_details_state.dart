import 'dart:async';
import 'package:dafluta/dafluta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fucking_do_it/dialogs/confirmation_dialog.dart';
import 'package:fucking_do_it/dialogs/create_task_dialog.dart';
import 'package:fucking_do_it/models/comment.dart';
import 'package:fucking_do_it/models/task.dart';
import 'package:fucking_do_it/utils/clipboard.dart';
import 'package:fucking_do_it/utils/localizations.dart';
import 'package:fucking_do_it/utils/navigation.dart';
import 'package:fucking_do_it/utils/repository.dart';

class TaskDetailsState extends BaseState {
  Task task;
  final TextEditingController commentController = TextEditingController();
  final FocusNode commentFocus = FocusNode();
  StreamSubscription? subscription;

  TaskDetailsState(this.task);

  @override
  void onLoad() {
    subscription ??= Repository.listen(task.id, onTaskChanged);
  }

  @override
  void onDestroy() {
    subscription?.cancel();
  }

  Future onTaskChanged(Task? newTask) async {
    if (newTask != null) {
      task = newTask;
      notify();
    } else {
      Navigation.pop();
    }
  }

  void onAccept() {
    Navigation.pop();
    Repository.accept(task);
  }

  void onCopyLink() {
    Navigation.pop();
    Clipboard.copy(task.url());
  }

  void onReopen() {
    Navigation.pop();
    Repository.reopen(task);
  }

  void onComplete() {
    Navigation.pop();
    Repository.complete(task);
  }

  void onEdit(BuildContext context) {
    Navigation.pop();
    CreateTaskDialog.show(
      context: context,
      originalTask: task,
    );
  }

  void onDelete(BuildContext context) => ConfirmationDialog.show(
        context: context,
        message: Localized.get.confirmationDeleteTask,
        buttonCancel: Localized.get.buttonCancel,
        buttonOk: Localized.get.buttonDelete,
        onConfirm: deleteTask,
      );

  void deleteTask() {
    Navigation.pop();
    Repository.delete(task);
  }

  Future onSubmitComment(String content) async {
    if (content.trim().isNotEmpty) {
      final Comment comment = Comment(
        avatar: FirebaseAuth.instance.currentUser?.photoURL ?? '',
        name: FirebaseAuth.instance.currentUser?.displayName ?? '',
        content: content,
        createdAt: DateTime.now(),
      );

      await Repository.addComment(
        task: task,
        comment: comment,
      );
      notify();

      commentController.text = '';
    }

    Delayed.post(commentFocus.requestFocus);
  }
}
