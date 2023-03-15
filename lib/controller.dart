import 'package:googlesheets_feedback_flutter/credentials.dart';
import 'package:googlesheets_feedback_flutter/model/feedback_form.dart';
import 'package:googlesheets_feedback_flutter/model/work_sheet_item.dart';
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
const _worksheetFeedbackId = 'Feedback';

/// SheetController is a class which does work of saving FeedbackForm in Google Sheets using
/// HTTP GET request on Google App Script Web URL and parses response and sends result callback.
@Deprecated("Should use AppScript to do API requests instead")
class SheetController {
  Future<List<WorkSheetItem>> getSheets() async {
    // init GSheets
    final gsheets = GSheets(credentials);
    // fetch spreadsheet by its id
    final ss = await gsheets.spreadsheet(spreadsheetId);

    return await Future.wait(ss.sheets.map((e) async {
      // can be counter to get the total number of rows occupied
      final rows = await e.cells.allRows();
      return WorkSheetItem(worksheet: e, count: rows.length - 1);
    }));
  }

  Future<List<FeedbackForm>> getFeedbackSheetBy({String title = _worksheetFeedbackId}) async {
    // init GSheets
    final gsheets = GSheets(credentials);
    // fetch spreadsheet by its id
    final ss = await gsheets.spreadsheet(spreadsheetId);

    var sheet = ss.worksheetByTitle(title);

    final rows = await sheet?.cells.allRows();

    return rows
            ?.skip(1)
            .map(
              (e) => FeedbackForm(
                e[0].value,
                e[1].value,
                e[2].value,
                e[3].value,
                e[4].value,
              ),
            )
            .toList() ??
        List.empty();
  }

  void getFeedbackSheetRowBy({String title = _worksheetFeedbackId}) async {
    // init GSheets
    final gsheets = GSheets(credentials);
    // fetch spreadsheet by its id
    final ss = await gsheets.spreadsheet(spreadsheetId);

    var sheet = ss.worksheetByTitle(title);
    final rows = await sheet?.cells.allRows();
    print('${rows?.length ?? 0}');
  }

  // TODO: add submission for new and old entry
  void submitFeedbackForm({required FeedbackForm feedbackForm, required Function(String) onResult}) async {
    // init GSheets
    final gsheets = GSheets(credentials);
    // fetch spreadsheet by its id
    final ss = await gsheets.spreadsheet(spreadsheetId);

    var sheet = ss.worksheetByTitle(_worksheetFeedbackId);
    final newFeedback = [
      feedbackForm.id,
      feedbackForm.name,
      feedbackForm.email,
      feedbackForm.mobileNumber,
      feedbackForm.feedback,
    ];
    await sheet?.values.appendRow(newFeedback);
  }

  // TEST only
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
    await sheet?.values.insertRowByKey('1002', secondColumn);

    // Insert new row
    // await sheet?.values.appendRow(secondColumn);
    // await sheet?.values.appendRow(secondColumnNum);
  }
}
