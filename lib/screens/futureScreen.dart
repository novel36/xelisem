import 'dart:async';

import 'package:flutter/material.dart';

class FutureScreen extends StatefulWidget {
  const FutureScreen({Key? key}) : super(key: key);

  @override
  _FutureScreenState createState() => _FutureScreenState();
}

class _FutureScreenState extends State<FutureScreen> {
  List<String> value = [
    "Novel",
    "Aovel",
    "Vovel",
    "Wovel",
    "Wovel",
    "Tovel",
    "Aovel",
    "Movel",
    "Aovel",
    "Movel",
    "Novel",
    "Aovel",
    "Vovel",
    "Wovel",
    "Wovel",
    "Tovel",
    "Aovel",
    "Movel",
    "Aovel",
    "Movel",
    "Novel",
    "Aovel",
    "Vovel",
    "Wovel",
    "Wovel",
    "Tovel",
    "Aovel",
    "Movel",
    "Aovel",
    "Movel",
  ];
  // double? _progress = 0;
  Future<List<String>?> getData() async {
    await Future.delayed(Duration(seconds: 10), () {
      // print(value);
    });

    return null;
  }
  // ahiya , 24 tebik, dont talk

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(),
        appBar: AppBar(),
        body: FutureBuilder(
            future: getData(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                return ListOFNAmes(
                  names: snapshot.data,
                );
              } else if (snapshot.hasData) {
                return Text("No Data");
              } else {
                return Column(
                  children: [
                    SizedBox(
                        child: LinearProgressIndicator(
                      color: Colors.purple,
                    )),
                    Expanded(
                        child: Center(
                            child: Text(
                      "Getting files...",
                      style: TextStyle(fontSize: 16),
                    )))
                  ],
                );
              }
            }));
  }
}

class ListOFNAmes extends StatelessWidget {
  final names;
  const ListOFNAmes({Key? key, this.names}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: names.length,
        itemBuilder: (BuildContext context, index) {
          return Column(
            children: [
              ListTile(
                title: Text(names[index].toString()),
                leading: Icon(Icons.person),
              ),
              Divider()
            ],
          );
        });
  }
}
