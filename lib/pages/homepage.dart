import 'package:flutter/material.dart';
import 'package:lyrics_app/pages/colors.dart';
import 'package:lyrics_app/pages/page_where_you_find_songs.dart';  // Ensure correct import

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController songController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Lyrics"),
      backgroundColor:MyColors().color2,
    ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: songController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a song name';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Song Name',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllSongs(songController.text),
                        ),
                      );
                    }
                  },
                  child: const Text("Search"),
                ),
                ElevatedButton(
                  onPressed: () {
                    songController.text = "";
                    setState(() {

                    });
                  },
                  child: const Text("Remove"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
