import 'package:flutter/material.dart';
import 'package:to_do/domain/models/todo_model.dart';

class TodoCardWidget extends StatelessWidget {
  TodoCardWidget({
    super.key,
    required this.todo,
    required this.toggle,
    required this.remove,
  });
  final TodoModel todo;
  final void Function(int id, String title, bool completed) toggle;
  final void Function(int id) remove;
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _controller.text = todo.title;
    return Dismissible(
      key: Key(todo.id.toString()),
      onDismissed: (direction) => remove(todo.id),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                onSubmitted: (value) {
                  toggle(todo.id, _controller.text, todo.completed);
                },
                style:
                    todo.completed
                        ? TextStyle(decoration: TextDecoration.lineThrough)
                        : null,
                decoration: InputDecoration(
                  prefixIcon:
                      todo.completed
                          ? IconButton(
                            onPressed: () {
                              toggle(
                                todo.id,
                                _controller.text,
                                !todo.completed,
                              );
                            },
                            icon: Icon(Icons.check_circle_outline_outlined),
                          )
                          : IconButton(
                            onPressed: () {
                              toggle(
                                todo.id,
                                _controller.text,
                                !todo.completed,
                              );
                            },
                            icon: Icon(Icons.circle_outlined),
                          ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(style: BorderStyle.none, width: 0),
                  ),
                ),
                controller: _controller,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
