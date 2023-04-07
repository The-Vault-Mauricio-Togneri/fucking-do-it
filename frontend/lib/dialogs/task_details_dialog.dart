import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:fucking_do_it/models/task.dart';
import 'package:fucking_do_it/states/task_details_state.dart';
import 'package:fucking_do_it/utils/palette.dart';
import 'package:fucking_do_it/widgets/custom_button.dart';
import 'package:fucking_do_it/widgets/task_card.dart';

class TaskDetailsDialog extends StatelessWidget {
  final TaskDetailsState state;

  const TaskDetailsDialog._(this.state);

  static DialogController show({
    required BuildContext context,
    required Task task,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => TaskDetailsDialog._(TaskDetailsState(task)),
    );

    return DialogController(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      content: StateProvider<TaskDetailsState>(
        state: state,
        builder: (context, state) => SizedBox(
          width: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              TaskCard(state.task),
              if (state.task.canBeReopened) ReopenButton(state),
              if (state.task.canBeCompleted) CompleteButton(state),
              if (state.task.canBeDeleted) DeleteButton(state),
            ],
          ),
        ),
      ),
    );
  }
}

class ReopenButton extends StatelessWidget {
  final TaskDetailsState state;

  const ReopenButton(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
      ),
      child: CustomButton(
        onPressed: state.onReopen,
        text: 'Reopen',
        color: Palette.primary,
      ),
    );
  }
}

class CompleteButton extends StatelessWidget {
  final TaskDetailsState state;

  const CompleteButton(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: CustomButton(
        onPressed: state.onComplete,
        text: 'Mark as done',
        color: Palette.green,
      ),
    );
  }
}

class DeleteButton extends StatelessWidget {
  final TaskDetailsState state;

  const DeleteButton(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: CustomButton(
        onPressed: state.onDelete,
        text: 'Delete',
        color: Palette.red,
      ),
    );
  }
}
