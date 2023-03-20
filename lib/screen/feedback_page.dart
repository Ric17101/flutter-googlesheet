import 'package:flutter/material.dart';
import 'package:googlesheets_feedback_flutter/controller.dart';
import 'package:googlesheets_feedback_flutter/model/feedback_form.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({this.form, super.key});

  final FeedbackForm? form;

  @override
  FeedbackPageState createState() => FeedbackPageState();
}

class FeedbackPageState extends State<FeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();

  // void _submitForm() {
  //   SheetController formController = SheetController();
  //
  //   _showSnackbar("Submitting Feedback");
  //
  //   // Submit 'feedbackForm' and save it in Google Sheets.
  //   formController.getSheet();
  // }

  // Method to Submit Feedback and save it in Google Sheets
  void _submitForm() {
    if (_formKey.currentState?.validate() != true) {
      _showSnackbar("Error Occurred!");
      return;
    }
    // If the form is valid, proceed.
    FeedbackForm feedbackForm = FeedbackForm(
      "1", // TODO: should increment based on the last ID column
      nameController.text,
      emailController.text,
      mobileNoController.text,
      feedbackController.text,
    );

    SheetController formController = SheetController();

    _showSnackbar("Submitting Feedback");

    formController.submitFeedbackForm(
      feedbackForm: feedbackForm,
      onResult: (String response) {
        print("Response: $response");
        // if (response == STATUS_SUCCESS) {
        //   // Feedback is saved succesfully in Google Sheets.
        //   _showSnackbar("Feedback Submitted");
        // } else {
        //   // Error Occurred while saving data in Google Sheets.
        //   _showSnackbar("Error Occurred!");
        // }
      },
    );
  }

  // Method to show snackbar with 'message'.
  _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    if (widget.form == null) return;

    nameController.text = widget.form?.name ?? '';
    emailController.text = widget.form?.email ?? '';
    mobileNoController.text = widget.form?.mobileNumber ?? '';
    feedbackController.text = widget.form?.feedback ?? '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text(widget.form?.name ?? 'Add new feedback')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value?.isEmpty == true) {
                          return 'Enter Valid Name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: 'Name'),
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value?.contains("@") == false) {
                          return 'Enter Valid Email';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
                    TextFormField(
                      controller: mobileNoController,
                      validator: (value) {
                        if ((value?.trim().length ?? 0) < 5) {
                          return 'Enter 10 Digit Mobile Number';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Mobile Number',
                      ),
                    ),
                    TextFormField(
                      controller: feedbackController,
                      validator: (value) {
                        if (value?.isEmpty == true) {
                          return 'Enter Valid Feedback';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(labelText: 'Feedback'),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Submit Feedback'),
            ),
          ],
        ),
      ),
    );
  }
}
