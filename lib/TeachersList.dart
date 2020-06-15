
import 'package:flutter/material.dart';
import 'TeacherDetails.dart';
import "Global.dart";
import 'package:cloud_firestore/cloud_firestore.dart';


class TeacherList extends StatelessWidget {
  String url="https://picsum.photos/250?image=9";

  final cse = Firestore.instance.collection('cse').orderBy('id');

  String weekDay = "Monday";

  Widget _buildGrid(context,docs) => Wrap(children:_buildGridTileList(context,docs));

  List<Padding> _buildGridTileList(context,docs) => List.generate(
      10,
      (i) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TeacherDetails(doc:docs[i],)),
                      )
                    },
                child: Container(
                    width: 180,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                        color: Colors.grey[200]),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                )
                                ,
                            width: 140,
                            height: 140,
                            child: 
                                  CircleAvatar(
                                      backgroundImage: NetworkImage(docs[i]['pic'].length==0?
                                 "https://bsn.eu/wp-content/uploads/2016/12/user-icon-image-placeholder-300-grey.jpg"
                                :docs[i]['pic'])
                                ),
                            
                          ),
                          Text(docs[i]['name']),
                          Text('Faculty : CSE'),
                          Text('current room : ${docs[i]["teacherTime"][weekDay][current()]}'),
                        ],
                      ),
                    ))),
          ));

  @override
  Widget build(BuildContext context) {
    var datetime = DateTime.now();

    if (datetime.weekday == 1) weekDay = "Monday";
    if (datetime.weekday == 2) weekDay = "Tuesday";
    if (datetime.weekday == 3) weekDay = "Wednesday";
    if (datetime.weekday == 4) weekDay = "Thursday";
    if (datetime.weekday == 5) weekDay = "Friday";
 
    return Scaffold(
      appBar: AppBar(
        title: Text("TeacherList"),
        centerTitle: true,
      ),
      body: 
      StreamBuilder(
        stream:cse.snapshots(),
        builder:(BuildContext context,AsyncSnapshot snapshot){
          if(snapshot.hasData){
         return ListView(children: [Center(child: _buildGrid(context,snapshot.data.documents))]);
          }
          else{
            return Center(child:CircularProgressIndicator(backgroundColor: Colors.brown[300],));
          }
        }
    )
    );
  }
}
