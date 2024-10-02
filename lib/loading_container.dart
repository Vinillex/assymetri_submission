import 'dart:async';

import 'package:assymetri_submission/my_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingContainer extends StatelessWidget {
  final int index;
  final Function() onEnd;
  LoadingContainer({super.key, required this.index, required this.onEnd});

  static const height = 20.0;
  static const borderRadius = height / 2;

  final MyFunctions controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        width: MediaQuery.of(context).size.width / controller.getItemsPerLine(),
        padding: const EdgeInsets.all(10),
        child: Container(
          height: height,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(borderRadius)),
            border: Border.all(
              width: 2,
              color: Colors.black,
            ),
          ),
          child: Align(
            alignment: controller.isReversed() ? Alignment.centerRight : Alignment.centerLeft,
            child: AnimatedFractionallySizedBox(
                  duration: controller.getClearState()
                      ? Duration(milliseconds: 50)
                      : controller.getDuration(),
                  widthFactor: controller.getClearState()
                      ? 0
                      : controller.currentIndex() >= index
                          ? 1
                          : 0,
                  onEnd: onEnd,
                  child: Container(
                    height: height,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.red,
                          Colors.black,
                        ],
                      ),
                    ),
                  ),
                ),
          ),
        ),
      );
    });
  }
}
