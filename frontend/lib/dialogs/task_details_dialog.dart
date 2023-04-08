import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:fucking_do_it/models/task.dart';
import 'package:fucking_do_it/states/task_details_state.dart';
import 'package:fucking_do_it/utils/palette.dart';
import 'package:fucking_do_it/widgets/primary_button.dart';
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
      backgroundColor: Palette.white,
      surfaceTintColor: Palette.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
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
              if (state.task.canBeAccepted) AcceptButton(state),
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

class AcceptButton extends StatelessWidget {
  final TaskDetailsState state;

  const AcceptButton(this.state);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 10,
      ),
      child: PrimaryButton(
        text: 'Accept',
        onSubmit: state.onAccept,
        icon: Icons.check,
        color: Palette.green,
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
        left: 20,
        right: 20,
        bottom: 10,
      ),
      child: PrimaryButton(
        text: 'Copy link',
        color: Palette.primary,
        icon: Icons.copy,
        onSubmit: state.onCopyLink,
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
        left: 20,
        right: 20,
        bottom: 10,
      ),
      child: PrimaryButton(
        text: 'Reopen',
        color: Palette.primary,
        icon: Icons.undo,
        onSubmit: state.onReopen,
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
        left: 20,
        right: 20,
        bottom: 10,
      ),
      child: PrimaryButton(
        text: 'Mark as done',
        color: Palette.green,
        icon: Icons.done,
        onSubmit: state.onComplete,
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
        left: 20,
        right: 20,
        bottom: 10,
      ),
      child: PrimaryButton(
        text: 'Delete',
        color: Palette.red,
        icon: Icons.delete,
        onSubmit: state.onDelete,
      ),
    );
  }
}
