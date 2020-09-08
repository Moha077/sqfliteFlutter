

import 'package:flutter/material.dart';
import 'package:sqlbdd/ui/listViewUsers.dart';


List myUsers ;
void main()  {  
  runApp(new MaterialApp(
title: "Users DB",
debugShowCheckedModeBanner: false,
home: ListViewUsers(),
)
);

}

