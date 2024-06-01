import 'package:flutter/material.dart';
import 'package:pat_e/common/constants/image_paths.dart';

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({super.key, this.iconSize, required this.color});

  final double? iconSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: iconSize,
          height: iconSize,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(iconSize == null ? 6 : 4)),
        ),
        iconSize != null
            ? Container(
                alignment: Alignment.center,
                width: 120,
                height: 120,
                child: Image.asset(
                  ImagePaths.animalShelter,
                  width: 80,
                  height: 80,
                ),
              )
            : Container(
                alignment: Alignment.center,
                width: 120,
                height: 120,
                child: Image.asset(
                  ImagePaths.animalShelter,
                  width: 80,
                  height: 80,
                ),
              )
      ],
    );
  }
}
