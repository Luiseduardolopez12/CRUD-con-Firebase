import 'package:flutter/material.dart';
import 'firestore_service.dart';
import 'task.dart';
import 'task_form.dart';

class TaskApp extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task Manager')),
      body: StreamBuilder<List<Task>>(
        stream: _firestoreService.getTasks(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          final tasks = snapshot.data!;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return ListTile(
                title: Text(task.title),
                subtitle: Text(task.description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => _editTask(context, task),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _firestoreService.deleteTask(task.id),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _addTask(context),
      ),
    );
  }

  void _addTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => TaskForm(
        onSubmit: (title, description) {
          _firestoreService.addTask(Task(id: '', title: title, description: description));
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void _editTask(BuildContext context, Task task) {
    
    showModalBottomSheet(
      context: context,
      builder: (context) => TaskForm(
        initialTitle: task.title,
        initialDescription: task.description,
        onSubmit: (title, description) {
          _firestoreService.updateTask(Task(id: task.id, title: title, description: description));
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
