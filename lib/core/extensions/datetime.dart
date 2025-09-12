import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  /// Format date as "dd/MM/yyyy"
  String get toDateString => DateFormat('dd/MM/yyyy').format(this);

  /// Format date as "dd MMM yyyy" (e.g., "01 Jan 2023")
  String get toDateStringShort => DateFormat('dd MMM yyyy').format(this);

  /// Format date as "MMMM dd, yyyy" (e.g., "January 01, 2023")
  String get toDateStringLong => DateFormat('MMMM dd, yyyy').format(this);

  /// Format time as "HH:mm" (24-hour format)
  String get toTimeString => DateFormat('HH:mm').format(this);

  /// Format time as "h:mm a" (12-hour format with AM/PM)
  String get toTimeString12h => DateFormat('h:mm a').format(this);

  /// Format as "dd/MM/yyyy HH:mm"
  String get toDateTimeString => DateFormat('dd/MM/yyyy HH:mm').format(this);

  /// Format as ISO 8601 string
  String get toIsoString => toIso8601String();

  /// Check if date is today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Check if date is yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Check if date is tomorrow
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  /// Get relative time string (e.g., "2 hours ago", "in 3 days")
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }

  /// Get start of day (00:00:00)
  DateTime get startOfDay => DateTime(year, month, day);

  /// Get end of day (23:59:59)
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);

  /// Add business days (excluding weekends)
  DateTime addBusinessDays(int days) {
    DateTime result = this;
    int addedDays = 0;

    while (addedDays < days) {
      result = result.add(const Duration(days: 1));
      if (result.weekday < 6) {
        // Monday = 1, Sunday = 7
        addedDays++;
      }
    }

    return result;
  }

  /// Custom format with pattern
  String format(String pattern) => DateFormat(pattern).format(this);
}
