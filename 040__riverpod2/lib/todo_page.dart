import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// The purpose of StateNotifier is to be a simple solution to control state in an immutable manner.
// While ChangeNotifier is simple, through its mutable nature, it can be harder to maintain as it grows larger.
// Centralize all the logic that modifies a StateNotifier within the StateNotifier itself (outside is an anti-pattern)
// LEARN: StateNotifier does not demand @immutable (compiles/runs)

// Once an instance of the class is created, properties of that instance cannot be modified.
// if you want to changes, you need to create a new Todo object with the updated properties.
// the original list remains unmodified, and any further modifications are made on a new list.
// It ensures state not accidentally modified  [well, we modify by copying..]
// By using immutable state, it becomes a lot simpler to:
//   compare previous and new state
//   implement undo-redo mechanism
//   debug the application state
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
    // state is a property of StateNotifier, and is immutable (StateNotifier on @immutable Todo),
    // thus not allowed to state.add(todo) -> create new list of old items + 1 new
    state = [...state, todo];  // array spread operator - use existing state array, and then some
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