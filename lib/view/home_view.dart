import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List data = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    var url = Uri.parse('https://test123.alapalap.fun/api/student');
    await http.get(url).then((response) async {
      var jsonData = await jsonDecode(response.body);
      setState(() => data = jsonData['data']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        if (data.isEmpty) const Text('Loading'),
        for (int idx = 0; idx < data.length; idx++) ...[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              color: Colors.amber[600],
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(data[idx]['fname']),
                    Text(data[idx]['lname']),
                  ]),
            ),
          ),
        ]
      ],
    );
  }
}
