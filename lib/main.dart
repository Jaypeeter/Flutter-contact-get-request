import 'dart:convert';

import "package:flutter/material.dart";
import "package:http/http.dart" as http;

void main(){
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void getData() async {
    var res = await http.get(Uri.https("dummyjson.com","users"));
    Map refinedres = jsonDecode(res.body);
    // print(refinedres);
    setState((){
      loading = true;
    });
    users = refinedres["users"];
  }

  List<dynamic> users = [];
  var loading = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text("Get request"),
        centerTitle: true,
      ),
      body: users.isNotEmpty ?
          ListView.builder(itemBuilder: (context,index) {
            return Container(
              height: 80.0,
              child: Card(
                child: Row(
                  children: [Image.network(users[index]["image"]),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(users[index]["firstName"],
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(users[index]["email"],
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        Text(users[index]["phone"],
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                ],),],
                ),
              ),
            );
          })
          :
      Container(
        child: loading? CircularProgressIndicator() : ElevatedButton(
          onPressed: (){
        setState(() {
          getData();
        });
    },
    child: Text("Get request"),
    ),
      ),
    );
  }
}
