import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class Todo {
  String id;
  String description;
  bool completed;

  Todo({required this.id, required this.description, required this.completed});
}

final exampleTodos = [
  Todo(id: '1', description: 'Learn Flutter', completed: true),
  Todo(id: '2', description: 'Build a todo app', completed: false),
  Todo(id: '3', description: 'Deploy app to the app store', completed: false),
];

class TodosNotifier extends ChangeNotifier {
  final todos = exampleTodos;  // <Todo>[]  or  exampleTodos
  

  void addTodo(Todo todo) {
    todos.add(todo);
    notifyListeners();  // always trigger any UI update manually
  }

  void removeTodo(String todoId) {
    todos.remove(todos.firstWhere((element) => element.id == todoId));
    notifyListeners();
  }

  // Mark as completed
  void toggle(String todoId) {
    for (final todo in todos) {
      if (todo.id == todoId) {
        todo.completed = !todo.completed;
        notifyListeners();
      }
    }
  }
}

// let UI interact with our TodosNotifier class
final todosProvider = ChangeNotifierProvider<TodosNotifier>((ref) {
  return TodosNotifier();
});


class TodoListView extends ConsumerWidget {
  const TodoListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {  // ref arg!
    List<Todo> todos = ref.watch(todosProvider).todos;  // weird syntax!

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


// why ConsumerWidget? StatelessWidget works
// probably because WidgetRef (unused here)
class TodoChangenotifierproviderPage extends ConsumerWidget {
  const TodoChangenotifierproviderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChangeNotifierProvider (todo)'),
      ),
      body: const Column(
        children: [
          Expanded(
            child: TodoListView(),
          ),
        ],
      )
    );
  }
}
