import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateEntity extends StatefulWidget {
  const CreateEntity({Key? key}) : super(key: key);

  @override
  State<CreateEntity> createState() => _CreateEntityState();
}

class _CreateEntityState extends State<CreateEntity> {
  final String baseURL = "http://192.168.2.59:8000/api/entities";
  String name = "";
  String purpose = "";
  int? id;
  Map data = {};

  String label = "Create";

  //RESTful Methods
  void addData() async {
    await http.post(Uri.parse(baseURL), body: {
      'name': name,
      'purpose': purpose,
    });
  }

  void updateData() async {
    await http.put(Uri.parse("$baseURL/$id"), body: {
      'name': name,
      'purpose': purpose,
    });
  }

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)!.settings.arguments as Map;

    label = data['label'];

    if (data['item'] != null) {
      name = data['item']['name'];
      purpose = data['item']['purpose'];
      id = data['item']['id'];
    }

    //Styling App Structure
    return Scaffold(
        backgroundColor: Colors.grey[700],
        appBar: AppBar(
          title: Text(
            "$label Entity",
            style: const TextStyle(
              letterSpacing: 3.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'JosefinSans-VariableFont_wght',
              fontSize: 28.0,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 234, 196, 53),
        ),

        //Form
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Name an entity',
                    labelStyle: const TextStyle(color: Colors.white),
                    hintStyle:
                        TextStyle(color: Colors.grey[400], fontSize: 20.0)),
                style: const TextStyle(color: Colors.white),
                onChanged: (value) => name = value,
                controller: TextEditingController(
                  text: name,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  labelText: "What's its purpose?",
                  labelStyle:
                      TextStyle(color: Colors.grey[400], fontSize: 18.0),
                ),
                onChanged: (value) => purpose = value,
                controller: TextEditingController(
                  text: purpose,
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: ElevatedButton(
                child: Text(label),
                onPressed: () {
                  if (label == "Create") {
                    addData();
                  } else if (label == "Edit") {
                    updateData();
                  }

                  Navigator.popAndPushNamed(context, '/');
                },
              ),
            )
          ],
        ));
  }
}
