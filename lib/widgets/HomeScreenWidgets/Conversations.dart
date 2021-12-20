import 'package:flutter/material.dart';
import 'package:sms_advanced/sms_advanced.dart';
import 'package:xelisem/screens/myMessageDetaicopy.dart';

// Card messageConversationWidgets() {
//   return messageConversationWidgets();
// }

class MessageConversationWidgets extends StatelessWidget {
  final number;
  final String? lastMessage;
  final List<SmsMessage> messages;
  const MessageConversationWidgets({
    Key? key,
    required this.number,
    required this.lastMessage,
    required this.messages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF2A2A2A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (buildContext) => MessageDetail(
                      body: messages, messageLength: messages.length)));
        },
        splashColor: Color(0xFF44322A),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Color(0xFFF36E36),
                  child: Text(
                    "A",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: "$number",
                        child: Text(number,
                            style:
                                TextStyle(fontSize: 14.5, color: Colors.white)),
                      ),
                      Text(lastMessage!,
                          style: TextStyle(fontSize: 11, color: Colors.white)),
                    ],
                  ),
                ),
                Icon(
                  Icons.check_circle,
                  size: 19,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
