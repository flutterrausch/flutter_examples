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


class AsyncTodosNotifier extends AsyncNotifier<List<Todo>> {
  final List<Todo> _simulateBackend = exampleTodos;  // exampleTodos or [] empty list

  // initialize the list of todos
  @override
  Future<List<Todo>> build() async {
    return _fetchTodo();
  }

  // get whole list = all states
  // state-changes happen at the backend
  Future<List<Todo>> _fetchTodo() async {
    await Future.delayed(const Duration(seconds: 1)); // wait
    return _simulateBackend;
  }

  Future<void> addTodo(Todo todo) async {
    state = const AsyncValue.loading();  // Set the state to loading
    state = await AsyncValue.guard(() async {  // Add the new todo and reload the todo list from the remote repository
      _simulateBackend.add(todo);  // await BackendAdd()
      return _fetchTodo();
    });
  }

  Future<void> removeTodo(String todoId) async {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
      _simulateBackend.removeWhere((item) => item.id == todoId);  // await BackendRemove()
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

// provider to let UI interact with our notifier class
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
              onChanged: (_) => ref.read(asyncTodosProvider.notifier).toggle(todo.id),
              title: Text(todo.description),
            ),
        ],
      ),
      loading: () => const Center(child: CircularProgressIndicator(),),
      error: (err, stack) => Text('Error: $err'),
    );
  }
}

int addedCnt = 0;  // that's probably dirty :)

class TodoAsyncnotifierproviderPage extends ConsumerWidget {
  const TodoAsyncnotifierproviderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AsyncNotifierProvider (todo)'),
      ),
      body: Column(
        children: const [
          Expanded(
            child: TodoListView(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final cntId = 'added${addedCnt++}';
          ref.read(asyncTodosProvider.notifier).addTodo(Todo(id: cntId, description: cntId, completed: addedCnt.isEven));
          },
        child: const Icon(Icons.add),
      ),
    );
  }
}
