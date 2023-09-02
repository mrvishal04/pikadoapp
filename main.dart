import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Task {
  String title;
  bool isCompleted;

  Task(this.title, this.isCompleted);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoScreen(),
    );
  }
}

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<Task> tasks = [];
  TextEditingController taskController = TextEditingController();

  void addTask(String title) {
    setState(() {
      tasks.add(Task(title, false));
      taskController.clear();
    });
  }

  void toggleTask(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
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
        title:const Text('To-do app'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15)
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                controller: taskController,
                decoration:InputDecoration(
                  hintText: 'Enter a task...',
                  border:const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      if (taskController.text.isNotEmpty) {
                        addTask(taskController.text);
                      }
                    },
                  ),
                ),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    addTask(value);
                  }
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Container(height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border:Border.all(color: Colors.grey),
                      gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors:[Colors.blue,Colors.teal]
                      ),
                    ),
                    child: Center(
                      child: ListTile(
                        title: Text(tasks[index].title,style: const TextStyle(
                          color: Colors.white
                        ),),
                        leading: Checkbox(
                          value: tasks[index].isCompleted,
                          onChanged: (value) {
                            toggleTask(index);
                          },
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete,color: Colors.white,),
                          onPressed: () {
                            deleteTask(index);
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
