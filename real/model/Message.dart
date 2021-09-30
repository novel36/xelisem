// ignore: import_of_legacy_library_into_null_safe
import 'package:sms_advanced/sms_advanced.dart';

class Message {
  final List<SmsMessage> body;
  final type;
  final String contactInfo;
  final bool isSmall;
  final bool isUnsavedContact;
  Message({
    required this.body,
    this.type,
    required this.contactInfo,
    required this.isSmall,
    required this.isUnsavedContact,
  });
}
