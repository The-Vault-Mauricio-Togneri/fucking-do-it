import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:fucking_do_it/models/task.dart';
import 'package:fucking_do_it/states/main_state.dart';
import 'package:fucking_do_it/utils/localizations.dart';
import 'package:fucking_do_it/utils/palette.dart';
import 'package:fucking_do_it/widgets/label.dart';

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
          onPressed: state.onCreateTask,
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
      builder: (context, state) => state.hasTasks ? (state.tasks.isEmpty ? const NoTasks() : TaskList(state)) : const Waiting(),
    );
  }
}

class Waiting extends StatelessWidget {
  const Waiting();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class NoTasks extends StatelessWidget {
  const NoTasks();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Label(
        text: Localized.get.listEmpty,
        color: Palette.black,
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  final MainState state;

  const TaskList(this.state);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: state.tasks.length,
      itemBuilder: (context, index) => TaskEntry(
        state: state,
        task: state.tasks[index],
      ),
      separatorBuilder: (context, index) => const HorizontalDivider(
        height: 0.1,
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
      width: double.infinity,
      color: task.priority.color,
      child: Material(
        color: Palette.transparent,
        child: InkWell(
          onTap: () => state.onTaskSelected(task),
          onLongPress: () => state.onOptionsSelected(task),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 17, 12, 17),
            child: Label(
              text: task.title,
              size: 12,
              color: Palette.black,
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
