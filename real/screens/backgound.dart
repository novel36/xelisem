import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFA7A6),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Color(0xFF27B56E),
                borderRadius: BorderRadius.only(
                    topRight: Radius.elliptical(
                  MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height ,
                ))),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.elliptical(280, 200))),
            width: MediaQuery.of(context).size.width - 50,
            height: MediaQuery.of(context).size.height - 500,
          ),
          Container(
            margin: EdgeInsets.only(top: 22, left: 30),
            decoration: BoxDecoration(
                color: Color(0xFFFDC03A),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            width: 70,
            height: 40,
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: EdgeInsets.only(top: 50),
              decoration: BoxDecoration(
                  color: Color(0xFF27B56E),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    bottomLeft: Radius.circular(45),
                  )),
              width: 40,
              height: 70,
            ),
          ),
                   Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 90),
              decoration: BoxDecoration(
                  color: Color(0xFFFDC03A),
                  borderRadius: BorderRadius.circular(50)
                   ),
              width: 60,
              height: 60,
            ),
          ),
        ],
      ),
    );
  }
}

