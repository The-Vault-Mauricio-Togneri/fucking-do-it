import 'dart:html';
import 'package:dafluta/dafluta.dart';
import 'package:fucking_do_it/models/task.dart';
import 'package:fucking_do_it/utils/navigation.dart';
import 'package:fucking_do_it/utils/repository.dart';

class TaskDetailsState extends BaseState {
  final Task task;

  TaskDetailsState(this.task);

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
      textarea.value = 'https://fucking-do-it.web.app?taskId=${task.id}';
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

  void onDelete() {
    Repository.delete(task);
    Navigation.pop();
  }
}
