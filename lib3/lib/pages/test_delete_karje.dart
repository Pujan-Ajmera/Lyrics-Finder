import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lyrics_app/pages/model.dart';

class Deletekrje extends StatefulWidget {
  @override
  _DeletekrjeState createState() => _DeletekrjeState();
}

class _DeletekrjeState extends State<Deletekrje> {
  List<Model> model = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }
  Future<void> fetchProducts() async {
    final response = await http.get(
      Uri.parse('https://api.genius.com/search?q=shivers'),
      headers: {
        'Authorization': 'Bearer IRgGbgFS8LuaU0ef31lOsdvmsZBXvPOK_F8AUewUhR-CJpDQY25Se3vz1Cj7VPDK',
      },
    );

    if (response.statusCode == 200) {
      // Decode JSON
      final Map<String, dynamic> jsonData = json.decode(response.body);
      // Extract "hits" list from response
      print(jsonData);
      print('\n${jsonData["response"]}');
      print('\n${jsonData["response"]["hits"]}::::::::::::::::::::::::::::');
      List<dynamic> hits = jsonData["response"]["hits"];

      // Convert each hit object into your model
      setState(() {
        model = hits.map((data) => Model.fromJson(data["result"])).toList();
      });
    } else {
      // Handle error if needed
      print("Failed to load data: ${response.statusCode}");
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Model List'),
      ),
      body: ListView.builder(
        // this give th length of item
        itemCount: model.length,
        itemBuilder: (context, index) {
          // here we card the card widget
          // which is in utils folder
          return ListTile(
            title: Text("${model[index].full_title}"),
          );
        },
      ),
    );
  }
}
