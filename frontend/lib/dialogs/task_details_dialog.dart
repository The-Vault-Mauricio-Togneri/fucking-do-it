import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:fucking_do_it/models/task.dart';
import 'package:fucking_do_it/states/task_details_state.dart';
import 'package:fucking_do_it/utils/localizations.dart';
import 'package:fucking_do_it/utils/palette.dart';
import 'package:fucking_do_it/widgets/comment_input.dart';
import 'package:fucking_do_it/widgets/primary_button.dart';
import 'package:fucking_do_it/widgets/task_card.dart';
import 'package:fucking_do_it/widgets/tertiary_button.dart';

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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TaskCard(
                  task: state.task,
                  selectable: true,
                  showComments: false,
                  bottomPadding: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 10,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.comment_outlined,
                        color: Palette.grey,
                        size: 20,
                      ),
                      const HBox(15),
                      Expanded(
                        child: CommentInput(
                          controller: state.commentController,
                          focusNode: state.commentFocus,
                          onSubmit: state.onSubmitComment,
                        ),
                      ),
                    ],
                  ),
                ),
                const VBox(10),
                if (state.task.canBeAccepted) AcceptButton(state),
                if (state.task.canBeCopied) CopyLinkButton(state),
                if (state.task.canBeReopened) ReopenButton(state),
                if (state.task.canBeCompleted) CompleteButton(state),
                if (state.task.canBeEdited) EditButton(state),
                if (state.task.canBeDeleted) DeleteButton(state),
                const VBox(10),
              ],
            ),
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
        text: Localized.get.buttonAccept,
        onSubmit: state.onAccept,
        icon: Icons.check,
        color: Palette.success,
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
        text: Localized.get.buttonCopyLink,
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
        text: Localized.get.buttonReopen,
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
        text: Localized.get.buttonCompleted,
        color: Palette.success,
        icon: Icons.done,
        onSubmit: state.onComplete,
      ),
    );
  }
}

class EditButton extends StatelessWidget {
  final TaskDetailsState state;

  const EditButton(this.state);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: TertiaryButton(
        text: Localized.get.buttonEdit,
        color: Palette.primary,
        onSubmit: () => state.onEdit(context),
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
      ),
      child: TertiaryButton(
        text: Localized.get.buttonDelete,
        color: Palette.error,
        onSubmit: () => state.onDelete(context),
      ),
    );
  }
}
