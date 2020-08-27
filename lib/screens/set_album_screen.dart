import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<AlbumCreator> createAlbum(String title) async {
  final response =
      await http.post('https://jsonplaceholder.typicode.com/albums',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, String>{'title': title}));
  if (response.statusCode == 201) {
    return AlbumCreator.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to create album');
  }
}

class AlbumCreator {
  final int id;
  final String title;

  AlbumCreator({this.id, this.title});

  factory AlbumCreator.fromJson(Map<String, dynamic> json) {
    return AlbumCreator(
      id: json['id'],
      title: json['title'],
    );
  }
}

class SetAlbum extends StatefulWidget {
  static const routeName = '/setAlbumScreen';

  @override
  _SetAlbumState createState() => _SetAlbumState();
}

class _SetAlbumState extends State<SetAlbum> {
  final textController = TextEditingController();
  Future<AlbumCreator> _futureAlbum;

//  @override
//  void dispose() {
//    _textController.dispose();
//    super.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('set your album title'),
          centerTitle: true,
        ),
        body: (_futureAlbum == null)
            ? Center(
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: textController,
                      decoration:
                          InputDecoration(hintText: 'Enter Album Title'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      child: Text('Create Data'),
                      onPressed: () {
                        setState(() {
                          _futureAlbum = createAlbum(textController.text);
                          //print(textController.text);
                        });
                      },
                    ),
                  ],
                ),
              )
            : Center(
                child: FutureBuilder(
                    future: _futureAlbum,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print(snapshot.data);
                        return Text(snapshot.data.title);
                      } else if (snapshot.hasError) {
                        return Text('An error occured');
                      }
                      return CircularProgressIndicator();
                    }),
              ));
  }
}
