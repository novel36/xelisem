import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sms_advanced/sms_advanced.dart';
import 'package:bubble/bubble.dart';

enum WhyFarther { harder, smarter, selfStarter, tradingCharter }

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
  late WhyFarther _selection;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF141A2A),
        appBar: AppBar(
          backgroundColor: Color(0xFF1F2B37),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.person,
                size: 25,
              ),
              SizedBox(
                width: 4,
              ),
              Hero(
                tag: "${widget.body.first.address}",
                child: Text(
                  widget.body.first.address.toString(),
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ],
          ),
          actions: [
            PopupMenuButton<WhyFarther>(
              onSelected: (WhyFarther result) {
                setState(() {
                  _selection = result;
                });
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<WhyFarther>>[
                const PopupMenuItem<WhyFarther>(
                  value: WhyFarther.harder,
                  child: Text('Working'),
                ),
                const PopupMenuItem<WhyFarther>(
                  value: WhyFarther.smarter,
                  child: Text('Being'),
                ),
                const PopupMenuItem<WhyFarther>(
                  value: WhyFarther.selfStarter,
                  child: Text('Being'),
                ),
                const PopupMenuItem<WhyFarther>(
                  value: WhyFarther.tradingCharter,
                  child: Text('Placed'),
                ),
              ],
            )
          ],
          // centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                padding: EdgeInsets.only(top: 5.0),
                itemBuilder: (context, index) {
                  return Bubble(
                    elevation: 15,
                    padding: BubbleEdges.all(12),
                    stick: true,
                    alignment:
                        widget.body[index].kind == SmsMessageKind.Received
                            ? Alignment.topLeft
                            : Alignment.topRight,
                    margin: BubbleEdges.only(
                        top: 15,
                        right:
                            widget.body[index].kind == SmsMessageKind.Received
                                ? 70
                                : 5,
                        left: widget.body[index].kind == SmsMessageKind.Received
                            ? 5
                            : 70),

                    nip: widget.body[index].kind == SmsMessageKind.Received
                        ? BubbleNip.leftTop
                        : BubbleNip.rightTop,
                    color: widget.body[index].kind == SmsMessageKind.Received
                        ? Color(0xFF222C38)
                        : Color(0xFF3B5D80),
                    // ? Color.fromRGBO(212, 234, 244, 1.0)
                    // : Color.fromRGBO(225, 255, 199, 1.0),
                    child: Text(
                      widget.body[index].body.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
                itemCount: widget.messageLength,
              ),
            ),
            // SizedBox(
            //   height: 15,
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFF142B37),
                  hintText: "Type here ...",
                  hintStyle: TextStyle(color: Colors.white38),
                  prefixIcon: IconButton(
                    icon: Icon(Icons.emoji_emotions),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {},
                    color: Colors.white,
                  ),
                  focusedBorder: InputBorder.none,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
