// ignore_for_file: public_member_api_docs, sort_constructors_first

class Todo {
  String _tarefa;
  bool _check;

  String get tarefa => _tarefa;
  void setTarefa(String value) => _tarefa = value;

  bool get check => _check;
  void setCheck(bool value) => _check = value;

  Todo({
    required String tarefa,
    required bool check,
  })  : _tarefa = tarefa,
        _check = false;

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      tarefa: json['tarefa'],
      check: json['check'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tarefa': _tarefa,
      'check': _check,
    };
  }

  @override
  String toString() => 'Todo(_tarefa: $_tarefa, _check: $_check)';
}

class Todos {
  // ignore: todo
  List<Todo>? toDosList; // CRIAÇÃO DA LISTA DO TIPO TODO;
  Todos({
    // CONSTRUCTOR
    this.toDosList,
  });

  factory Todos.fromJson(Map<String, dynamic> json) {
    Todos result = Todos();
    result.toDosList = [];
    if (json['toDos'] != null) {
      json['toDos'].forEach((v) {
        result.toDosList!.add(Todo.fromJson(v));
      });
    }

    return result;
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> toDos = [];
    if (toDosList != null) {
      toDos = toDosList!.map((toDo) => toDo.toJson()).toList();
    }
    return {'toDos': toDos};
  }
}
