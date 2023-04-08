import 'package:flutter/material.dart';
import 'package:fucking_do_it/types/priority.dart';
import 'package:fucking_do_it/utils/palette.dart';
import 'package:fucking_do_it/widgets/label.dart';

class PriorityChip extends StatelessWidget {
  final Priority priority;
  final double size;
  final bool selected;
  final Function(Priority)? onPressed;

  const PriorityChip({
    required this.priority,
    required this.size,
    required this.selected,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: selected ? priority.backgroundColor : Palette.unselected,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Material(
          color: Palette.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: InkWell(
            onTap: () => onPressed?.call(priority),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Padding(
              padding: EdgeInsets.all(size / 3),
              child: Center(
                child: Label(
                  text: priority.text,
                  color: selected ? priority.textColor : Palette.grey,
                  size: size,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
