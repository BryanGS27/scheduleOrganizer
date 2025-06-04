import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:schedule/app/data/datasources/local/models/task.dart';
import 'package:schedule/app/utils/theme/colors.dart';

class TaskController extends GetxController {
  var tasks = <Task>[].obs;
  late Box<Task> taskBox;
  final RxList<RxBool> isOpen = <RxBool>[].obs;
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  @override
  void onInit() {
    taskBox = Hive.box<Task>('tasks');
    tasks.value = taskBox.values.toList();
    for (int i = 0; i < tasks.length; i++) {
      isOpen.add(RxBool(false));
    }
    super.onInit();
  }

  void addTask(Task task) {
    if (task.title.trim().isEmpty || task.description.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'El título y la descripción no pueden estar vacíos',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    isOpen.add(RxBool(false));
    taskBox.add(task);
    tasks.add(task);
  }

  void toggleTask(Task task) {
    task.isDone = !task.isDone;
    task.save();
    tasks.refresh();
  }

  void showAddDialog(BuildContext context) {
    Get.defaultDialog(
      titlePadding: EdgeInsets.only(top: 20, left: 20, right: 20),
      contentPadding: EdgeInsets.all(15),
      backgroundColor: ThemeColors.sand,
      title: "Agregar una nueva tarea",
      content: SizedBox(
        width: context.width,
        child: Column(
          children: [
            Divider(
              color: ThemeColors.lightOrange,
            ),
            TextField(
                maxLines: 4,
                minLines: 1,
                keyboardType: TextInputType.multiline,
                controller: titleCtrl,
                decoration: InputDecoration(
                  hintText: "Título",
                )),
            TextField(
                maxLines: 6,
                minLines: 1,
                keyboardType: TextInputType.multiline,
                controller: descCtrl,
                decoration: InputDecoration(hintText: "Descripción")),
          ],
        ),
      ),
      confirm: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(ThemeColors.darkBrown),
          foregroundColor: WidgetStateProperty.all(Colors.white),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
        onPressed: () {
          final task = Task(title: titleCtrl.text, description: descCtrl.text);
          addTask(task);
          titleCtrl.clear();
          descCtrl.clear();
          Get.back();
        },
        child: Text("Agregar"),
      ),
    );
  }

  void showTaskFinishedConfirm(
      BuildContext context, bool isCompleted, int index) {
    Get.defaultDialog(
      titlePadding: EdgeInsets.only(top: 20, left: 20, right: 20),
      contentPadding: EdgeInsets.all(15),
      backgroundColor: ThemeColors.sand,
      title:
          "¿Quieres marcar esta tarea como ${isCompleted ? "no completada" : "completada"}?",
      content: SizedBox(
        width: context.width,
      ),
      confirm: ElevatedButton(
        style: ButtonStyles.regular,
        onPressed: () {
          toggleTask(tasks[index]);
          Get.back();
          tasks.refresh();
        },
        child: Text("Aceptar"),
      ),
      cancel: ElevatedButton(
          style: ButtonStyles.cancel,
          onPressed: () => Get.back(),
          child: Text("Cancelar")),
    );
  }
}
