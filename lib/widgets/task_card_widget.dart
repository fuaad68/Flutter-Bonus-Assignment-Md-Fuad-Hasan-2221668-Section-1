import 'package:flutter/material.dart';

class TaskCardWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData? icon;

  final VoidCallback? onDelete;

  const TaskCardWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          subtitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        leading: Icon(
          icon ?? Icons.task,
          color: Colors.deepPurple,
        ),
        trailing: IconButton(
          onPressed: onDelete,
          icon: const Icon(Icons.delete, color: Colors.redAccent),
          tooltip: 'Delete task',
        ),
      ),
    );
  }
}
