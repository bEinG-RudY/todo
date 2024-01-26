import 'package:flutter/material.dart';
import 'package:todo/constants/colors.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/viewmodel/task_viewmodel.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondary,
      appBar: AppBar(
        backgroundColor: primary,
        title: const Row(
          children: [
            CircleAvatar(
              radius: 15,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.check,
                size: 20,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "To Do List",
              style: TextStyle(fontSize: 25),
            ),
          ],
        ),
      ),
      body: Consumer<TaskViewmodel>(builder: (context, taskProvider, _) {
        return ListView.separated(
            itemBuilder: (context, index) {
              final task = taskProvider.tasks[index];
              return TaskTile(
                task: task,
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                color: primary,
                height: 1,
                thickness: 1,
              );
            },
            itemCount: taskProvider.tasks.length);
      }),
      floatingActionButton: const CustomFAB(),
    );
  }
}

class CustomFAB extends StatelessWidget {
  const CustomFAB({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return CustomDialog();
          },
        );
      },
      child: const Icon(
        Icons.add,
        size: 40,
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.sizeOf(context).height;
    double sw = MediaQuery.sizeOf(context).width;
    final taskProvider = Provider.of<TaskViewmodel>(context, listen: false);
    return Dialog(
      backgroundColor: secondary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        height: sh * 0.5,
        width: sw * 0.8,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: sw * 0.05, vertical: sh * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "New Task",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "What has to be done?",
                style: TextStyle(color: textBlue),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                hint: "Enter The Task",
                onChanged: (value) {
                  taskProvider.setTaskName(value);
                },
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "Due Date",
                style: TextStyle(color: textBlue),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                hint: "Enter Date",
                readOnly: true,
                controller: taskProvider.dateCont,
                icon: Icons.calendar_month,
                onTap: () async {
                  DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2017),
                      lastDate: DateTime(2030));
                  taskProvider.setDate(date);
                },
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                readOnly: true,
                controller: taskProvider.timeCont,
                hint: "Enter Time",
                icon: Icons.timer,
                onTap: () async {
                  TimeOfDay? time = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                  taskProvider.setTime(time);
                },
              ),
              SizedBox(
                height: 50,
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () async {
                      await taskProvider.addTask();
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      "Create",
                      style: TextStyle(color: primary),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.hint,
      this.icon,
      this.onTap,
      this.readOnly = false,
      this.onChanged,
      this.controller});

  final String hint;
  final IconData? icon;
  final void Function()? onTap;
  final bool? readOnly;
  final void Function(String)? onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: TextField(
        readOnly: readOnly!,
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            suffixIcon: InkWell(
                onTap: onTap,
                child: Icon(
                  icon,
                  color: Colors.white,
                )),
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey)),
      ),
    );
  }
}

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
  });
  final Task task;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      title: Text(
        task.taskName,
        style: TextStyle(
            fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        "${task.date}, ${task.time}",
        style: TextStyle(color: textBlue),
      ),
    );
  }
}
