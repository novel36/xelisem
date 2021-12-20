import 'package:flutter/material.dart';

TextField searchBar() {
  return TextField(
    style: TextStyle(color: Colors.white, fontSize: 15),
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
              onPressed: () {}, icon: Icon(Icons.close), color: Colors.white),
        ),
        hintText: "Search here...",
        hintStyle: TextStyle(
          color: Colors.white,
        ),
        fillColor: Colors.black,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(35))),
  );
}
