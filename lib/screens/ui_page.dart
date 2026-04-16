import 'package:flutter/material.dart';
import 'package:flutter_ui_class/models/task_model.dart';
import 'package:flutter_ui_class/repositories/task_repository.dart';
import 'package:flutter_ui_class/screens/add_task_page.dart';
import 'package:flutter_ui_class/widgets/task_card_widget.dart';

class RefreshController {
  bool _isRefreshing = false;
  final bool initialRefresh;
  RefreshController({this.initialRefresh = false});
  bool get isRefreshing => _isRefreshing;
  set isRefreshing(bool value) => _isRefreshing = value;
}

class UiPage extends StatefulWidget {
  const UiPage({super.key});

  @override
  State<UiPage> createState() => _UiPageState();
}

class _UiPageState extends State<UiPage> {
  final TaskRepository _taskRepository = TaskRepository();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  Future<void> _deleteTask(String taskId) async {
    try {
      await _taskRepository.deleteTask(taskId);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✓ Task deleted successfully'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('✗ Failed to delete task: ${e.toString()}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks"),
        backgroundColor: Colors.purpleAccent,
      ),

      body: StreamBuilder<List<Task>>(
        stream: _taskRepository.watchTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong while loading tasks.'),
            );
          }

          final tasks = snapshot.data ?? [];

          if (tasks.isEmpty) {
            return const Center(
              child: Text('No tasks yet. Tap + to add your first task.'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];

              return TaskCardWidget(
                title: task.title,
                subtitle: task.description,
                onDelete: () => _deleteTask(task.id),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddTaskPage()),
          );
        },
        backgroundColor: Colors.purpleAccent,
        child: const Icon(Icons.add),
      ),
    );
  }
}
