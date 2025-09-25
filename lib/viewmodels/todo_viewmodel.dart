import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/todo.dart';

class TodoViewModel extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<Todo> myTodos = [];
  List<Todo> sharedTodos = [];
  bool isLoading = false;



  Future<String?> getUidByEmail(String email) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();
    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.id;
    }
    return null;
  }


  Stream<List<Todo>> getMyTodosStream(String userId) {
    return _db.collection('todos')
      .where('ownerId', isEqualTo: userId)
      .snapshots()
      .map((snap) => snap.docs.map((doc) => Todo.fromDoc(doc)).toList());
  }

  Stream<List<Todo>> getSharedTodosStream(String userId) {
    return _db.collection('todos')
      .where('sharedWith', arrayContains: userId)
      .snapshots()
      .map((snap) => snap.docs.map((doc) => Todo.fromDoc(doc)).toList());
  }
  

  Future<void> addTodo(String title, String ownerId) async {
    await _db.collection('todos').add({
      'title': title,
      'ownerId': ownerId,
      'sharedWith': [],
      'completed': false,
    });
  }

  Future<void> updateTodo(Todo todo) async {
    await _db.collection('todos').doc(todo.id).update(todo.toMap());
  }

  Future<void> shareTodo(Todo todo, String shareWithUserId) async {
    final updatedSharedWith = List<String>.from(todo.sharedWith)..add(shareWithUserId);
    await _db.collection('todos').doc(todo.id).update({'sharedWith': updatedSharedWith});
  }
}