import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditEntity extends StatefulWidget {
  const EditEntity({Key? key}) : super(key: key);

  @override
  State<EditEntity> createState() => _EditEntityState();
}

class _EditEntityState extends State<EditEntity> {
  String? name;
  String? purpose;

  @override
  Widget build(BuildContext context) {
    //Styling App Structure
    return Scaffold(
        backgroundColor: Colors.grey[700],
        appBar: AppBar(
          title: const Text(
            'Create Entity',
            style: TextStyle(
              letterSpacing: 3.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'PermanentMarker-Regular',
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
                onChanged: (value) => setState(() => name = value),
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
                onChanged: (value) => setState(() => purpose = value),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: ElevatedButton(
                child: const Text('Create'),
                onPressed: () {},
              ),
            )
          ],
        ));
  }
}
