import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


void main() {
  runApp(
    MaterialApp(
      home: StarWarsData(),
    )
  );
}

class StarWarsData extends StatefulWidget {
  const StarWarsData({ Key? key }) : super(key: key);

  @override
  _StarWarsDataState createState() => _StarWarsDataState();
}

class _StarWarsDataState extends State<StarWarsData> {

  final String url = "https://swapi.dev/api/starships/";
  List data = [];

  Future<String> getSWData() async{
    var res = await http
      .get(Uri.parse(url) , headers: {"Accept" : "application/json"});

      setState(() {
        var resbody = json.decode(res.body);
        data = resbody["results"];

      });
      return "Success!";
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Star Wars Starships"),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: data.length   ,
        itemBuilder: (BuildContext context , int index){

          return  new Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Text(data[index]["name"],
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black54
                        ),
                      ),
                    ),
                  ),
                   Card(
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Text(data[index]["model"],
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black54
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        
        }
        ),  
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getSWData();
  }
}