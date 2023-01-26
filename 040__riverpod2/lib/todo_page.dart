import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


@immutable
class Todo {
  final String id;
  final String description;
  final bool completed;

  const Todo({required this.id, required this.description, required this.completed});

  Todo copyWith({String? id, String? description, bool? completed}) {
    return Todo(
      id: id ?? this.id,
      description: description ?? this.description,
      completed: completed ?? this.completed,
    );
  }
}

final exampleTodos = [
  const Todo(id: '1', description: 'Learn Flutter', completed: true),
  const Todo(id: '2', description: 'Build a todo app', completed: false),
  const Todo(id: '3', description: 'Deploy app to the app store', completed: false),
];

class TodosNotifier extends StateNotifier<List<Todo>> {
  TodosNotifier(): super(exampleTodos);  // or [] empty list

  void addTodo(Todo todo) {
    // our state is @immutable, thus not allowed to state.add(todo)
    // -> create new list of old items + 1 new
    // spread operator 
    state = [...state, todo];
  }

  void removeTodo(String todoId) {
    // new list excluding 1 item
    state = [
      for (final todo in state)
        if (todo.id != todoId) todo,
    ];
  }

  // Mark as completed
  void toggle(String todoId) {
    state = [
      for (final todo in state)
      // we're marking only the matching todo as completed
        if (todo.id == todoId)
          todo.copyWith(completed: !todo.completed)
        else
          todo,
    ];
  }
}

// StateNotifierProvider to let UI interact with our TodosNotifier class
final todosProvider = StateNotifierProvider<TodosNotifier, List<Todo>>((ref) {
  return TodosNotifier();
});


class TodoListView extends ConsumerWidget {
  const TodoListView({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(todosProvider);  // rebuild the widget when the todo list changes

    // Let's render the todos in a scrollable list view
    return ListView(
      children: [
        for (final todo in todos)
          CheckboxListTile(
            value: todo.completed,
            // change complete state on tap
            onChanged: (value) => ref.read(todosProvider.notifier).toggle(todo.id),
            title: Text(todo.description),
          ),
      ],
    );
  }
}


class TodoPage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final apiFuture = ref.watch(authFutureProvider);  // instance

    return Scaffold(
      appBar: AppBar(
        title: const Text('Future provider page'),
      ),
      body: Center(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: 500,
                  child: TodoListView(),
                ),
              ],
            ),
          ),
        ),
      );
  }
}