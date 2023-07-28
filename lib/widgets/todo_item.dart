import 'package:flutter/material.dart';
import 'package:todo/constants/colors.dart';
import 'package:todo/model/todo_model.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  const ToDoItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone! ? Icons.check_box : Icons.check_box_outline_blank,
          color: tdBlue,
        ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
              fontSize: 16,
              color: tdBlack,
              decoration: todo.isDone! ? TextDecoration.lineThrough : null),
        ),
        trailing: deleteToDo(),
      ),
    );
  }

  ListTile _todoItemTile() {
    return ListTile(
      onTap: () {},
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      tileColor: Colors.white,
      leading: Icon(
        todo.isDone! ? Icons.check_box : Icons.check_box_outline_blank,
        color: tdBlue,
      ),
      title: Text(
        todo.todoText!,
        style: TextStyle(
          fontSize: 16,
          color: tdBlack,
          decoration: todo.isDone! ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: deleteToDo(),
    );
  }

  Container deleteToDo() {
    return Container(
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.symmetric(vertical: 12),
      height: 35,
      width: 35,
      decoration: BoxDecoration(
        color: tdRed,
        borderRadius: BorderRadius.circular(5),
      ),
      child: IconButton(
        color: Colors.white,
        onPressed: () {},
        iconSize: 18,
        icon: Icon(Icons.delete),
      ),
    );
  }
}
