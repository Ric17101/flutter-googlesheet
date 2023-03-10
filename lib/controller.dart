import 'package:googlesheets_feedback_flutter/credentials/credentials.dart';
import 'package:googlesheets_feedback_flutter/model/feedback_form.dart';
import 'package:dio/dio.dart';
import 'package:gsheets/gsheets.dart';

// your google auth credentials
const _credentials = r'''
{
  "type": "service_account",
  "project_id": "",
  "private_key_id": "",
  "private_key": "",
  "client_email": "",
  "client_id": "",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": ""
}
''';

// your spreadsheet id
const _spreadsheetId = '';

/// SheetController is a class which does work of saving FeedbackForm in Google Sheets using
/// HTTP GET request on Google App Script Web URL and parses response and sends result callback.
class SheetController {
  Future<List<Worksheet>> getSheets() async {
    // init GSheets
    final gsheets = GSheets(credentials);
    // fetch spreadsheet by its id
    final ss = await gsheets.spreadsheet(spreadsheetId);

    return ss.sheets;
  }

  // TEST
  void getSheet() async {
    // init GSheets
    final gsheets = GSheets(credentials);
    // fetch spreadsheet by its id
    final ss = await gsheets.spreadsheet(spreadsheetId);

    var sheet = ss.worksheetByTitle('Sheet1');
    print(await sheet?.values.value(column: 1, row: 2));
    print(ss.data.namedRanges.byName.values);
    // print(ss.data.dataSources);
    // update cell at 'B2' by inserting string 'new'

    final last = await sheet?.values.map.lastRow();
    print(last);
    print(last?.values.first); // Get ID of last row
    print(await sheet?.columnCount);

    print(await sheet?.values.columnByKey('Feedback'));
    // await sheet?.values.insertValue('new', column: 2, row: 3);

    final secondColumn = ['a', 'b', 'c', 'd', 'e'];
    final secondColumnNum = ['1', '2', '3', 'd', 'e'];
    // await sheet?.values.insertColumnByKey('letter', secondColumn);

    // Update by ROW based on key

    await sheet?.values.insertRowByKey('name2', secondColumnNum);
    await sheet?.values.insertRowByKey('1001', secondColumn);

    // Insert new row
    // await sheet?.values.appendRow(secondColumn);
    // await sheet?.values.appendRow(secondColumnNum);
  }

  /// Async function which saves feedback, parses [feedbackForm] parameters
  /// and sends HTTP GET request on [URL]. On successful response, [callback] is called.
  void submitForm(FeedbackForm feedbackForm, void Function(String) callback) async {
    try {
      final dio = Dio()..options.baseUrl = 'URL';

      final baseUri = Uri.parse('URL');
      final uri = baseUri.replace(queryParameters: feedbackForm.toJson(), path: '/${baseUri.path}');

      await dio.getUri(uri).then((response) async {
        print('Response: $response');
        print('Responses: ${response.statusCode}');
        print('Responses: ${response.data}');
        if (response.statusCode != 200) {
          // if (response.statusCode == 302) {
          var url = response.headers['location'] ?? '';
          // await http.get(Uri.parse(url)).then((response) {
          //   callback(convert.jsonDecode(response.body)['status']);
          // });
        } else {
          callback(response.statusCode.toString());
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
