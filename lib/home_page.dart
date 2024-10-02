import 'package:assymetri_submission/loading_container.dart';
import 'package:assymetri_submission/my_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/state_manager.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final MyFunctions controller = Get.put(MyFunctions());

  @override
  Widget build(BuildContext context) {
    controller.startAnimation();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              'https://i.ibb.co/dbB2qtK/2-Assymetri-White-on-black.png',
            ),
            Obx(
              () => DropdownButton<ColorTheme>(
                value: controller.getColorTheme(),
                items: const [
                  DropdownMenuItem(
                    value: ColorTheme.green,
                    child: Text('Green'),
                  ),
                  DropdownMenuItem(
                    value: ColorTheme.red,
                    child: Text('Red'),
                  ),
                  DropdownMenuItem(
                    value: ColorTheme.blue,
                    child: Text('Blue'),
                  ),
                  DropdownMenuItem(
                    value: ColorTheme.purple,
                    child: Text('Purple'),
                  ),
                ],
                onChanged: (value) {
                  controller.setColor(value ?? ColorTheme.green);
                },
              ),
            ),
            Obx(
              () => Slider(
                divisions: 2,
                value: controller.getSliderValue(),
                label: controller.getSliderString(),
                onChanged: (val) {
                  controller.setSpeed(val);
                },
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Total Items',
              ),
              onChanged: (value) {
                if (value != '') {
                  controller.setTotalItemCount(int.parse(value));
                }
              },
              autovalidateMode: AutovalidateMode.always,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Items in line',
              ),
              onChanged: (value) {
                if (value != '') {
                  controller.setItemsPerLine(int.parse(value));
                }
              },
              autovalidateMode: AutovalidateMode.always,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
            ),
            Obx(
              () => Row(
                children: [
                  Text('Switch'),
                  Spacer(),
                  Switch(
                    value: controller.isReversed(),
                    onChanged: (value) {
                      controller.setDirection(value);
                    },
                  ),
                ],
              ),
            ),
            Obx(() {
              return Wrap(
                alignment: WrapAlignment.center,
                children: [
                  if(!controller.isReversed())
                  ...List.generate(controller.getTotalItemCount(), (index) {
                    return LoadingContainer(
                      index: index,
                      onEnd: () {
                        controller.animateNext(index);
                      },
                    );
                  }),
                  if(controller.isReversed())
                  ...List.generate(controller.getTotalItemCount(), (index) {
                    return LoadingContainer(
                      index: index,
                      onEnd: () {
                        controller.animateNext(index);
                      },
                    );
                  }).reversed
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
