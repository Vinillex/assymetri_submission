import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

enum ColorTheme {
  green,
  blue,
  red,
  purple,
}

enum Speed { slow, smooth, fast }

enum Direction {
  forward,
  backward,
}

class MyFunctions extends GetxController {
  var totalItems = 1.obs;
  var itemsPerLine = 1.obs;
  var speed = Speed.smooth.obs;
  var color = ColorTheme.green.obs;
  var direction = Direction.forward.obs;
  var currentIndex = (-1).obs;

  Duration _duration() {
    return switch (speed.value) {
      Speed.slow => const Duration(seconds: 3),
      Speed.smooth => const Duration(seconds: 2),
      Speed.fast => const Duration(seconds: 1)
    };
  }

  double _slider() => switch (speed.value) {
        Speed.slow => 0,
        Speed.smooth => 0.5,
        Speed.fast => 1,
      };

  String _sliderText() => switch (speed.value) {
        Speed.slow => 'Slow',
        Speed.smooth => 'Smooth',
        Speed.fast => 'Fast',
      };

  Speed _speedSlider(double value) {
    if (value == 0) {
      return Speed.slow;
    }
    if (value == 0.5) {
      return Speed.smooth;
    }
    if (value == 1) {
      return Speed.fast;
    }
    return Speed.smooth;
  }

  Color _colorTheme() => switch (color.value) {
        ColorTheme.green => Colors.green,
        ColorTheme.blue => Colors.blue,
        ColorTheme.red => Colors.red,
        ColorTheme.purple => Colors.purple,
      };

  Direction _directionSwicth(bool value) {
    if (value) {
      return Direction.backward;
    }
    return Direction.forward;
  }

  setTotalItemCount(int count) {
    totalItems.value = count;
    currentIndex.value = -1;
    Future.delayed(Duration(milliseconds: 100), () {
      currentIndex.value = 0;
    });
  }

  startAnimation() {
    currentIndex.value = -1;
    Future.delayed(Duration(milliseconds: 100), () {
      currentIndex.value = 0;
    });
  }

  animateNext(int index) {
    if (index == totalItems.value - 1) {
      currentIndex.value = -1;
    Future.delayed(Duration(milliseconds: 100), () {
      currentIndex.value = 0;
    });
    } else {
      currentIndex.value = index + 1;
    }
  }

  setItemsPerLine(int count) {
    itemsPerLine.value = count;
    currentIndex.value = -1;
    Future.delayed(Duration(milliseconds: 100), () {
      currentIndex.value = 0;
    });
  }

  setSpeed(double value) => speed.value = _speedSlider(value);
  setColor(ColorTheme value) => color.value = value;
  setDirection(bool value) {
    direction.value = _directionSwicth(value);
    currentIndex.value = -1;
    Future.delayed(Duration(milliseconds: 100), () {
      currentIndex.value = 0;
    });
  }

  int getTotalItemCount() => totalItems.value;
  int getItemsPerLine() => itemsPerLine.value;
  Duration getDuration() => _duration();
  double getSliderValue() => _slider();
  String getSliderString() => _sliderText();
  ColorTheme getColorTheme() => color.value;
  Color getColor() => _colorTheme();
  bool isReversed() => (direction.value == Direction.backward);
  int getCurrentINdex() => currentIndex.value;
  bool getClearState() => currentIndex.value == -1;
}
