import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:todo_v2/entities/todo.dart';

class Storage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/file.json');
  }

  Future<File> salvar(List<Todo> todos) async {
    final Todos toDos = Todos();
    toDos.toDosList = [];

    toDos.toDosList!.addAll(todos);

    String data = json.encode(toDos.toJson());

    log(data);

    final file = await _localFile;
    return file.writeAsString(data);
  }

  Future<String?> ler() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();

      log(contents);

      return contents;
    } catch (e) {
      return null;
    }
  }
}
