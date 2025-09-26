import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/todo.dart';
import '../viewmodels/todo_viewmodel.dart';
import '../viewmodels/auth_viewmodel.dart';

class TodoListItem extends StatelessWidget {
  final Todo todo;
  final bool isOwner;
  const TodoListItem({super.key, required this.todo, required this.isOwner});

  @override
  Widget build(BuildContext context) {
    final todoVM = Provider.of<TodoViewModel>(context, listen: false);
    final auth = Provider.of<AuthViewModel>(context, listen: false);

    return ListTile(
      title: Text(todo.title),
      leading: Checkbox(
        value: todo.completed,
        onChanged: (val) {
          todoVM.updateTodo(Todo(
            id: todo.id,
            title: todo.title,
            ownerId: todo.ownerId,
            sharedWith: todo.sharedWith,
            completed: val ?? false,
          ));
        },
      ),
      trailing: isOwner
    ? IconButton(
        icon: const Icon(Icons.share),
        onPressed: () async {
  final todoVM = Provider.of<TodoViewModel>(context, listen: false);
  final auth = Provider.of<AuthViewModel>(context, listen: false);
    final uid = auth.user?.uid;
  if (uid != null) {
    await todoVM.shareTodo(todo, uid);
    final url = 'https://todoapp.com/task/${todo.id}';
    final whatsappUrl = 'whatsapp://send?text=Check this task: $url';
    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(Uri.parse(whatsappUrl));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch WhatsApp')),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('User not authenticated')),
    );
  }
}
        // onPressed: () async {
        //   final email = await _showShareDialog(context);
        //   if (email != null && email.isNotEmpty) {
        //     final todoVM = Provider.of<TodoViewModel>(context, listen: false);
        //     final uid = await todoVM.getUidByEmail(email);
        //     if (uid != null) {
        //       await todoVM.shareTodo(todo, uid);
        //       final url = 'https://todoapp.com/task/${todo.id}';
        //       final whatsappUrl = 'whatsapp://send?text=Check this task: $url';
        //       if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
        //         await launchUrl(Uri.parse(whatsappUrl));
        //       } else {
        //         ScaffoldMessenger.of(context).showSnackBar(
        //           const SnackBar(content: Text('Could not launch WhatsApp')),
        //         );
        //       }
        //     } else {
        //       ScaffoldMessenger.of(context).showSnackBar(
        //         const SnackBar(content: Text('User not found')),
        //       );
        //     }
        //   }
        // },

        
      
      )
    : null,
    );
  }

  
  Future<String?> _showShareDialog(BuildContext context) async {
  final controller = TextEditingController();
  return showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Share with Email'),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(hintText: 'Enter user email'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, controller.text),
          child: const Text('Share'),
        ),
      ],
    ),
  );
}
}