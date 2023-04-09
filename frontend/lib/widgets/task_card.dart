import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:fucking_do_it/models/person.dart';
import 'package:fucking_do_it/models/task.dart';
import 'package:fucking_do_it/utils/palette.dart';
import 'package:fucking_do_it/widgets/label.dart';
import 'package:fucking_do_it/widgets/markdown_text.dart';
import 'package:fucking_do_it/widgets/person_avatar.dart';
import 'package:fucking_do_it/widgets/priority_chip.dart';
import 'package:fucking_do_it/widgets/tags_list.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final bool selectable;
  final bool showComments;
  final double bottomPadding;

  const TaskCard({
    required this.task,
    required this.selectable,
    required this.showComments,
    required this.bottomPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: bottomPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.title,
                color: Palette.grey,
                size: 20,
              ),
              const HBox(15),
              Expanded(
                child: Label(
                  text: task.title,
                  color: Palette.black,
                  weight: FontWeight.bold,
                  size: 14,
                ),
              ),
            ],
          ),
          if (task.description.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.view_headline_outlined,
                    color: Palette.grey,
                    size: 20,
                  ),
                  const HBox(15),
                  Expanded(
                    child: MarkdownText(
                      text: task.description,
                      selectable: selectable,
                    ),
                  ),
                ],
              ),
            ),
          const VBox(10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.flag_rounded,
                color: Palette.grey,
                size: 20,
              ),
              const HBox(15),
              PriorityChip(
                priority: task.priority,
                size: 12,
                selected: true,
              ),
            ],
          ),
          if (task.deadline != null)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.calendar_today,
                    color: Palette.grey,
                    size: 20,
                  ),
                  const HBox(15),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Label(
                        text: task.deadlineText,
                        color: task.deadlineTextColor,
                        size: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (task.assignedTo.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: Icon(
                      Icons.people,
                      color: Palette.grey,
                      size: 20,
                    ),
                  ),
                  const HBox(15),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (int i = 0; i < task.assignedTo.length; i++)
                          AssignedPersonRow(
                            person: task.person(task.assignedTo[i]),
                            isLast: i == (task.assignedTo.length - 1),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          if (task.comments.isNotEmpty && showComments)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.comment_outlined,
                    color: Palette.grey,
                    size: 20,
                  ),
                  const HBox(15),
                  Expanded(
                    child: Label(
                      text: '${task.comments.length}',
                      color: Palette.grey,
                      size: 14,
                    ),
                  ),
                ],
              ),
            ),
          if (task.tags.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Icon(
                      Icons.label_outline_rounded,
                      color: Palette.grey,
                      size: 20,
                    ),
                  ),
                  const HBox(15),
                  Expanded(child: TagsList(task.tags)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class AssignedPersonRow extends StatelessWidget {
  final Person person;
  final bool isLast;

  const AssignedPersonRow({
    required this.person,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 5),
      child: Row(
        children: [
          PersonAvatar(
            avatar: person.avatar,
            size: 24,
          ),
          const HBox(10),
          Expanded(
            child: Label(
              text: person.name,
              color: Palette.grey,
              size: 12,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
