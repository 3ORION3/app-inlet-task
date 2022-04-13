import 'dart:async';

import 'package:appinlet_task/entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  final String baseURL = "http://192.168.2.59:8000/api/entities";

  List<Entity>? entityList;

  @override
  void initState() {
    super.initState();
    getAllEntities();
  }

  Future getAllEntities() async {
    try {
      var response = await http.get(Uri.parse(baseURL));

      if (response.statusCode == 200) {
        var duration = const Duration(seconds: 2);
        Future.delayed(duration, (() {
          return Navigator.pushReplacementNamed(context, '/home', arguments: {
            'entities': jsonDecode(response.body),
          });
        }));
      } else {
        return Future.error("Server Error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[700],
        body: const Center(
          child: SpinKitRotatingCircle(
            color: Colors.white,
            size: 50.0,
          ),
        ));
  }
}
