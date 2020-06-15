import 'package:flutter/material.dart';
import 'Global.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherDetails extends StatefulWidget {
  final  doc;
  TeacherDetails({Key key, this.doc}) : super(key: key);

  @override
  _TeacherDState createState() => _TeacherDState();
}

class _TeacherDState extends State<TeacherDetails> {
  var datetime = DateTime.now();
  String weekDay = "Monday";
  String tempDay = "Monday";
  

  //Loading counter value on start
  _setProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("pic", widget.doc['pic']);
    prefs.setString("name", widget.doc['name']);
    prefs.setInt("id", widget.doc['id']);
  }
  
Future<void> _setDialog() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Rewind and remember'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Do you want to set this as a profile ???'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            color: Colors.brown[300],
            child: Text('Yes'),
            onPressed: () {
              _setProfile();
              Navigator.of(context).pop();
            },
          ),

          FlatButton(
            color: Colors.brown[300],
            child: Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (datetime.weekday == 1) weekDay = "Monday";
    if (datetime.weekday == 2) weekDay = "Tuesday";
    if (datetime.weekday == 3) weekDay = "Wednesday";
    if (datetime.weekday == 4) weekDay = "Thursday";
    if (datetime.weekday == 5) weekDay = "Friday";
    tempDay = weekDay;
    
  }

  @override
  Widget build(BuildContext context) {
    var day = datetime.weekday;
    var schedule = widget.doc["teacherTime"];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.doc['name']),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: ()=>{
                _setDialog()
            },
            icon: Icon(Icons.add),
            iconSize: 30,
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Container(
                    height: 140,
                    width: MediaQuery.of(context).size.width / 4,
                    child: Image(
                      image: NetworkImage(widget.doc['pic']),
                      fit: BoxFit.contain,
                    )),
                SizedBox(
                  width: 8,
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Name : ${widget.doc["name"]}',
                      style: TextStyle(fontSize: 18),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:12 ),
                      child: Container(
                            width: MediaQuery.of(context).size.width-(MediaQuery.of(context).size.width / 4)-24,
                            child: Text(
                            'Subjects : ${widget.doc['subjTeach']}',
                            style: TextStyle(fontSize: 16),
                            overflow: TextOverflow.fade,
                            
                          )),
                    ), 
                       
                    Text('Current room: ${widget.doc["teacherTime"][tempDay][current()]}',
                        style: TextStyle(fontSize: 17)),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Text(
            'TimeTable ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            'Date : ${datetime.year}/${datetime.month}/${datetime.day}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Wrap(
              alignment: WrapAlignment.spaceEvenly,
              spacing: 10.0,
              children: <Widget>[
                RawMaterialButton(
                  fillColor:
                      day == 1 ? Colors.lightGreen[200] : Colors.grey[200],
                  onPressed: () => {
                    setState(() {
                      weekDay = "Monday";
                    })
                  },
                  child: Text(
                    "  Monday  ",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                RawMaterialButton(
                  fillColor: day == 2 ? Colors.lightGreen[200] : Colors.grey[200],
                  onPressed: () => {
                    setState(() {
                      weekDay = "Tuesday";
                    })
                  },
                  child: Text(
                    "  Tuesday  ",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                RawMaterialButton(
                  fillColor: day == 3 ? Colors.lightGreen[200] : Colors.grey[200],
                  onPressed: () => {
                    setState(() {
                      weekDay = "Wednesday";
                    })
                  },
                  child: Text(
                    "  Wednesday  ",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                RawMaterialButton(
                  fillColor: day == 4 ? Colors.lightGreen[200] : Colors.grey[200],
                  onPressed: () => {
                    setState(() {
                      weekDay = "Thursday";
                    })
                  },
                  child: Text(
                    "  Thursday  ",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                RawMaterialButton(
                  fillColor: day == 5 ? Colors.lightGreen[200] : Colors.grey[200],
                  onPressed: () => {
                    setState(() {
                      weekDay = "Friday";
                    })
                  },
                  child: Text(
                    "  Friday  ",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              border: TableBorder.all(color: Colors.grey[300]),
              children: [
                TableRow(
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "  Time Period",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            Text("  Room no.", style: TextStyle(fontSize: 18)),
                      )
                    ]),
                TableRow(
                  decoration: BoxDecoration(color:current()==0?Colors.lightGreen[200]:Colors.white),
                  children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("  9:00-10:00"),
                  ),
                  Text(schedule[weekDay][0])
                ]),
                TableRow(
                  decoration: BoxDecoration(color:current()==1?Colors.lightGreen[200]:Colors.white),
                  children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("  10:00-10:55"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(schedule[weekDay][1]),
                  )
                ]),
                TableRow(
                  decoration: BoxDecoration(color:current()==2?Colors.lightGreen[200]:Colors.white),
                  children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("  10:55-11:05"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(schedule[weekDay][2]),
                  )
                ]),
                TableRow(
                  decoration: BoxDecoration(color:current()==3?Colors.lightGreen[200]:Colors.white),
                  children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("  10:55-12:00"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(schedule[weekDay][3]),
                  )
                ]),
                TableRow(
                  decoration: BoxDecoration(color:current()==4?Colors.lightGreen[200]:Colors.white),
                  children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("  12:00-12:55"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(schedule[weekDay][4]),
                  )
                ]),
                TableRow(
                  decoration: BoxDecoration(color:current()==5?Colors.lightGreen[200]:Colors.white),
                  children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("  12:55-01:40"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(schedule[weekDay][5]),
                  )
                ]),
                TableRow(
                  decoration: BoxDecoration(color:current()==6?Colors.lightGreen[200]:Colors.white),
                  children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("  01:40-02:35"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(schedule[weekDay][6]),
                  )
                ]),
                TableRow(
                  decoration: BoxDecoration(color:current()==7?Colors.lightGreen[200]:Colors.white),
                  children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("  02:35-03:30"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(schedule[weekDay][7]),
                  )
                ]),
                TableRow(
                  decoration: BoxDecoration(color:current()==8?Colors.lightGreen[200]:Colors.white),
                  children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("  03:30-04:30"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(schedule[weekDay][8]),
                  )
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
