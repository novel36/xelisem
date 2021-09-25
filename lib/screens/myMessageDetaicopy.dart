import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sms_advanced/sms_advanced.dart';
import 'package:bubble/bubble.dart';

class MessageDetail extends StatefulWidget {
  final List<SmsMessage> body;
  final int messageLength;
  const MessageDetail(
      {Key? key, required this.body, required this.messageLength})
      : super(key: key);

  @override
  _MessageDetailState createState() => _MessageDetailState();
}

class _MessageDetailState extends State<MessageDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF999595),
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.person),
            SizedBox(
              width: 10,
            ),
            Text(widget.body.first.address.toString()),
          ],
        ),
        // centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 5.0),
              itemBuilder: (context, index) {
                return Bubble(
                  elevation: 15,
                  padding: BubbleEdges.all(12),
                  stick: true,
                  alignment: widget.body[index].kind == SmsMessageKind.Received
                      ? Alignment.topLeft
                      : Alignment.topRight,
                  margin: BubbleEdges.only(
                      top: 15,
                      left: widget.body[index].kind == SmsMessageKind.Received
                          ? 5
                          : 20),
                  nip: widget.body[index].kind == SmsMessageKind.Received
                      ? BubbleNip.leftTop
                      : BubbleNip.rightTop,
                  color: widget.body[index].kind == SmsMessageKind.Received
                      ? Color.fromRGBO(212, 234, 244, 1.0)
                      : Color.fromRGBO(225, 255, 199, 1.0),
                  child: Text(widget.body[index].body.toString()),
                );
              },
              itemCount: widget.messageLength,
            ),
          ),
          TextField(
            decoration: InputDecoration(
              hintText: "Type here ...",
              prefixIcon: IconButton(
                icon: Icon(Icons.emoji_emotions),
                onPressed: () {},
              ),
              suffixIcon: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {},
              ),
              focusedBorder: InputBorder.none,
            ),
          )
        ],
      ),
    );
  }
}
