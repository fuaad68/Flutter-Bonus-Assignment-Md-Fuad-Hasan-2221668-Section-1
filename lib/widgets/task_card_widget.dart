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
      elevation: 1,
      child: ListTile(
        title: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        leading: icon != null ? Icon(icon) : Icon(Icons.task),
        trailing: IconButton(
          onPressed: onDelete,
          icon: const Icon(Icons.delete, color: Colors.redAccent),
        ),
      ),
    );
  }
}
