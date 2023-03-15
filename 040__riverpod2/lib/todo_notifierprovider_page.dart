import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// see TodoStatenotifierproviderPage for more explanations
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


class TodosNotifier extends Notifier<List<Todo>> {

  @override
  List<Todo> build() {  // initialize the list of todos
    return exampleTodos;  // exampleTodos or [] empty list
  }

  void addTodo(Todo todo) {
    state = [...state, todo];  // array spread operator - use existing state array, and then some
  }

  void removeTodo(String todoId) {
    // new list excluding 1 item
    state = [
      for (final todo in state)
        if (todo.id != todoId) todo,
    ];
  }

  // Mark todo as completed
  void toggle(String todoId) {
    state = [
      for (final todo in state)
        if (todo.id == todoId)  // mark only the matching todo as completed
          todo.copyWith(completed: !todo.completed)
        else
          todo,
    ];
  }
}

// provider to let UI interact with our notifier class
final todosProvider = NotifierProvider<TodosNotifier, List<Todo>>(() {
  return TodosNotifier();
});


class TodoListView extends ConsumerWidget {
  const TodoListView({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {  // ref arg!
    List<Todo> todos = ref.watch(todosProvider);  // rebuild the widget when the todo list changes

    // Render the todos in a scrollable list view
    return ListView(
      children: [
        for (final todo in todos)
          CheckboxListTile(
            title: Text(todo.description),
            value: todo.completed,
            onChanged: (value) => ref.read(todosProvider.notifier).toggle(todo.id),  // change complete state on tap
          ),
      ],
    );
  }
}


class TodoNotifierproviderPage extends ConsumerWidget {
  const TodoNotifierproviderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {  // ref not used, StatelessWidget would suffice
    return Scaffold(
      appBar: AppBar(
        title: const Text('NotifierProvider (todo)'),
      ),
      body: Column(
        children: const [
          Expanded(
            child: TodoListView(),
          ),
        ],
      )
    );
  }
}
