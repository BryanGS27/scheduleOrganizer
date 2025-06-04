import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule/app/data/datasources/local/models/task.dart';
import 'package:schedule/app/utils/theme/colors.dart';
import 'package:schedule/presentation/main-screen/main_controller.dart';

class TaskCard extends GetView<TaskController> {
  final Task task;
  final RxBool isExpanded;
  final int index;

  const TaskCard(
    this.task,
    this.isExpanded,
    this.index, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
        alignment: Alignment.topCenter,
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 300),
        //height: isExpanded.value ? 265 : 90,
        child: Container(
          alignment: Alignment.topCenter,
          width: context.width,
          margin: EdgeInsets.only(bottom: 0, right: 15, left: 15, top: 15),
          //height: context.height / 3,
          decoration: BoxDecoration(
              color: ThemeColors.sand, borderRadius: BorderRadius.circular(15)),
          child: InkWell(
            onTap: () {
              controller.isOpen[index].value = !controller.isOpen[index].value;
              controller.tasks.refresh();
            },
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 5,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          task.title,
                          style: TextStyles.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ),
                    Flexible(
                        flex: 1,
                        child: Checkbox(
                          shape: CircleBorder(),
                          checkColor: ThemeColors.lightThemeBackground,
                          activeColor: ThemeColors.darkBrown,
                          value: task.isDone,
                          onChanged: (_) => controller.showTaskFinishedConfirm(
                              context, controller.tasks[index].isDone, index),
                        )),
                  ],
                ),
                Visibility(
                    visible: isExpanded.value,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Divider(
                          color: ThemeColors.lightOrange,
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            task.description,
                            style: TextStyles.description,
                            maxLines: 7,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ));
  }
}
