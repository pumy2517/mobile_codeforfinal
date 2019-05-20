import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<List<Post>> fetchPosts(int userid) async {
  final response = await http
      .get('https://jsonplaceholder.typicode.com/users/${userid}/posts');

  List<Post> postApi = [];

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var body = json.decode(response.body);
    for (int i = 0; i < body.length; i++) {
      var post = Post.fromJson(body[i]);
      print(post);
      if (post.userid == userid) {
        postApi.add(post);
      }
    }
    return postApi;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  final int userid;
  final int id;
  final String title;
  final String body;

  Post({this.userid, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userid: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

class PostPage extends StatelessWidget {
  final color = const Color(0xffb71c1c);

  final int id;

  PostPage({Key key, @required this.id}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Post"),
        backgroundColor: color,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("BACK"),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            FutureBuilder(
              future: fetchPosts(this.id),
              builder: (BuildContext context, AsyncSnapshot snapshot){
                  switch (snapshot.connectionState){
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return new Text("Loading...");
                    default:
                      if(snapshot.hasError){
                        return new Text('Error: ${snapshot.error}');
                      }
                      else {
                        return createListView(context, snapshot);
                      }
                  }
              }
            )
          ],
        ),
      ),
    );
  }

  Widget createListView(context, snapshot){
    List<Post> values = snapshot.data;
    return new Expanded(
      child: new ListView.builder(
        itemCount: values.length,
        itemBuilder: (BuildContext context, int index){
          return new Card(
            child: InkWell(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "ID: ${values[index].id.toString()}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  Text(
                    "Title: ${values[index].title}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),          
                  ),
                  Text(
                    "Detail: ${values[index].body}",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }

}