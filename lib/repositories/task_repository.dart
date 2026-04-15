import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ui_class/models/task_model.dart';

class TaskRepository {
  TaskRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _tasksCollection =>
      _firestore.collection('tasks');

  Future<void> addTask(Task task) async {
    final docRef = _tasksCollection.doc();
    final payload = task
        .copyWith(
          id: docRef.id,
          createdAt: task.createdAt ?? DateTime.now(),
        )
        .toMap();

    await docRef.set(payload);
  }

  Future<void> deleteTask(String taskId) async {
    await _tasksCollection.doc(taskId).delete();
  }

  Stream<List<Task>> watchTasks() {
    return _tasksCollection.snapshots().map((snapshot) {
      final tasks = snapshot.docs.map(Task.fromDocument).toList();

      tasks.sort((a, b) {
        final aTime = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        final bTime = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        return bTime.compareTo(aTime);
      });

      return tasks;
    });
  }
}
