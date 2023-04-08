import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:fucking_do_it/utils/palette.dart';
import 'package:fucking_do_it/widgets/label.dart';

class TagsList extends StatelessWidget {
  final List<String> tags;
  final Function(String)? onDelete;

  const TagsList(this.tags, [this.onDelete]);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for (final String tag in tags)
          TagChip(
            text: tag,
            onDelete: onDelete,
          ),
      ],
    );
  }
}

class TagChip extends StatelessWidget {
  final String text;
  final Function(String)? onDelete;

  const TagChip({
    required this.text,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      padding: EdgeInsets.only(
        left: 4,
        right: (onDelete != null) ? 0 : 4,
      ),
      label: Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child: Label(
          text: text,
          color: Palette.white,
          size: 12,
        ),
      ),
      labelPadding: EdgeInsets.only(
        top: 0,
        bottom: 0,
        left: 5,
        right: (onDelete != null) ? 0 : 5,
      ),
      deleteIcon: (onDelete != null)
          ? const Icon(
              Icons.close,
              color: Palette.white,
              size: 15,
            )
          : const Empty(),
      onDeleted: (onDelete != null) ? () => onDelete?.call(text) : null,
    );
  }
}
