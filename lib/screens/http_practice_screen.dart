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

Future<Album> deleteAlbum(String id) async {
  final response = await http.delete('https://jsonplaceholder.typicode.com/albums/$id');
  if(response.statusCode == 200){
    return Album.fromJson(json.decode(response.body));
  }else{
    throw Exception('Failed to delete album');
  }
}

Future<Album> updateAlbum(String title) async{
  final response = await http.put('https://jsonplaceholder.typicode.com/albums/1',
  body: json.encode(<String, String>{
    'title' : title,
  }));

  if(response.statusCode == 200){
    return Album.fromJson(json.decode(response.body));
  }else{
    throw Exception('Failed to update this Album');
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
  final textController = TextEditingController();

  @override
  void initState() {
    futureAlbum = fetchAlbum();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textFromTextController = textController.text;
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
                          topRight: Radius.circular(9),
                          bottomLeft: Radius.circular(9))),
                  color: Colors.blue,
                  child: Text(
                    'Add Album',
                    style: TextStyle(fontSize: 16, color: Colors.purpleAccent),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(SetAlbum.routeName);
                  }),

              Expanded(
                child: FutureBuilder<Album>(
                    future: futureAlbum,
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.done){
                      if (snapshot.hasData) {
                        return Column(
                          children: <Widget>[
                            Center(child: Text(snapshot.data.title)),
                            TextField(
                              controller: textController,
                              decoration: InputDecoration(hintText: 'Enter new Title'),
                            ),
                            RaisedButton(
                                shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(9),
                                        bottomLeft: Radius.circular(9))),
                                color: Colors.blue,
                                child: Text(
                                  'update Album',
                                  style: TextStyle(fontSize: 16, color: Colors.purpleAccent),
                                ),
                                onPressed: () {
                                  setState(() {
                                    futureAlbum = updateAlbum(textFromTextController);
                                  });
                                }),
                            RaisedButton(
                                shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(9),
                                        topLeft: Radius.circular(9))),
                                color: Colors.blue,
                                child: Text(
                                  'Delete this Album',
                                  style: TextStyle(fontSize: 16, color: Colors.purpleAccent),
                                ),
                                onPressed: () {
                                  setState(() {
                                    futureAlbum = deleteAlbum(snapshot.data.id.toString());
                                  });
                                }),
                            Text('Current Album'),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                            child: Text('there was an error fetching the album'));
                      }
                      }
                      return Center(child: CircularProgressIndicator());
                    }),
              ),
            ],
          ),
        ));
  }
}
