import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lyrics_app/pages/colors.dart';
import 'package:lyrics_app/pages/model.dart';
import 'package:url_launcher/url_launcher.dart';

import 'homepage.dart';

class AllSongs extends StatefulWidget {
  String? song;
  AllSongs(this.song);
  @override
  _AllSongsState createState() => _AllSongsState();
}

class _AllSongsState extends State<AllSongs> {
  List<Model> model = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }
  Future<void> fetchProducts() async {
    String songgot = widget.song!;

    final response = await http.get(
      Uri.parse('https://api.genius.com/search?q=${songgot}'),
      headers: {
        'Authorization': 'Bearer IRgGbgFS8LuaU0ef31lOsdvmsZBXvPOK_F8AUewUhR-CJpDQY25Se3vz1Cj7VPDK',
      },
    );

    if (response.statusCode == 200) {
      // Decode JSON
      final Map<String, dynamic> jsonData = json.decode(response.body);

      // Extract "hits" list from response
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
        backgroundColor: MyColors().color2,
        title: Text('Model List',style: TextStyle(color: MyColors().color5),),
      ),
      body: ListView.builder(
        itemCount: model.length,
        itemBuilder: (context, index) {
          return buildSongTile(model[index],context);
        },
      ),
    );
  }

  Widget buildSongTile(Model song, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchPage()),
          );
        },
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          shadowColor: Colors.black26,
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                colors: [Colors.grey.shade100, Colors.white], // Subtle gradient
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    song.header_image_thumbnail_url,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Icon(Icons.image, size: 60, color: Colors.grey),
                  ),
                ),
                SizedBox(width: 12), // Spacing between image & text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        song.full_title,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5),
                      Text(
                        song.artist_names,
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: Colors.grey[700]), // Arrow indicator
              ],
            ),
          ),
        ),
      ),
    );
  }
}


