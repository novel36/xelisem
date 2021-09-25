import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:xelisem/model/Message.dart';
import 'package:xelisem/screens/myMessageDetail.dart';
import 'package:xelisem/widgets/MessageBackgroundWidget.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sms_advanced/contact.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sms_advanced/sms_advanced.dart';
// ignore: import_of_legacy_library_into_null_safe
// import 'package:sms/sms.dart';
// import 'package:telephony/telephony.dart' as telephonySms;
// import 'package:flutter_sms/flutter_sms.dart';
import 'package:permission_handler/permission_handler.dart';

SmsQuery query = new SmsQuery();

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late TextEditingController textController;
  SlidableController _slidableController = SlidableController();
  // final scaffoldKey = GlobalKey<ScaffoldState>();
  // final telephonySms.Telephony telephony = telephonySms.Telephony.instance;
  List<SmsMessage> messages = [];
  List<Message> _favoritemessages = [];

  List<SmsThread> threads = [];
  // List<String> _threadContactInfo = [];
  late List<Message> message = [];
  bool isLoaded = false;
  bool undo = false;
  late Message deletedMessage;
  late Message deletedFavoriteMessage;
  bool hideSmallDigitsMessages = false;
  bool nightMode = false;

  void getMessage() async {
    // await telephony.requestPhonePermissions;
    // var contactStatus = await Permission.contacts.request();
    // var smsStatus = await Permission.sms.request();
    // var phoneStatus = await Permission.phone.request();
    Map<Permission, PermissionStatus> mStatu = await [
      Permission.phone,
      Permission.sms,
      Permission.contacts,
    ].request();

    if (mStatu[Permission.phone] == PermissionStatus.granted &&
        mStatu[Permission.sms] == PermissionStatus.granted &&
        mStatu[Permission.contacts] == PermissionStatus.granted) {
      threads = await query.getAllThreads;
      threads.reversed.forEach((element) {
        Contact? contact = element.contact;
        message.add(Message(
            body: element.messages.reversed.toList(),
            contactInfo: contact!.fullName == null
                ? contact.address.toString()
                : contact.fullName.toString(),
            isSmall: element.address!
                            .contains(RegExp('r[A-Z]', caseSensitive: false)) ==
                        false &&
                    element.address!.length < 5
                ? true
                : false,
            isUnsavedContact: contact.fullName == null ? true : false));
        message.forEach((element) {
          if (element.isSmall == true) {
            print(element.contactInfo);
          }
        });
      });

      print(threads.length);
      if (threads.length > 0 || threads.isNotEmpty) {
        setState(() {
          isLoaded = true;
        });
      }
    } else {
      getMessage();
    }
  }

  @override
  void initState() {
    super.initState();
    getMessage();

    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          message.forEach((element) {
            if (element.contactInfo.length < 5) if (!element.contactInfo
                .contains(RegExp(r'[A-Z]', caseSensitive: false)))
              print(element.contactInfo);
          });
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: Color(0xFF2A2A2A),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: MessageBackground(),
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.all(0),
            ),
            SwitchListTile(
              value: hideSmallDigitsMessages,
              onChanged: (x) {
                setState(() {
                  hideSmallDigitsMessages = x;
                });
              },
              title: Text(
                "Show/hide Number",
                style: TextStyle(fontSize: 14.0),
              ),
              secondary: Icon(Icons.remove_red_eye),
              subtitle: Text(
                "Hide Small Digits Number",
                style: TextStyle(fontSize: 8.0),
              ),
            ),
            Divider(),
            SwitchListTile(
              value: nightMode,
              onChanged: (x) {
                setState(() {
                  nightMode = x;
                });
              },
              title: Text(
                "Night Mode",
                style: TextStyle(fontSize: 14.0),
              ),
              secondary: Icon(Icons.brightness_4),
            ),
            Divider(),
            ListTile(
              title: Text(
                "Settings",
                style: TextStyle(fontSize: 14.0),
              ),
              leading: Icon(Icons.settings),
            ),
            Divider(),
          ],
        ),
      ),
      body: isLoaded == false
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  strokeWidth: 5,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Loading Messages...",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ))
          : Container(
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
                            child: TextField(
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                              decoration: InputDecoration(
                                  isDense: true,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: IconButton(
                                        onPressed: () {
                                          // print("TextField Closed");
                                        },
                                        icon: Icon(Icons.close),
                                        color: Colors.white),
                                  ),
                                  hintText: "Search here...",
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                  fillColor: Colors.black,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(35))),
                            ),
                          ),
                          Container(
                            height: 90,
                            child: _favoritemessages.isNotEmpty
                                ? ListView.builder(
                                    itemCount: _favoritemessages.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.transparent
                                                .withOpacity(0.1),
                                            // color: Colors.deepOrange
                                          ),
                                          height: 50,
                                          width: 120,
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MessageDetail(
                                                                body: message[
                                                                        index]
                                                                    .body,
                                                                messageLength:
                                                                    message[index]
                                                                        .body
                                                                        .length,
                                                              )));
                                                },
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    CircleAvatar(
                                                      child: Text(
                                                        "?",
                                                        style: TextStyle(
                                                            fontSize: 25,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      _favoritemessages[index]
                                                          .contactInfo,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              PositionedDirectional(
                                                top: -8,
                                                end: -5,
                                                child: CloseButton(
                                                  color: Colors.white,
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            backgroundColor:
                                                                Colors.blue,
                                                            title: const Text(
                                                              'Are You Sure?',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            actions: [
                                                              TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      deletedFavoriteMessage =
                                                                          _favoritemessages
                                                                              .removeAt(index);
                                                                    });
                                                                    Navigator.pop(
                                                                        context,
                                                                        true);
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .removeCurrentSnackBar();
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      SnackBar(
                                                                        backgroundColor:
                                                                            Colors.red,
                                                                        content:
                                                                            Text(
                                                                          'Successfully Delete',
                                                                          style:
                                                                              TextStyle(fontSize: 15),
                                                                        ),
                                                                        action: SnackBarAction(
                                                                            label: "Undo",
                                                                            textColor: Colors.white,
                                                                            onPressed: () {
                                                                              setState(() {
                                                                                _favoritemessages.insert(index, deletedFavoriteMessage);
                                                                              });
                                                                            }),
                                                                      ),
                                                                    );
                                                                  },
                                                                  child: Text(
                                                                    "Yes",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  )),
                                                              TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context,
                                                                        true);
                                                                  },
                                                                  child: Text(
                                                                    "No",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  )),
                                                            ],
                                                          );
                                                        });
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    })
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.hourglass_empty_rounded,
                                        color: Colors.white,
                                        size: 35,
                                      ),
                                      SizedBox(width: 5),
                                      Center(
                                        child: Text(
                                          "No Favorite!",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.only(top: 8.0),
                    sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        // Message deletedMessage =
                        //     Message(body: [], contactInfo: "", type: "");

                        return Slidable(
                          actionPane: SlidableDrawerActionPane(),
                          controller: _slidableController,
                          key: ValueKey(message[index]),
                          closeOnScroll: true,
                          actionExtentRatio: 0.25,
                          actions: <Widget>[
                            IconSlideAction(
                              caption: 'Archive',
                              color: Colors.blue,
                              icon: Icons.archive,
                              onTap: () {},
                            )
                          ],
                          secondaryActions: <Widget>[
                            IconSlideAction(
                                caption: 'Favorite',
                                color: Colors.blue,
                                icon: Icons.favorite,
                                onTap: () {
                                  _favoritemessages
                                      .add(message.elementAt(index));
                                  ScaffoldMessenger.of(context)
                                      .removeCurrentSnackBar();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "Successfully Added to Favorite!",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                    backgroundColor: Colors.green,
                                    duration: Duration(seconds: 1),
                                  ));
                                  setState(() {});
                                }),
                            IconSlideAction(
                              caption: 'Delete',
                              color: Colors.red,
                              icon: Icons.delete,
                              onTap: () {
                                setState(() {
                                  deletedMessage = message.removeAt(index);
                                });
                                ScaffoldMessenger.of(context)
                                    .removeCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                      'Successfully Delete',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    action: SnackBarAction(
                                        label: "Undo",
                                        textColor: Colors.white,
                                        onPressed: () {
                                          setState(() {
                                            message.insert(
                                                index, deletedMessage);
                                          });
                                        }),
                                  ),
                                );
                              },
                            ),
                          ],
                          child: Card(
                            color: Color(0xFF2A2A2A),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9)),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MessageDetail(
                                              body: message[index].body,
                                              messageLength:
                                                  message[index].body.length,
                                            )));
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
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                message[index].isUnsavedContact
                                                    ? "Unsaved"
                                                    : message[index]
                                                        .contactInfo,
                                                style: TextStyle(
                                                    fontSize: 14.5,
                                                    color: Colors.white)),
                                            Text(message[index].contactInfo,
                                                style: TextStyle(
                                                    fontSize: 15.5,
                                                    color: Colors.white)),
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
                          ),
                        );

                        // return Slidable(
                        //   actionPane: SlidableDrawerActionPane(),
                        //   controller: _slidableController,
                        //   key: ValueKey(message[index]),
                        //   closeOnScroll: true,
                        //   actionExtentRatio: 0.25,
                        //   actions: <Widget>[
                        //     IconSlideAction(
                        //       caption: 'Archive',
                        //       color: Colors.blue,
                        //       icon: Icons.archive,
                        //       onTap: () {},
                        //     )
                        //   ],
                        //   secondaryActions: <Widget>[
                        //     IconSlideAction(
                        //         caption: 'Favorite',
                        //         color: Colors.blue,
                        //         icon: Icons.favorite,
                        //         onTap: () {
                        //           _favoritemessages
                        //               .add(message.elementAt(index));
                        //           ScaffoldMessenger.of(context)
                        //               .removeCurrentSnackBar();
                        //           ScaffoldMessenger.of(context)
                        //               .showSnackBar(SnackBar(
                        //             content: Row(
                        //               mainAxisAlignment:
                        //                   MainAxisAlignment.spaceEvenly,
                        //               children: [
                        //                 Text(
                        //                   "Successfully Added to Favorite!",
                        //                   style: TextStyle(fontSize: 15),
                        //                 ),
                        //                 Icon(
                        //                   Icons.check,
                        //                   color: Colors.white,
                        //                 )
                        //               ],
                        //             ),
                        //             backgroundColor: Colors.green,
                        //             duration: Duration(seconds: 1),
                        //           ));
                        //           setState(() {});
                        //         }),
                        //     IconSlideAction(
                        //       caption: 'Delete',
                        //       color: Colors.red,
                        //       icon: Icons.delete,
                        //       onTap: () {
                        //         setState(() {
                        //           deletedMessage = message.removeAt(index);
                        //         });
                        //         ScaffoldMessenger.of(context)
                        //             .removeCurrentSnackBar();
                        //         ScaffoldMessenger.of(context).showSnackBar(
                        //           SnackBar(
                        //             backgroundColor: Colors.red,
                        //             content: Text(
                        //               'Successfully Delete',
                        //               style: TextStyle(fontSize: 15),
                        //             ),
                        //             action: SnackBarAction(
                        //                 label: "Undo",
                        //                 textColor: Colors.white,
                        //                 onPressed: () {
                        //                   setState(() {
                        //                     message.insert(
                        //                         index, deletedMessage);
                        //                   });
                        //                 }),
                        //           ),
                        //         );
                        //       },
                        //     ),
                        //   ],
                        //   child: Card(
                        //     color: Color(0xFF2A2A2A),
                        //     shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(9)),
                        //     child: InkWell(
                        //       onTap: () {
                        //         Navigator.push(
                        //             context,
                        //             MaterialPageRoute(
                        //                 builder: (context) => MessageDetail(
                        //                       body: message[index].body,
                        //                       messageLength:
                        //                           message[index].body.length,
                        //                     )));
                        //       },
                        //       splashColor: Color(0xFF44322A),
                        //       child: Padding(
                        //         padding: const EdgeInsets.all(15.0),
                        //         child: Container(
                        //           child: Row(
                        //             children: [
                        //               CircleAvatar(
                        //                 backgroundColor: Color(0xFFF36E36),
                        //                 child: Text(
                        //                   "A",
                        //                   style: TextStyle(
                        //                       fontSize: 20,
                        //                       color: Colors.white),
                        //                 ),
                        //               ),
                        //               SizedBox(
                        //                 width: 15,
                        //               ),
                        //               Expanded(
                        //                 child: Column(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.start,
                        //                   crossAxisAlignment:
                        //                       CrossAxisAlignment.start,
                        //                   children: [
                        //                     Text(
                        //                         message[index]
                        //                                 .isUnsavedContact
                        //                             ? "Unsaved"
                        //                             : message[index]
                        //                                 .contactInfo,
                        //                         style: TextStyle(
                        //                             fontSize: 14.5,
                        //                             color: Colors.white)),
                        //                     Text(message[index].contactInfo,
                        //                         style: TextStyle(
                        //                             fontSize: 15.5,
                        //                             color: Colors.white)),
                        //                   ],
                        //                 ),
                        //               ),
                        //               Icon(
                        //                 Icons.check_circle,
                        //                 size: 19,
                        //                 color: Colors.white,
                        //               )
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // );
                      },
                      childCount: message.length,
                    )),
                  )
                ],
              ),
            ),
    );
  }
}
