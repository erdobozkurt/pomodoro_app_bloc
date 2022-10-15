import 'package:flutter/material.dart';

class ProjectPaddings extends EdgeInsets {
  const ProjectPaddings.all() : super.all(30);
  const ProjectPaddings.only({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) : super.only(
          left: left,
          top: top,
          right: right,
          bottom: bottom,
        );
}
