import 'package:intl/intl.dart';

class AppUtils {
  static String formattedDate =
      DateFormat.yMMMMd('en_US').format(DateTime.now());
}
