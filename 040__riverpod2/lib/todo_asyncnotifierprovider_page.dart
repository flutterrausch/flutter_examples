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


class AsyncTodosNotifier extends AsyncNotifier<List<Todo>> {
  final List<Todo> _simulateBackend = exampleTodos;

  // initialize the list of todos
  @override
  Future<List<Todo>> build() async {
    return _fetchTodo();
  }

  // get whole list = all states, all state-manipulations happen at the backend
  Future<List<Todo>> _fetchTodo() async {
    await Future.delayed(const Duration(seconds: 1)); // wait
    return _simulateBackend;  // exampleTodos or [] empty list
  }

  Future<void> addTodo(Todo todo) async {
    // Set the state to loading
    state = const AsyncValue.loading();
    // Add the new todo and reload the todo list from the remote repository
    state = await AsyncValue.guard(() async {
      // await BackendAdd()
      _simulateBackend.add(const Todo(id: 'foo', description: 'added', completed: true));
      return _fetchTodo();
    });
  }

  Future<void> removeTodo(String todoId) async {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
      // await BackendAdd()
      _simulateBackend.removeWhere((item) => item.id == todoId);
      return _fetchTodo();
      });
    }

  // Mark todo as completed
  Future<void> toggle(String todoId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final index = _simulateBackend.indexWhere((item) => item.id == todoId);
      final cmpltd = _simulateBackend[index].completed;
      //debugPrint('($index) = $cmpltd -> ${!cmpltd}');
      _simulateBackend[index] = _simulateBackend[index].copyWith(completed: !cmpltd);
      return _fetchTodo();
    });
  }
}

// StateNotifierProvider to let UI interact with our TodosNotifier class
final asyncTodosProvider = AsyncNotifierProvider<AsyncTodosNotifier, List<Todo>>(() {
  return AsyncTodosNotifier();
});


class TodoListView extends ConsumerWidget {
  const TodoListView({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {  // ref arg!
    final AsyncValue<List<Todo>> asyncTodos = ref.watch(asyncTodosProvider);  // rebuild the widget when the todo list changes

    // Render the todos in a scrollable list view
    return asyncTodos.when(
      data: (todos) => ListView(
        children: [
          for (final todo in todos)
            CheckboxListTile(
              value: todo.completed,
              // When tapping on the todo, change its completed status
              onChanged: (value) =>
                  ref.read(asyncTodosProvider.notifier).toggle(todo.id),
              title: Text(todo.description),
            ),
        ],
      ),
      loading: () => const Center(child: CircularProgressIndicator(),),
      error: (err, stack) => Text('Error: $err'),
    );
  }
}


class TodoAsyncnotifierproviderPage extends ConsumerWidget {
  const TodoAsyncnotifierproviderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
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
