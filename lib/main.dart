import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
  
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Task 3',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),// ThemeData
      home: new MyHomePage(title: 'User Details'),
    );// MateriaApp
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  Future<List<User>> _getUsers() async{
    var data = await http.get("https://jsonplaceholder.typicode.com/users");

    var jsonData = json.decode(data.body);

    List<User> users = [];

    for (var u in jsonData){

      User user = User(u["index"], u["name"], u["username"], u["email"], u["phone"]);

      users.add(user);

    }
      print(users.length);

      return users;
  }


  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),//ApBar
      body: Container(
        child: FutureBuilder(
          future: _getUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot){

            if(snapshot.data == null){
              return Container(
                child: Center(
                  child: Text("Loading..."),
                ) // Center
              ); // Container
            } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index){

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blueGrey[850],
                    child: Text(snapshot.data[index].name[0],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    )),
                  ),
                  title: Text(snapshot.data[index].name),
                  subtitle: Text(snapshot.data[index].email),
                  onTap: (){
                    Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => DetailPage(snapshot.data[index]))
                    );

                  },
                );// ListTile
              },
            ); // ListView.builder
            }
          }, 
        ),// FutureBuilder
      ),//Container
    );//Scaffold
  }
}

class DetailPage extends StatelessWidget {

final User user;


DetailPage(this.user);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                        'Name',
                      style: TextStyle(fontSize: 22.0, color: Colors.red, letterSpacing: 2.0),
                    ),
                    subtitle: Text(
                        user.name,
                      style: TextStyle(color: Colors.black, fontSize: 16.0, letterSpacing: 3.0),
                    ),
                  ),
                  ListTile(
                    title: Text(
                        'Username',
                      style: TextStyle(fontSize: 22.0, color: Colors.red, letterSpacing: 2.0),
                    ),
                    subtitle: Text(
                        user.username,
                      style: TextStyle(color: Colors.black, fontSize: 16.0, letterSpacing: 3.0),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Email',
                      style: TextStyle(fontSize: 22.0, color: Colors.red, letterSpacing: 2.0),
                    ),
                    subtitle: Text(
                      user.email,
                      style: TextStyle(color: Colors.black, fontSize: 16.0, letterSpacing: 3.0),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Phone Number',
                      style: TextStyle(fontSize: 22.0, color: Colors.red, letterSpacing: 2.0),
                    ),
                    subtitle: Text(
                      user.phone,
                      style: TextStyle(color: Colors.black, fontSize: 16.0, letterSpacing: 3.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



class User{
  final int index;
  final String name;
  final String username;
  final String email;
  final String phone;

  User(this.index, this.name, this.username, this.email, this.phone);

}