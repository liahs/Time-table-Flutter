import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'TeacherDetails.dart';
final cse = Firestore.instance.collection('cse').orderBy('id');

class Search extends StatefulWidget{
@override
SearchState createState()=>SearchState();
}

class SearchState extends State<Search>{

String name="";

bool isSubString(s1,s2){
       RegExp exp=RegExp("$s1");
       return exp.hasMatch(s2);
} 

Widget _listtile(docs,context){
  var x=docs.length;
  List<Padding> names=[];
  for(var i=0;i<x;i++){
    if(isSubString(name.trim().toLowerCase(),docs[i]['name'].trim().toLowerCase()))
      { 
        print('hello');
        names.add(
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: ()=>{
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TeacherDetails(doc: docs[i])))
            },
            child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey[200],
                width: 1.5         
                 )
            ),
            width: MediaQuery.of(context).size.width,
            child:Column(
              children:[
                SizedBox(height: 5,),
                Text(docs[i]['name'],style: TextStyle(fontSize: 18),)
                ,SizedBox(height: 5,),
                Text("Faculty : CSE"),
                SizedBox(height: 5,),
              ])
            ),
          ),
        )
        );}
    }

  return ListView(
    children:names.isEmpty?[Center(child: Text('Nothing Matches'))]:names
  );
}
@override
Widget build(BuildContext context){
  return Scaffold(
    body:ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
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
                        IconButton(
                        icon: Icon(Icons.arrow_back),
                          onPressed: () => {
                            Navigator.pop(context)
                            },
                        ),
                        Flexible(

                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: TextField(
                              autofocus: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter teacher name '
                                  ),
                                  onChanged: (txt)=>{
                                    setState((){
                                      name=txt;
                                    })
                                  },
                            ),
                          ),
                        ),
                      
                       
                      ],
                    )),
        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height:  MediaQuery.of(context).size.height-(MediaQuery.of(context).size.height / 11)-34,
                          child: StreamBuilder(
                            stream: cse.snapshots(),
                            builder: (context,snaps){
                              if(snaps.hasData){
                              return _listtile(snaps.data.documents,context);
                              }
                              else{
                                return Center(child: CircularProgressIndicator(),);
                              }
                            },
                          ),
                        )
      ],
    ),
  );
}
}