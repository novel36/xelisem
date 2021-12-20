import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_advanced/sms_advanced.dart';
import 'package:xelisem/widgets/HomeScreenWidgets/Conversations.dart';
import 'package:xelisem/widgets/HomeScreenWidgets/SearchBar.dart';
import 'package:xelisem/widgets/HomeScreenWidgets/favorite.dart';
import 'package:xelisem/widgets/MessageBackgroundWidget.dart';

// Global Variable
SmsQuery query = new SmsQuery();

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  // Local Variables
  late List<SmsThread> smsThread = [];
  // local methods
  getAllMessages() async {
    smsThread = await query.getAllThreads;

    setState(() {});
  }

  saveToDisk() async {}

  @override
  void initState() {
    super.initState();
    getAllMessages();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      backgroundColor: Color(0xFF2A2A2A),
      body: Container(
        decoration: BoxDecoration(),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              flexibleSpace: MessageBackground(),
              title: Text(
                "Message",
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(150),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: searchBar(),
                    ),
                    favoriteMessages(),
                  ],
                ),
              ),
            ),
            SliverPadding(
                padding: EdgeInsets.only(top: 8.0),
                sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return MessageConversationWidgets(
                      number: smsThread[index].address,
                      lastMessage: smallMessage(index),
                      messages: smsThread[index].messages,
                    );
                  },
                  childCount: smsThread.length,
                )))
          ],
        ),
      ),
    );
  }

  String? smallMessage(int index) {
    if (smsThread[index].messages.last.body!.length >= 30) {
      return smsThread[index]
          .messages
          .last
          .body!
          .substring(0, 30)
          .replaceRange(29, 30, "...");
    } else {
      return smsThread[index].messages.last.body;
    }
  }
}
