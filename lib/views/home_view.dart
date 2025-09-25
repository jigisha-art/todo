import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';
import 'my_todo_tab.dart';
import 'shared_todo_tab.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthViewModel>(context, listen: false);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Realtime TODO'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => auth.signOut(),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'MyTodo'),
              Tab(text: 'Shared Todo'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            MyTodoTab(),
            SharedTodoTab(),
          ],
        ),
      ),
    );
  }
}