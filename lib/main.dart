import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Task {
  String title;
  bool isCompleted;

  Task({required this.title, this.isCompleted = false});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Task> tasks = [];

  void addTask(String title) {
    setState(() {
      tasks.add(Task(title: title));
    });
  }

  void completeTask(int index) {
    setState(() {
      tasks[index].isCompleted = true;
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task.title),
            trailing: task.isCompleted
                ? Icon(Icons.check_circle, color: Colors.green)
                : null,
            onTap: () {
              completeTask(index);
            },
            onLongPress: () {
              deleteTask(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              TextEditingController taskController = TextEditingController();
              return AlertDialog(
                title: Text('Add Task'),
                content: TextField(
                  controller: taskController,
                  autofocus: true,
                ),
                actions: [
                  TextButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('Add'),
                    onPressed: () {
                      addTask(taskController.text);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

