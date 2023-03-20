import 'package:flutter/material.dart';
import 'package:googlesheets_feedback_flutter/controller.dart';
import 'package:googlesheets_feedback_flutter/model/feedback_form.dart';
import 'package:googlesheets_feedback_flutter/screen/feedback_page.dart';

class RowListPage extends StatefulWidget {
  const RowListPage({super.key, required this.title});

  final String title;

  @override
  RowListState createState() => RowListState();
}

class RowListState extends State<RowListPage> {
  List<FeedbackForm> feedbackForms = [];

  void _navigateFeedbackPage(FeedbackForm? form) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) => FeedbackPage(form: form)),
    );
  }

  @override
  void initState() {
    super.initState();

    SheetController().getFeedbackSheetBy(title: widget.title).then((feedbackForms) {
      setState(() {
        this.feedbackForms = feedbackForms;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: add button
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateFeedbackPage(null),
        tooltip: 'Capture Picture',
        elevation: 0.0,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 29.0,
        ),
      ),
      body: ListView.builder(
        itemCount: feedbackForms.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () => _navigateFeedbackPage(feedbackForms[index]),
            title: Row(
              children: <Widget>[
                const Icon(Icons.person),
                Expanded(
                  child: Text("${feedbackForms[index].name} (${feedbackForms[index].email})"),
                )
              ],
            ),
            subtitle: Row(
              children: <Widget>[
                const Icon(Icons.message),
                Expanded(
                  child: Text(feedbackForms[index].feedback),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
