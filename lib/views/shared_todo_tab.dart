import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../viewmodels/todo_viewmodel.dart';
import '../widgets/todo_list_item.dart';

class SharedTodoTab extends StatelessWidget {
  const SharedTodoTab({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthViewModel>(context, listen: false);
    final todoVM = Provider.of<TodoViewModel>(context, listen: false);

    return StreamBuilder(
      stream: todoVM.getSharedTodosStream(auth.user!.uid),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final todos = snapshot.data!;
        return ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, i) => TodoListItem(todo: todos[i], isOwner: false),
        );
      },
    );
  }
}