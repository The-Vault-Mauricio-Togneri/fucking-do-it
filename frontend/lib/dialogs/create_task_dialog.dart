import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:fucking_do_it/states/create_task_state.dart';
import 'package:fucking_do_it/types/priority.dart';
import 'package:fucking_do_it/utils/localizations.dart';
import 'package:fucking_do_it/utils/navigation.dart';
import 'package:fucking_do_it/utils/palette.dart';
import 'package:fucking_do_it/widgets/input_field.dart';
import 'package:fucking_do_it/widgets/primary_button.dart';
import 'package:fucking_do_it/widgets/priority_chip.dart';
import 'package:fucking_do_it/widgets/tags_list.dart';
import 'package:fucking_do_it/widgets/tertiary_button.dart';

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
      surfaceTintColor: Palette.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            InputField(
              label: Localized.get.inputTitle,
              autofocus: true,
              controller: state.titleController,
              inputType: TextInputType.text,
              onChanged: (input) => state.onTitleChanged(),
            ),
            const VBox(15),
            InputField(
              label: Localized.get.inputDescription,
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
                Expanded(
                  child: PriorityChip(
                    priority: Priority.high,
                    size: 16,
                    selected: state.priority == Priority.high,
                    onPressed: state.onSetPriority,
                  ),
                ),
                const HBox(10),
                Expanded(
                  child: PriorityChip(
                    priority: Priority.medium,
                    size: 16,
                    selected: state.priority == Priority.medium,
                    onPressed: state.onSetPriority,
                  ),
                ),
                const HBox(10),
                Expanded(
                  child: PriorityChip(
                    priority: Priority.low,
                    size: 16,
                    selected: state.priority == Priority.low,
                    onPressed: state.onSetPriority,
                  ),
                ),
              ],
            ),
            const VBox(15),
            SizedBox(
              width: 200,
              child: InputField(
                label: Localized.get.inputDeadline,
                controller: state.deadlineController,
                inputType: TextInputType.text,
                canBeEmpty: true,
                enabled: false,
                suffixIcon: const Icon(
                  Icons.calendar_month,
                  color: Palette.border,
                  size: 20,
                ),
                onPressed: () => state.onSelectDeadline(context),
              ),
            ),
            const VBox(15),
            InputField(
              label: Localized.get.inputTags,
              controller: state.tagsController,
              inputType: TextInputType.text,
              focusNode: state.tagsFocus,
              canBeEmpty: true,
              onSubmit: state.onCreateTag,
            ),
            const VBox(10),
            TagsList(state.tags, state.onDeleteTag),
          ],
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
      child: PrimaryButton(
        text: Localized.get.buttonCreate,
        color: Palette.primary,
        icon: Icons.add,
        onSubmit: state.canSubmit ? state.onSubmit : null,
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
      child: TertiaryButton(
        text: Localized.get.buttonClose,
        onSubmit: Navigation.pop,
        color: Palette.grey,
      ),
    );
  }
}
