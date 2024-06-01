import 'package:flutter/material.dart';
import 'package:pat_e/core/utils/themes/background_gradient.dart';

class InfoAndEducationColor {
  List<BoxDecoration> getBackgroundColor = [
    BackgroundGradient().buildGradient6(),
    BackgroundGradient().buildGradient7(),
    BackgroundGradient().buildGradient8(),
  ];

  List<BoxDecoration> gradients = [
    BackgroundGradient().buildGradient4(),
    BackgroundGradient().buildGradient5(),
  ];
}
