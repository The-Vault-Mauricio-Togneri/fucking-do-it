import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:fucking_do_it/models/comment.dart';
import 'package:fucking_do_it/models/task.dart';
import 'package:fucking_do_it/states/task_details_state.dart';
import 'package:fucking_do_it/utils/formatter.dart';
import 'package:fucking_do_it/utils/localizations.dart';
import 'package:fucking_do_it/utils/palette.dart';
import 'package:fucking_do_it/widgets/comment_input.dart';
import 'package:fucking_do_it/widgets/label.dart';
import 'package:fucking_do_it/widgets/person_avatar.dart';
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
      backgroundColor: Palette.dialogBackground,
      surfaceTintColor: Palette.dialogBackground,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Palette.border,
          width: 0.5,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
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
                CommentSection(state),
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

class CommentSection extends StatelessWidget {
  final TaskDetailsState state;

  const CommentSection(this.state);

  @override
  Widget build(BuildContext context) {
    final List<Comment> comments = state.task.commentsList;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 10,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
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
        for (int i = 0; i < comments.length; i++)
          CommentEntry(
            comment: comments[i],
            isLast: i == (comments.length - 1),
          ),
      ],
    );
  }
}

class CommentEntry extends StatelessWidget {
  final Comment comment;
  final bool isLast;

  const CommentEntry({
    required this.comment,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 5,
        bottom: 10,
        left: 55,
        right: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              PersonAvatar(
                avatar: comment.avatar,
                size: 24,
              ),
              const HBox(10),
              Label(
                text: comment.name,
                color: Palette.primaryText,
                weight: FontWeight.bold,
                size: 12,
              ),
              const HBox(10),
              Tooltip(
                message: Formatter.fullDateTime(comment.createdAt),
                child: Label(
                  text: Formatter.deltaTime(comment.createdAt),
                  color: Palette.grey,
                  size: 12,
                ),
              ),
            ],
          ),
          const VBox(5),
          Label(
            text: comment.content,
            color: Palette.grey,
            size: 12,
          ),
          if (!isLast)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: HorizontalDivider(
                color: Palette.border,
                height: 0.3,
              ),
            ),
        ],
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
