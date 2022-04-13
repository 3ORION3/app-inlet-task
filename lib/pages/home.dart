import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String baseURL = "http://192.168.2.59:8000/api/entities";
  Map data = {};
  bool _editable = false;

  @override
  Widget build(BuildContext context) {
    //Converting and Storing Data From Server Into List
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)!.settings.arguments as Map;

    List list = List.castFrom(data['entities']);

    for (var item in list) {
      log("Name: " + item['name'].toString());
      log("Purpose: " + item['purpose'].toString() + "\n");
    }

    return Scaffold(
      //Styling App Structure
      backgroundColor: Colors.grey[700],
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 42.0,
            width: 42.0,
            child: FittedBox(
              //Edit Enabler Button
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _editable = !_editable;
                  });
                },
                child: const Icon(
                  Icons.edit,
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),

          //Create Button
          FloatingActionButton(
            onPressed: () async {
              await Navigator.pushNamed(context, '/create_entity',
                  arguments: {'label': 'Create'});
            },
            child: const Icon(
              Icons.add,
              color: Colors.black,
            ),
            backgroundColor: Colors.white,
          ),
        ],
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.account_circle_rounded,
            color: Colors.blue,
          ),
          onPressed: () {},
        ),
        title: const Text(
          'Random Entities',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 2.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'JosefinSans-VariableFont_wght',
            fontSize: 28.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 234, 196, 53),
        elevation: 0.0,
      ),

      //Dynamic List Viewing
      body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            final item = list[index];
            return Dismissible(
              key: Key(item['name']),
              background: Container(
                color: Colors.red,
                alignment: AlignmentDirectional.centerEnd,
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              onDismissed: (direction) {
                setState(() {
                  list.removeAt(index);
                  http.delete(Uri.parse("$baseURL/" + item['id'].toString()));
                });
              },

              //Confirming Deletion
              confirmDismiss: (DismissDirection direction) async {
                return await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Confirm Deletion"),
                      content: const Text(
                          "Are you sure you want to delete this entity?"),
                      actions: <Widget>[
                        TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text("Yes")),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text("No"),
                        ),
                      ],
                    );
                  },
                );
              },

              //Displaying Entities In CARD Format
              child: InkWell(
                onTap: () {},
                child: Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          list[index]['name'],
                          style: const TextStyle(fontSize: 30.0),
                        ),
                        subtitle: Text(
                          list[index]['purpose'],
                          style: const TextStyle(fontSize: 26.0),
                        ),
                      ),
                      Visibility(

                          //Edit Entity Button
                          visible: _editable,
                          child: IconButton(
                              onPressed: () async {
                                await Navigator.pushNamed(
                                    context, '/create_entity',
                                    arguments: {'label': 'Edit', 'item': item});
                              },
                              icon: const Icon(Icons.edit)))
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
