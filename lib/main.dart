import 'package:provider/provider.dart';
import 'pages/homepage.dart';
import 'pages/editform.dart';
import 'package:flutter/material.dart';
import './pages/Add.dart';
import './Components/record.dart';

void main() {
  runApp(
    MaterialApp(
      home: new Homepage(),
      title: "Navbar",
      routes: <String, WidgetBuilder>{
        '/Home': (BuildContext Context) => Homepage(),
        '/EditForm': (BuildContext Context) => EditForm(),
        '/Add': (BuildContext Context) => Add(),
      },
    ),
  );

  ChangeNotifierProvider(
    create: (context) => KeuanganProvider(),
    child: (),
  );
}
