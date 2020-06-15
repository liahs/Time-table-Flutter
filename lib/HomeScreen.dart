import 'dart:async';

import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'Faculty.dart';
import 'Search.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Global.dart';
import 'TeacherDetails.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomeScreen> {
  String name = "";
  String pic = "";
  int id = 1;
  int x=0;
  var datetime = DateTime.now();
  String weekDay = "Monday";
  _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("name");
      pic = prefs.getString("pic");
      id = prefs.getInt("id");
    });
  }
Future<Timer> loadData() async {
  return new Timer(Duration(seconds: 5), ()=>{
       setState((){
         x=1;
       })
  });
}

  @override
  void initState() {
    super.initState();
    if (datetime.weekday == 1) weekDay = "Monday";
    if (datetime.weekday == 2) weekDay = "Tuesday";
    if (datetime.weekday == 3) weekDay = "Wednesday";
    if (datetime.weekday == 4) weekDay = "Thursday";
    if (datetime.weekday == 5) weekDay = "Friday";
    _loadData();
    loadData();
  }

  Widget _tiles(String faculty, int n) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        shadowColor: Colors.grey[400],
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        elevation: 4.0,
        child: InkWell(
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Faculty()),
            )
          },
          child: Stack(
            alignment: const Alignment(0.1, 0.4),
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
                child: Stack(
                  children: <Widget>[
                    Center(child: CircularProgressIndicator()),
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image:
                            'https://picsum.photos/id/$n/${(MediaQuery.of(context).size.width ~/ 1)}/${(MediaQuery.of(context).size.height ~/ 4)}?',
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                            Colors.white54,
                            Colors.white30,
                            Colors.white30,
                            Colors.white54
                          ])),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 4,
                    )
                  ],
                ),
                width: MediaQuery.of(context).size.width,
              ),
              Text(
                faculty,
                style:
                    TextStyle(fontSize: 40.0, backgroundColor: Colors.white54),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if(x==0){
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/branded.png"),),
            Text("Teacher Routine App",style: TextStyle(fontSize: 30,color: Colors.brown[400],inherit: false)),
            SizedBox(height: 5.0,),
            Text("SBBS Univeristy",style: TextStyle(fontSize: 18,color: Colors.brown[400],inherit: false)),
            SizedBox(height: 5.0,),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.brown),
            ),
          ],
        ),
      ),
    );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Teacher routine"),
      ),
      drawer: Drawer(
          elevation: 2.0,
          child: StreamBuilder(
              stream: Firestore.instance
                  .collection("cse")
                  .document("$id")
                  .snapshots(),
              builder: (context, snaps) {
                if(snaps.hasData){
                return ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                      
                        Container(
                          padding: EdgeInsets.all(8.0),
                          width: MediaQuery.of(context).size.width,
                          color: Colors.brown[300],
                          child: Center(
                                                      child: Text(
                              'Profile',
                              style: TextStyle(fontSize: 28),
                            ),
                          ),
                        ),
                        Container(
                          margin:EdgeInsets.all(8.0) ,
                         padding: EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            border: Border.all(color:Colors.brown),
                            borderRadius: BorderRadius.circular(10.0)),
                          height: 200,
                          width: 160,
                          child: FadeInImage.memoryNetwork(
                            height: 200,
                            fit: BoxFit.cover,
                            placeholder: kTransparentImage,
                            image: pic.length == 0
                                ? "https://bsn.eu/wp-content/uploads/2016/12/user-icon-image-placeholder-300-grey.jpg"
                                : snaps.data["pic"],
                          ),
                        )
                      ],
                    ),
                    MaterialButton(
                          
                          color: Colors.brown[300],
                          onPressed: () {
                            _loadData();
                          },
                          child: Row(
                            children: <Widget>[
                              Text("Refresh", style: TextStyle(fontSize: 15)),
                              Icon(Icons.refresh, size: 35),
                            ],
                          ),
                        ),
                    SizedBox(
                      height: 8,
                    ),
                    Text("Name: ${snaps.data['name']}",style: TextStyle(fontSize: 17),),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                        'Current Class : ${snaps.data["teacherTime"][weekDay][current()]}',style: TextStyle(fontSize: 17),),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                        'Next Class : ${snaps.data["teacherTime"][weekDay][current() + 1==9?0:current()+1]}',style: TextStyle(fontSize: 17),),
                    SizedBox(
                      height: 8,
                    ),
                    RawMaterialButton(
                        fillColor: Colors.brown[200],
                        onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TeacherDetails(doc: snaps.data)))
                            },
                        child: Row(
                          children: [
                            Text(" View full Routine ",style: TextStyle(fontSize: 15),),
                            Icon(
                              Icons.view_module,
                            )
                          ],
                        ))
                  ],
                );}
                else{
                  return Center(child: CircularProgressIndicator(),);
                }
              })),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Search()))
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 11,
                  decoration: BoxDecoration(
                    border: Border.all(width: 3, color: Colors.grey[300]),
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(20)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                            enabled: false,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter teacher name '),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () => {},
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  )),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
              child: Text(
            "INSTITUTES",
            style: TextStyle(fontSize: 24),
          )),
          SizedBox(
            height: 10,
          ),
          _tiles("UIET", 1),
          SizedBox(
            height: 10,
          ),
          _tiles("UISH", 2),
          SizedBox(
            height: 10,
          ),
          _tiles("UICM", 3),
          SizedBox(
            height: 10,
          ),
          _tiles("UICIAS", 4),
          SizedBox(
            height: 10,
          ),
          _tiles("UIE", 5),
          SizedBox(
            height: 10,
          ),
          _tiles("UIL", 6),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}



