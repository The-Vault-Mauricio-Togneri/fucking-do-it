import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:fucking_do_it/models/task.dart';
import 'package:fucking_do_it/utils/palette.dart';
import 'package:fucking_do_it/widgets/label.dart';
import 'package:link_text/link_text.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard(this.task);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.video_label,
                color: Palette.grey,
                size: 20,
              ),
              const HBox(15),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Label(
                    text: task.title,
                    color: Palette.black,
                    weight: FontWeight.bold,
                    size: 14,
                  ),
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
                    child: Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: LinkText(
                        task.description,
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
                  ),
                ],
              ),
            ),
          const VBox(10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.priority_high_rounded,
                color: Palette.grey,
                size: 20,
              ),
              const HBox(15),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Label(
                    text: task.priority.text.toUpperCase(),
                    color: task.priority.color,
                    weight: FontWeight.bold,
                    size: 12,
                  ),
                ),
              ),
            ],
          ),
          const VBox(10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.calendar_month_outlined,
                color: Palette.grey,
                size: 20,
              ),
              const HBox(15),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Label(
                    text: task.createdAtDateTime,
                    color: Palette.grey,
                    size: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
