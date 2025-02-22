import 'package:flutter/material.dart';
import 'package:genius_lyrics/genius_lyrics.dart';
import 'package:genius_lyrics/models/song.dart';
import 'package:lyrics_app/pages/colors.dart';

class DisplayLyrics extends StatelessWidget {
  String? lyr;
  DisplayLyrics(this.lyr);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Lyrics"),backgroundColor: MyColors().color2,),
      body: Center(child: ListView(children:[
        Text("${lyr}"),
      ]),),
    );
  }
}
