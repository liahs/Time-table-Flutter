import 'package:collage_timer/TeachersList.dart';
import 'package:flutter/material.dart';

class Faculty extends StatefulWidget{
  @override 
  _FacultyState createState()=>_FacultyState();
}

class _FacultyState extends State<Faculty>{
  Widget mat(String fac){
    return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              borderRadius: BorderRadius.circular(10.0),
              elevation: 4.0,
            child:InkWell(
               borderRadius: BorderRadius.circular(10.0),
            onTap: ()=>{
                 Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>TeacherList()),
              )
              },
              child:SizedBox(
                height: 60,
                child: Center(child:Text(fac,style: TextStyle(fontSize: 18),))),
            ),
          ),
          );
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("UIET Faculty"),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          mat('Computer Science & Engineering'),
          mat('Electronics  & Communication Engineering'),
          mat('Electrical Engineering'),
          mat('Mechanical Engineering'),
          mat('Civil Engineering'),
        ],
      ),
    );
  }
}