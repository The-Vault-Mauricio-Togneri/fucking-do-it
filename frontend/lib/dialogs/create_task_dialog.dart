import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:fucking_do_it/states/create_task_state.dart';
import 'package:fucking_do_it/types/priority.dart';
import 'package:fucking_do_it/utils/navigation.dart';
import 'package:fucking_do_it/utils/palette.dart';
import 'package:fucking_do_it/widgets/custom_button.dart';
import 'package:fucking_do_it/widgets/custom_form_field.dart';
import 'package:fucking_do_it/widgets/label.dart';

class CreateTaskDialog extends StatelessWidget {
  final CreateTaskState state;

  const CreateTaskDialog._(this.state);

  static DialogController show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CreateTaskDialog._(CreateTaskState()),
    );

    return DialogController(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      backgroundColor: Palette.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      content: StateProvider<CreateTaskState>(
        state: state,
        builder: (context, state) => SizedBox(
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Fields(state),
              CreateButton(state),
              const CloseButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class Fields extends StatelessWidget {
  final CreateTaskState state;

  const Fields(this.state);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: state.formKey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomFormField(
              label: 'Title',
              autofocus: true,
              controller: state.titleController,
              inputType: TextInputType.text,
              onChanged: (input) => state.onTitleChanged(),
            ),
            const VBox(15),
            CustomFormField(
              label: 'Description (optional)',
              controller: state.descriptionController,
              inputType: TextInputType.text,
              canBeEmpty: true,
              minLines: 1,
              maxLines: 5,
            ),
            const VBox(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PrioritySelector(
                  state: state,
                  priority: Priority.high,
                ),
                const HBox(10),
                PrioritySelector(
                  state: state,
                  priority: Priority.medium,
                ),
                const HBox(10),
                PrioritySelector(
                  state: state,
                  priority: Priority.low,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PrioritySelector extends StatelessWidget {
  final CreateTaskState state;
  final Priority priority;

  const PrioritySelector({
    required this.state,
    required this.priority,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: (state.priority == priority) ? priority.color : Palette.grey,
        child: Material(
          color: Palette.transparent,
          child: InkWell(
            onTap: () => state.onSetPriority(priority),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Label(
                  text: priority.text,
                  color: Palette.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CreateButton extends StatelessWidget {
  final CreateTaskState state;

  const CreateButton(this.state);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 30,
        left: 20,
        right: 20,
        bottom: 10,
      ),
      child: CustomButton(
        onPressed: state.canSubmit ? state.onSubmit : null,
        text: 'Create',
      ),
    );
  }
}

class CloseButton extends StatelessWidget {
  const CloseButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: TextButton(
        onPressed: Navigation.pop,
        child: Label(
          text: 'Close'.toUpperCase(),
          color: Palette.grey,
          weight: FontWeight.bold,
          size: 12,
        ),
      ),
    );
  }
}
