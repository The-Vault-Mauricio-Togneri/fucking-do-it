import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:fucking_do_it/models/task.dart';
import 'package:fucking_do_it/states/main_state.dart';
import 'package:fucking_do_it/utils/brightness_manager.dart';
import 'package:fucking_do_it/utils/localizations.dart';
import 'package:fucking_do_it/utils/palette.dart';
import 'package:fucking_do_it/widgets/label.dart';
import 'package:fucking_do_it/widgets/task_card.dart';

class MainScreen extends StatelessWidget {
  final MainState state;

  const MainScreen._(this.state);

  factory MainScreen.instance() => MainScreen._(MainState());

  @override
  Widget build(BuildContext context) {
    return StateProvider<MainState>(
      state: state,
      builder: (context, state) => Title(
        title: state.title,
        color: Palette.primary,
        child: Scaffold(
          backgroundColor: Palette.background,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Palette.primary,
            title: Center(
              child: Label(
                text: Localized.get.appName.toUpperCase(),
                color: Palette.white,
                size: 16,
              ),
            ),
            leading: (BrightnessManager.isDarkMode)
                ? IconButton(
                    onPressed: state.onLightMode,
                    icon: const Icon(Icons.wb_sunny),
                    color: Palette.white,
                  )
                : IconButton(
                    onPressed: state.onDarkMode,
                    icon: const Icon(Icons.nightlight),
                    color: Palette.white,
                  ),
            actions: [
              IconButton(
                onPressed: state.signOut,
                icon: const Icon(Icons.logout),
                color: Palette.white,
              ),
            ],
          ),
          body: Content(state),
          floatingActionButton: FloatingActionButton(
            onPressed: () => state.onCreateTask(context),
            backgroundColor: Palette.primary,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(100))),
            child: const Icon(
              Icons.add,
              color: Palette.white,
            ),
          ),
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
            title: Localized.get.labelAssignedToMe,
            tasks: state.tasksAssignedToMe,
          ),
          const VerticalDivider(),
          TaskColumn(
            state: state,
            title: Localized.get.labelCreated,
            tasks: state.tasksCreated,
          ),
          const VerticalDivider(),
          TaskColumn(
            state: state,
            title: Localized.get.labelAccepted,
            tasks: state.tasksAccepted,
          ),
          const VerticalDivider(),
          TaskColumn(
            state: state,
            title: Localized.get.labelInReview,
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
      color: Palette.border,
      width: 0.4,
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
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Label(
                  text: title.toUpperCase(),
                  color: Palette.primaryText,
                  weight: FontWeight.bold,
                ),
                if ((tasks != null) && (tasks!.isNotEmpty))
                  AmountChip(tasks!.length),
              ],
            ),
          ),
          if (tasks != null) TasksList(state, tasks!) else const LoadingTasks(),
        ],
      ),
    );
  }
}

class AmountChip extends StatelessWidget {
  final num amount;

  const AmountChip(this.amount);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 5),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(100)),
        color: Palette.error,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 1,
          bottom: 4,
          left: 6,
          right: 6,
        ),
        child: Label(
          text: amount.toString(),
          color: Palette.white,
          size: 12,
        ),
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
    return Expanded(
      child: tasks.isNotEmpty
          ? SingleChildScrollView(
              child: Column(
                children: [
                  for (final Task task in tasks)
                    TaskEntry(state: state, task: task),
                ],
              ),
            )
          : const NoTasks(),
    );
  }
}

class LoadingTasks extends StatelessWidget {
  const LoadingTasks();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: CircularProgressIndicator(color: Palette.loading),
      ),
    );
  }
}

class NoTasks extends StatelessWidget {
  const NoTasks();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Label(
        text: Localized.get.labelEmpty,
        color: Palette.grey,
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
        bottom: 15,
        left: 15,
        right: 15,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Palette.dialogBackground,
        border: Border.all(
          color: Palette.border,
          width: 0.5,
        ),
      ),
      child: Material(
        color: Palette.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: InkWell(
          highlightColor: Palette.splash,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          onTap: () => state.onTaskSelected(context, task),
          child: TaskCard(
            task: task,
            selectable: false,
            showComments: true,
            bottomPadding: 20,
          ),
        ),
      ),
    );
  }
}
