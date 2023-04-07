import 'package:dafluta/dafluta.dart';
import 'package:fucking_do_it/models/task.dart';
import 'package:fucking_do_it/utils/navigation.dart';
import 'package:fucking_do_it/utils/repository.dart';

class TaskDetailsState extends BaseState {
  final Task task;

  TaskDetailsState(this.task);

  void onComplete() {
    Repository.complete(task);
    Navigation.pop();
  }

  void onReopen() {
    Repository.reopen(task);
    Navigation.pop();
  }

  void onDelete() {
    Repository.delete(task);
    Navigation.pop();
  }
}
