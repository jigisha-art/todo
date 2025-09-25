import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  final String id;
  final String title;
  final String ownerId;
  final List<String> sharedWith;
  final bool completed;

  Todo({
    required this.id,
    required this.title,
    required this.ownerId,
    required this.sharedWith,
    required this.completed,
  });

  factory Todo.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Todo(
      id: doc.id,
      title: data['title'] ?? '',
      ownerId: data['ownerId'] ?? '',
      sharedWith: List<String>.from(data['sharedWith'] ?? []),
      completed: data['completed'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'ownerId': ownerId,
      'sharedWith': sharedWith,
      'completed': completed,
    };
  }
}