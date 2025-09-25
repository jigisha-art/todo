import 'package:flutter/material.dart';

class TodoInputField extends StatelessWidget {
  final Function(String) onSubmitted;
  const TodoInputField({super.key, required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Enter new task',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                onSubmitted(value);
                controller.clear();
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              onSubmitted(controller.text);
              controller.clear();
            },
          ),
        ],
      ),
    );
  }
}