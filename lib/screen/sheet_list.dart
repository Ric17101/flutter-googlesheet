import 'package:flutter/material.dart';
import 'package:googlesheets_feedback_flutter/controller.dart';
import 'package:googlesheets_feedback_flutter/model/work_sheet_item.dart';
import 'package:gsheets/gsheets.dart';

class SheetListScreen extends StatelessWidget {
  const SheetListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Sheets',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SheetListPage(title: "Sheets"),
    );
  }
}

class SheetListPage extends StatefulWidget {
  const SheetListPage({super.key, required this.title});

  final String title;

  @override
  SheetListPageState createState() => SheetListPageState();
}

class SheetListPageState extends State<SheetListPage> {
  List<WorkSheetItem> workSheets = [];

  // Method to Submit Feedback and save it in Google Sheets

  @override
  void initState() {
    super.initState();

    SheetController().getFeedbackSheetBy();
    SheetController().getSheets().then((workSheets) {
      setState(() {
        this.workSheets = workSheets;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: workSheets.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Row(
              children: <Widget>[
                const Icon(Icons.person),
                Expanded(
                  child: Text("${workSheets[index].worksheet.title} (${workSheets[index].count})"),
                )
              ],
            ),
            subtitle: Row(
              children: <Widget>[
                const Icon(Icons.message),
                Expanded(
                  child: Text('${workSheets[index].worksheet.id}'),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
