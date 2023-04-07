import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:fucking_do_it/models/task.dart';
import 'package:fucking_do_it/states/task_details_state.dart';
import 'package:fucking_do_it/utils/palette.dart';
import 'package:fucking_do_it/widgets/custom_button.dart';
import 'package:fucking_do_it/widgets/label.dart';
import 'package:link_text/link_text.dart';

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
              Fields(state),
              DeleteButton(state),
            ],
          ),
        ),
      ),
    );
  }
}

class Fields extends StatelessWidget {
  final TaskDetailsState state;

  const Fields(this.state);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Label(
            text: state.task.title,
            color: Palette.black,
            weight: FontWeight.bold,
            size: 14,
          ),
          if (state.task.description.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: LinkText(
                state.task.description,
                textStyle: const TextStyle(
                  color: Palette.grey,
                  fontSize: 14,
                ),
                linkStyle: const TextStyle(
                  color: Palette.primary,
                  fontSize: 14,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          const VBox(15),
          Label(
            text: state.task.priority.text.toUpperCase(),
            color: state.task.priority.color,
            weight: FontWeight.bold,
            size: 14,
          ),
        ],
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
