import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './set_album_screen.dart';

Future<Album> fetchAlbum() async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/albums/1');
  if (response.statusCode == 200) {
    return Album.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  Album({this.userId, this.id, this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

class HttpPage extends StatefulWidget {
  static const routeName = '/albumroute';

  @override
  _HttpPageState createState() => _HttpPageState();
}

class _HttpPageState extends State<HttpPage> {
  Future<Album> futureAlbum;

  @override
  void initState() {
    futureAlbum = fetchAlbum();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Albums'),
          centerTitle: true,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height * .9,
          child: Column(
            children: <Widget>[
              RaisedButton(
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(9),
                          topLeft: Radius.circular(9))),
                  color: Colors.blue,
                  child: Text(
                    'Add Album',
                    style: TextStyle(fontSize: 16, color: Colors.purpleAccent),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(SetAlbum.routeName);
                  }),
              Text('Current Album'),
              Expanded(
                child: FutureBuilder<Album>(
                    future: futureAlbum,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Center(child: Text(snapshot.data.title));
                      } else if (snapshot.hasError) {
                        return Center(
                            child: Text('there was an error fetching the album'));
                      }
                      return Center(child: CircularProgressIndicator());
                    }),
              ),
            ],
          ),
        ));
  }
}
