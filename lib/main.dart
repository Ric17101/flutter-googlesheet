import 'package:flutter/material.dart';
import 'package:googlesheets_feedback_flutter/screen/sheet_list_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter NoteJam',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SheetListPage(),
    );
  }
}
