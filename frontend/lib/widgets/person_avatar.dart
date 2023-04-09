import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fucking_do_it/utils/palette.dart';

class PersonAvatar extends StatelessWidget {
  final String avatar;
  final double size;

  const PersonAvatar({
    required this.avatar,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: Palette.transparent,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        child: SizedBox(
          width: size,
          height: size,
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: avatar,
            placeholder: (context, url) => Container(color: Palette.background),
            errorWidget: (context, url, error) => Container(
              color: Palette.background,
              child: Icon(
                Icons.person,
                size: size * 1.25,
                color: Palette.icon,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
