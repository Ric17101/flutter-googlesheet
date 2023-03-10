import 'package:gsheets/gsheets.dart';

/// WorkSheetItem is a data class which stores data fields of WorkSheet and row count.
class WorkSheetItem {
  Worksheet worksheet;
  int count;

  WorkSheetItem({
    required this.worksheet,
    required this.count,
  });
}
