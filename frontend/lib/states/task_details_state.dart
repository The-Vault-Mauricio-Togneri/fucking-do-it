import 'dart:html';
import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:fucking_do_it/dialogs/confirmation_dialog.dart';
import 'package:fucking_do_it/dialogs/create_task_dialog.dart';
import 'package:fucking_do_it/models/task.dart';
import 'package:fucking_do_it/utils/constants.dart';
import 'package:fucking_do_it/utils/localizations.dart';
import 'package:fucking_do_it/utils/navigation.dart';
import 'package:fucking_do_it/utils/repository.dart';

class TaskDetailsState extends BaseState {
  final Task task;
  final TextEditingController commentController = TextEditingController();
  final FocusNode commentFocus = FocusNode();

  TaskDetailsState(this.task);

  void onAccept() {
    Repository.accept(task);
    Navigation.pop();
  }

  void onCopyLink() {
    try {
      final textarea = TextAreaElement();
      document.body!.append(textarea);
      textarea.style.border = '0';
      textarea.style.margin = '0';
      textarea.style.padding = '0';
      textarea.style.opacity = '0';
      textarea.style.position = 'absolute';
      textarea.readOnly = true;
      textarea.value = '${Constants.BASE_URL}?taskId=${task.id}';
      textarea.select();
      document.execCommand('copy');
      textarea.remove();
    } catch (e) {
      // ignore
    }
    Navigation.pop();
  }

  void onReopen() {
    Repository.reopen(task);
    Navigation.pop();
  }

  void onComplete() {
    Repository.complete(task);
    Navigation.pop();
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
    Repository.delete(task);
    Navigation.pop();
  }

  void onSubmitComment(String text) {}
}
