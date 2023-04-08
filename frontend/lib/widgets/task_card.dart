import 'package:cached_network_image/cached_network_image.dart';
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
                Icons.signal_cellular_alt,
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
          /*const VBox(10),
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
          ),*/
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
                          Assignee(
                            avatar: task.assignedInfo[task.assignedTo[i]]['avatar'],
                            name:
                                ' since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen ', // task.assignedInfo[task.assignedTo[i]]['name']
                            isLast: i < (task.assignedTo.length - 1),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class Assignee extends StatelessWidget {
  final String avatar;
  final String name;
  final bool isLast;

  const Assignee({
    required this.avatar,
    required this.name,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 5),
      child: Row(
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: Palette.transparent,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(100)),
              child: SizedBox(
                width: 24,
                height: 24,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: avatar,
                  placeholder: (context, url) => Container(color: Palette.background),
                  errorWidget: (context, url, error) => Container(
                    color: Palette.background,
                    child: const Icon(
                      Icons.person,
                      size: 15,
                      color: Palette.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const HBox(5),
          Expanded(
            child: Label(
              text: name,
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
