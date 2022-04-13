import 'package:appinlet_task/pages/create_entity.dart';
import 'package:appinlet_task/pages/home.dart';
import 'package:appinlet_task/pages/loading.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'AppInlet Task',
      initialRoute: '/',
      routes: {
        '/': (context) => const Loading(),
        '/home': (context) => const MyApp(),
        '/create_entity': (context) => const CreateEntity(),
      },
    ),
  );
}
