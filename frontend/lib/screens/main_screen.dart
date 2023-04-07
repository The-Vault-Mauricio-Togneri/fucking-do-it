import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:fucking_do_it/models/task.dart';
import 'package:fucking_do_it/states/main_state.dart';
import 'package:fucking_do_it/utils/localizations.dart';
import 'package:fucking_do_it/utils/palette.dart';
import 'package:fucking_do_it/widgets/label.dart';
import 'package:link_text/link_text.dart';

class MainScreen extends StatelessWidget {
  final MainState state;

  const MainScreen._(this.state);

  factory MainScreen.instance() => MainScreen._(MainState());

  @override
  Widget build(BuildContext context) {
    return StateProvider<MainState>(
      state: state,
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Label(
            text: Localized.get.appName,
            color: Palette.white,
            size: 16,
          ),
          actions: [
            IconButton(
              onPressed: state.signOut,
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: Content(state),
        floatingActionButton: FloatingActionButton(
          onPressed: () => state.onCreateTask(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class Content extends StatelessWidget {
  final MainState state;

  const Content(this.state);

  @override
  Widget build(BuildContext context) {
    return StateProvider<MainState>(
      state: state,
      builder: (context, state) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TaskColumn(
            state: state,
            title: 'Assigned to me',
            tasks: state.tasksAssignedToMe,
          ),
          const VerticalDivider(),
          TaskColumn(
            state: state,
            title: 'Created',
            tasks: state.tasksCreated,
          ),
          const VerticalDivider(),
          TaskColumn(
            state: state,
            title: 'In progress',
            tasks: state.tasksInProgress,
          ),
          const VerticalDivider(),
          TaskColumn(
            state: state,
            title: 'In review',
            tasks: state.tasksInReview,
          ),
        ],
      ),
    );
  }
}

class VerticalDivider extends StatelessWidget {
  const VerticalDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      color: Palette.grey,
      width: 0.2,
      height: double.infinity,
    );
  }
}

class TaskColumn extends StatelessWidget {
  final MainState state;
  final String title;
  final List<Task>? tasks;

  const TaskColumn({
    required this.state,
    required this.title,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 50,
            color: Palette.primary,
            padding: const EdgeInsets.all(15),
            child: Center(
              child: Label(
                text: ((tasks != null) && (tasks!.isNotEmpty)) ? '${title.toUpperCase()} (${tasks!.length})' : title.toUpperCase(),
                color: Palette.white,
              ),
            ),
          ),
          if (tasks != null) TasksList(state, tasks!) else const LoadingTasks(),
        ],
      ),
    );
  }
}

class TasksList extends StatelessWidget {
  final MainState state;
  final List<Task> tasks;

  const TasksList(this.state, this.tasks);

  @override
  Widget build(BuildContext context) {
    return tasks.isNotEmpty
        ? Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (final Task task in tasks) TaskEntry(state: state, task: task),
                ],
              ),
            ),
          )
        : const Empty();
  }
}

class LoadingTasks extends StatelessWidget {
  const LoadingTasks();

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class NoTasks extends StatelessWidget {
  const NoTasks();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Label(
        text: 'No tasks',
        color: Palette.black,
      ),
    );
  }
}

class TaskEntry extends StatelessWidget {
  final MainState state;
  final Task task;

  const TaskEntry({
    required this.state,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
      ),
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Palette.lightGrey,
      ),
      child: Material(
        color: Palette.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          onTap: () => state.onTaskSelected(context, task),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Label(
                  text: task.title,
                  color: Palette.black,
                  weight: FontWeight.bold,
                  size: 14,
                ),
                if (task.description.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: LinkText(
                      task.description,
                      textStyle: const TextStyle(
                        color: Palette.grey,
                        fontSize: 12,
                      ),
                      linkStyle: const TextStyle(
                        color: Palette.primary,
                        fontSize: 12,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                const VBox(10),
                Label(
                  text: task.priority.text.toUpperCase(),
                  color: task.priority.color,
                  weight: FontWeight.bold,
                  size: 12,
                ),
                const VBox(10),
                Label(
                  text: task.createdAt.toString(),
                  color: Palette.grey,
                  size: 12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DismissibleBackground extends StatelessWidget {
  final Color color;
  final Alignment alignment;
  final IconData icon;

  const DismissibleBackground({
    required this.color,
    required this.alignment,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Align(
        alignment: alignment,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
