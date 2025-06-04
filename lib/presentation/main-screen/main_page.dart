import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule/app/utils/theme/colors.dart';
import 'package:schedule/presentation/main-screen/main_controller.dart';
import 'package:schedule/presentation/main-screen/widgets/task_card.dart';

class TaskPage extends StatelessWidget {
  final controller = Get.put(TaskController());

  TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: Image.asset(
                  'assets/images/user-icon.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Column(
                  children: [
                    Text(
                      "Organizador de tareas",
                      style: TextStyles.header,
                    ),
                    Text(
                      "Bienvenido {user}",
                      style: TextStyles.header
                          .copyWith(fontStyle: FontStyle.italic, fontSize: 25),
                    ),
                  ],
                ),
              )
            ],
          ),
          toolbarHeight: 100,
          backgroundColor: ThemeColors.darkBrown,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
        ),
        backgroundColor: ThemeColors.lightThemeBackground,
        floatingActionButton: FloatingActionButton(
          backgroundColor: ThemeColors.darkBrown,
          onPressed: () => controller.showAddDialog(context),
          child: Icon(
            Icons.add,
            color: ThemeColors.lightThemeBackground,
          ),
        ),
        body: Obx(() => ListView.builder(
              itemCount: controller.tasks.length,
              itemBuilder: (_, i) {
                final task = controller.tasks[i];
                return TaskCard(task, controller.isOpen[i], i);
              },
            )));
  }
}
