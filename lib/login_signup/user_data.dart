import 'package:flutter/material.dart';
import 'user_model.dart';
import 'user-api.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserData extends StatefulWidget {
  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Data'),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  User api = snapshot.data[index];
                  int cnt=0;
                  cnt =cnt+1;
                  return Table(
                    columnWidths: {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(6),
                      2: FlexColumnWidth(4),
                    },
                    border: TableBorder.all(width:1.3, color:Colors.black45), //table border
                    children: [
                      TableRow(
                          children: [
                            TableCell(child: Center(child: Text("\n\n$cnt",textAlign:TextAlign.center,),)),
                            TableCell(
                              child: Column(
                                children: <Widget>[
                                  Text("\n${api.name}"),
                                  Text("${api.studentId}"),
                                  Text("${api.disciplineName}"),
                                  Text("${api.phone}\n"),
                                ],
                              ),
                            ),
                            TableCell(child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RoundIconButton(
                                    icon: FontAwesomeIcons.solidEdit,
                                    onPressed: () {
                                    },
                                    color: Colors.greenAccent,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RoundIconButton(
                                    icon: FontAwesomeIcons.solidTrashAlt,
                                    onPressed: () {
                                    },
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ],
                            ),),
                          ]
                      ),
                    ],);
                },
              );
            }
            ;
          },
        ),
      ),
    );
  }
}

class RoundIconButton extends StatelessWidget {

  RoundIconButton({@required this.icon,@required this.onPressed,this.color});
  final IconData icon;
  final Function onPressed;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(icon,color: Colors.black87,),
      elevation: 0.0,
      shape: CircleBorder(),
      fillColor:color,
      constraints:BoxConstraints.tightFor(
        width: 45.0,
        height: 45.0,
      ),
      onPressed: onPressed,

    );
  }
}
