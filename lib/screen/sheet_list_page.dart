import 'package:flutter/material.dart';
import 'package:googlesheets_feedback_flutter/controller.dart';
import 'package:googlesheets_feedback_flutter/model/work_sheet_item.dart';
import 'package:googlesheets_feedback_flutter/screen/row_list_page.dart';

class SheetListPage extends StatelessWidget {
  const SheetListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Sheets',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SheetList(title: "Sheets"),
    );
  }
}

class SheetList extends StatefulWidget {
  const SheetList({super.key, required this.title});

  final String title;

  @override
  SheetListState createState() => SheetListState();
}

class SheetListState extends State<SheetList> {
  List<WorkSheetItem> workSheets = [];

  // Method to Submit Feedback and save it in Google Sheets

  @override
  void initState() {
    super.initState();
    SheetController().getSheets().then((workSheets) {
      setState(() {
        this.workSheets = workSheets;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView.builder(
        itemCount: workSheets.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => RowListPage(title: workSheets[index].worksheet.title),
                ),
              );
            },
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
