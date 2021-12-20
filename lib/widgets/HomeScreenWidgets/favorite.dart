import 'package:flutter/material.dart';

Container favoriteMessages() {
  return Container(
    height: 90,
    child: Row(
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
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ],
    ),
  );
}
