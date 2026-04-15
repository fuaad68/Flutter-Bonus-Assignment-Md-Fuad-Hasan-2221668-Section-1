import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final DateTime? createdAt;

  Task({
    required this.id,
    required this.title,
    required this.description,
    this.createdAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: (json['id'] ?? '') as String,
    title: (json['title'] ?? '') as String,
    description: (json['description'] ?? '') as String,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.tryParse(json['createdAt'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'createdAt': createdAt?.toIso8601String(),
  };

  factory Task.fromMap(Map<String, dynamic> map) => Task(
    id: (map['id'] ?? '') as String,
    title: (map['title'] ?? '') as String,
    description: (map['description'] ?? '') as String,
    createdAt: _parseCreatedAt(map['createdAt']),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'description': description,
    'createdAt': createdAt?.toIso8601String(),
  };

  factory Task.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? <String, dynamic>{};
    return Task.fromMap({
      ...data,
      'id': (data['id'] ?? doc.id),
    });
  }

  Task copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
  }) => Task(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    createdAt: createdAt ?? this.createdAt,
  );

  static DateTime? _parseCreatedAt(dynamic value) {
    if (value == null) return null;
    if (value is String) return DateTime.tryParse(value);
    if (value is Timestamp) return value.toDate();
    return null;
  }
}
