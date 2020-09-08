import 'package:flutter/material.dart';
import 'package:sqlbdd/model/user.dart';
import 'package:sqlbdd/db/database_helper.dart';
import 'package:sqlbdd/ui/userscreen.dart';

class ListViewUsers extends StatefulWidget {
  @override
  _ListViewUsersState createState() => _ListViewUsersState();
}

class _ListViewUsersState extends State<ListViewUsers> {
  List<User> items = new List();
  DatabaseHelper db = new DatabaseHelper();

  @override
  void initState() {
    super.initState();
    db.getAllUsers().then((users) {
      setState(() {
        users.forEach((user) {
          items.add(User.fromMap(user));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "all users",
        home: Scaffold(
          appBar: AppBar(
            title: Text("All users"),
            centerTitle: true,
            backgroundColor: Colors.purple,
          ),
          body:(items.length ==0)? Center(child:Text("the list is empty ",style: TextStyle(fontSize: 50,color:Colors.black38),)): Center(
            child: ListView.builder(
                itemCount: items.length,
                padding: const EdgeInsets.all(11.0),
                itemBuilder: (context, position) {
                  return  Column(
                    children: <Widget>[
                      Divider(height: 5.0),
                      ListTile(
                          isThreeLine: true,
                        title: Text(
                          '${items[position].username} ',
                          style: TextStyle(fontSize: 22.0, color: Colors.blue),
                        ),
                        subtitle: Text(
                            '${items[position].city}',
                            style:
                                TextStyle(fontSize: 22.0, color: Colors.blue)),
                                 trailing:  IconButton(
                                icon: Icon(Icons.delete, color: Colors.black,size: 35.0,),
                                onPressed: () => {
                                      _deleteUsers(
                                          context, items[position], position)
                                    }
                                    ),
                        leading: Column(
                    
                          children: <Widget>[
                        //    Padding(padding: EdgeInsets.all(10.0)),
                        
                            CircleAvatar(
                              radius: 15.0,
                              backgroundColor: Colors.red,

                              child: Center(
                                child: Text(
                                  '${items[position].id} ',
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.white),
                                ),
                              ),
                            ),
                            
                           
                          ],
                        ),
                        onTap: () => _navigateToUser(context, items[position]),
                      ),
                    ],
                  );
                }),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.deepOrange,
            onPressed: ()=>  _createNewUser(context),
          ),
        ));
  }
  _deleteUsers(BuildContext context, User user,int position) async{
db.deleteUser(user.id).then((users){
  setState(() {
    items.removeAt(position);
  });  
});


  }
  void _navigateToUser(BuildContext context, User user)async{

    String result = await Navigator.push(context,
    
     MaterialPageRoute(builder: (context)=>UserScreen(user)));

     if (result=="update") {
       db.getAllUsers().then((users){
setState(() {
 items.clear();
 users.forEach((user){
items.add(User.fromMap(user));

 }); 
});
       });
     }

  }
  void _createNewUser(BuildContext context)async{

String result = await Navigator.push(context,
    
     MaterialPageRoute(builder: (context)=>UserScreen(User(" "," "," "))));

     if (result=="save") {
       db.getAllUsers().then((users){
setState(() {
 items.clear();
 users.forEach((user){
items.add(User.fromMap(user));

 }); 
});
       });
     }
  }
}
