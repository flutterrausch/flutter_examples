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

// final exampleTodos = [
//   const Todo(id: '1', description: 'Learn Flutter', completed: true),
//   const Todo(id: '2', description: 'Build a todo app', completed: false),
//   const Todo(id: '3', description: 'Deploy app to the app store', completed: false),
// ];

class TodosNotifier extends StateNotifier<List<Todo>> {
  TodosNotifier(): super([]); // Initialize with an empty list

  void addTodo(Todo todo) {
    state = [...state, todo];
  }

  void removeTodo(String todoId) {
    state = [
      for (final todo in state)
        if (todo.id != todoId) todo,
    ];
  }

  // Mark as completed
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



Future<List<Todo>> fetchTodosFromAsyncDataSource() async {
  await Future.delayed(const Duration(seconds: 3)); // Wait for 3 seconds
  return [
    const Todo(id: '1', description: 'Learn Flutter', completed: true),
    const Todo(id: '2', description: 'Build a todo app', completed: false),
    const Todo(id: '3', description: 'Deploy app to the app store', completed: false),
    const Todo(id: '4', description: 'This comes from async data src', completed: true),
  ];
}


final todosProvider = StateNotifierProvider<TodosNotifier, List<Todo>>((ref) {
  return TodosNotifier();
});

final todosAsyncProvider = FutureProvider<List<Todo>>((ref) async {
  return await fetchTodosFromAsyncDataSource();
});

class TodoListView extends ConsumerWidget {
  const TodoListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Todo>> todosAsyncValue = ref.watch(todosAsyncProvider);
        //List<Todo> todos = ref.watch(todosProvider);  // rebuild the widget when the todo list changes

    return todosAsyncValue.when(
      data: (List<Todo> todos) {

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
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Text('Error: $error'),
    );
  }
}


class TodoAsyncInitPage extends ConsumerWidget {
  const TodoAsyncInitPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo async init StateNotifierProvider (bug!)'),
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
