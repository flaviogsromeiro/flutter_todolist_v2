// ignore_for_file: unused_element

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_v2/entities/todo.dart';

import '../entities/storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.local});

  final Storage local;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _textController;
  Storage storage = Storage();
  List<Todo> listTodo = [];

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();

    widget.local.ler().then((value) {
      setState(() {
        if (value != null) {
          Map<String, dynamic> maps = json.decode(value);
          log('$maps');
          listTodo.addAll(Todos.fromJson(maps).toDosList!);
          log('$listTodo');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Lista de Tarefas'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(17, 1, 7, 1),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onSubmitted: (value) {},
                    controller: _textController,
                    decoration: const InputDecoration(
                        labelText: 'Nova Tarefa',
                        labelStyle: TextStyle(color: Colors.red)),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final novaTarefa = Todo(
                      tarefa: _textController.text,
                      check: false,
                    );

                    setState(() {
                      listTodo.add(novaTarefa);
                      storage.salvar(listTodo);
                    });
                  },
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.red)),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              itemCount: listTodo.length,
              itemBuilder: (context, index) => CheckboxListTile(
                title: Text(
                  listTodo[index].tarefa,
                  style: TextStyle(
                    fontSize: 20,
                    color: listTodo[index].check ? Colors.black26 : null,
                    decoration: listTodo[index].check
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                value: listTodo[index].check,
                secondary: CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Icon(
                      color: Colors.white,
                      listTodo[index].check ? Icons.check : Icons.error),
                ),
                onChanged: (bool? newValue) {
                  if (newValue != null) {
                    setState(() {
                      listTodo[index].setCheck(newValue);
                      storage.salvar(listTodo);
                    });
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Todo?> _read() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonTodo = prefs.getString("TEST_KEY");

    if (jsonTodo != null) {
      Map<String, dynamic> mapTodo = json.decode(jsonTodo);
      Todo todot = Todo.fromJson(mapTodo);
      return todot;
    }
    return null;
  }
}
