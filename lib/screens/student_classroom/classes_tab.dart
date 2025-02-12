import 'package:online_classroom/data/accounts.dart';
import 'package:online_classroom/data/classrooms.dart';
import 'package:online_classroom/data/custom_user.dart';
import 'package:online_classroom/screens/student_classroom/class_room_page.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
class ClassesTab extends StatefulWidget {

  @override
  _ClassesTabState createState() => _ClassesTabState();
}

class _ClassesTabState extends State<ClassesTab> {
  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    var account = getAccount(user!.uid);
    List _classRoomList = classRoomList.where((i) => i.students.contains(account)).toList();


    return ListView.builder(
        itemCount: _classRoomList.length,
        itemBuilder: (context, int index) {
          return GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => ClassRoomPage(
                  uiColor: _classRoomList[index].uiColor,
                  classRoom: _classRoomList[index],
                ))),
            child: Stack(
              children: [
                Container(
                  height: 100,
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    // image: DecorationImage(
                    //   fit: BoxFit.cover, image: classRoomList[index].bannerImg,),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    border: Border.all(color: const Color.fromARGB(94, 22, 22, 22), width: 2),
                    color: _classRoomList[index].uiColor,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30, left: 30),
                  width: 220,
                  child: Text(
                    _classRoomList[index].className,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 58, left: 30),
                  child: Text(
                    _classRoomList[index].description,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        letterSpacing: 1),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 80, left: 30),
                  child: Text(
                    _classRoomList[index].creator.firstName! ,
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        letterSpacing: 1),
                  ),
                ),
                // Add the Switch widget
              ],
            ),
          );
        });
  }
}
