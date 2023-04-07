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
              const VBox(10),
              if (state.task.canBeCopied) CopyLinkButton(state),
              if (state.task.canBeReopened) ReopenButton(state),
              if (state.task.canBeCompleted) CompleteButton(state),
              if (state.task.canBeDeleted) DeleteButton(state),
              const VBox(10),
            ],
          ),
        ),
      ),
    );
  }
}

class CopyLinkButton extends StatelessWidget {
  final TaskDetailsState state;

  const CopyLinkButton(this.state);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
        bottom: 10,
      ),
      child: CustomButton(
        onPressed: state.onCopyLink,
        text: 'Copy link',
        color: Palette.primary,
      ),
    );
  }
}

class ReopenButton extends StatelessWidget {
  final TaskDetailsState state;

  const ReopenButton(this.state);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
        bottom: 10,
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

  const CompleteButton(this.state);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
        bottom: 10,
      ),
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

  const DeleteButton(this.state);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
        bottom: 10,
      ),
      child: CustomButton(
        onPressed: state.onDelete,
        text: 'Delete',
        color: Palette.red,
      ),
    );
  }
}
