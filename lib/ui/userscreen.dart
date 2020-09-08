import 'package:flutter/material.dart';
import 'package:sqlbdd/model/user.dart';
import 'package:sqlbdd/db/database_helper.dart';

class UserScreen extends StatefulWidget {
  final User user;
  UserScreen(this.user);
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  DatabaseHelper db = DatabaseHelper();
  TextEditingController _ageConroller;
  TextEditingController _usernameConroller;
  TextEditingController _cityConroller;
  TextEditingController _passwordConroller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
 //   _ageConroller = new TextEditingController(text: widget.user.age);
    _usernameConroller = new TextEditingController(text: widget.user.username);
    _cityConroller = new TextEditingController(text: widget.user.city);
    _passwordConroller = new TextEditingController(text: widget.user.password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All users88"),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Container(
        margin: EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            TextField(
              controller: _usernameConroller,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            TextField(
              controller: _ageConroller,
              decoration: InputDecoration(labelText: 'Age'),
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            TextField(
              controller: _cityConroller,
              decoration: InputDecoration(labelText: 'city'),
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            TextField(
              controller: _passwordConroller,
              decoration: InputDecoration(labelText: 'password'),
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            RaisedButton(
              child: (widget.user.id != null) ? Text('update') : Text("save"),
              color: Colors.deepPurpleAccent,
              onPressed: () {
                if (widget.user.id != null) {
                  db
                      .updateUser(User.fromMap({
                    'id': widget.user.id,
                  //  'age': widget.user.age,
                    'username':_usernameConroller.text,
                    'city': _cityConroller.text,
                  }))
                      .then((_) {
                    Navigator.pop(context, 'update');
                  });
                } else {
                  db
                      .saveUser(User(
                          _usernameConroller.text,
                          _passwordConroller.text,
                          _cityConroller.text,
                     //     _ageConroller.text
                          ))
                      .then((_) {
                    Navigator.pop(context, 'save');
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
