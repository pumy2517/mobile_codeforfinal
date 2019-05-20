import 'package:flutter/material.dart';
import '../model/state.dart';
import '../model/userDB.dart';

UserProvider user = UserProvider();


class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}


class HomePageState extends State<HomePage> {
  final color = const Color(0xffb71c1c);
  
  //ดึงข้อมูลsqlแบบสอง
  // List<User> listuser;
  // void getUserList() async{
  //   await user.open("user.db");
  //   Future<List<User>> allUser = user.getAllUser();
  //   this.listuser = await allUser;
    
  // }

  @override
  Widget build(BuildContext context) {
    
    //ดุงข้อมูลsqlแบบสอง
    // getUserList();
    // print(listuser);
    
    return Scaffold(
      appBar: AppBar(
        title: Text("HOME"),
        automaticallyImplyLeading: false,
        backgroundColor: color,
      ),
      body: Container(

        //ดึงข้อมูลจากstate
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
          children: <Widget>[
            ListTile(
              title: Text('Hello ${CurrentUser.NAME}'),
              subtitle: Text('this is my quote "${CurrentUser.QUOTE}"'),
            ),
            RaisedButton(
              child: Text("PROFILE SETUP"),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/profile');
              },
            ),
            RaisedButton(
              child: Text("MY FRIENDS"),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/friend');
              },
            ),
            RaisedButton(
              child: Text("SIGN OUT"),
              onPressed: () {
                CurrentUser.USERID = null;
                CurrentUser.NAME = null;
                CurrentUser.AGE = null;
                CurrentUser.PASSWORD = null;
                CurrentUser.QUOTE = null;
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
          ],
        ),

        //ดึงข้อมูลsqlแบบแรก
        // child: FutureBuilder<List<User>>(
        //   future: user.getAllUser(),
        //   builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot){
        //     switch (snapshot.connectionState) {
        //           case ConnectionState.none:
        //           case ConnectionState.waiting: 
        //             return new Text('loading...');
        //           default:
        //             if (snapshot.hasError) {
        //               return new Text('Error: ${snapshot.error}');
        //             } else {
        //               return createListView(context, snapshot);
        //             }
        //         }
        //   },
        // ),


          //ดึงข้อมูลsqlแบบสอง
          //   child: ListView.builder(
          //   itemCount: this.listuser.length,
          //   itemBuilder: (context,int position){
          //     return Column(
          //         children: <Widget>[
          //           Divider(
          //             height: 5.0,
          //           ),
          //           ListTile(
          //             title: Text(this.listuser[position].name,
          //               style: TextStyle(
          //                 fontSize: 20,
          //               ),
          //             ),
          //           )
          //         ],
          //       );
          //   },
          // ),


      ),
    );
  }

  //ดึงข้อมูลsqlแบบแรก
  // Widget createListView(BuildContext context, AsyncSnapshot<List<User>> snapshot){
  //   List<User> values = snapshot.data;
  //   return values.length != 0 ? 
  //                 ListView.builder(
  //                   itemCount: values.length,
  //                   itemBuilder: (context,int position){
  //                   return Column(
  //                       children: <Widget>[
  //                         Divider(
  //                           height: 5.0,
  //                         ),
  //                         ListTile(
  //                           title: Text("${values[position].name}  ${values[position].quote}",
  //                             style: TextStyle(
  //                               fontSize: 20,
  //                             ),
  //                           ),
  //                         )
  //                       ],
  //                     );
  //                 },
  //                 )
  //                 //Nope
  //                 : Center(
  //                   child: Text("No Data Found.."),
  //   );
  // }
}
