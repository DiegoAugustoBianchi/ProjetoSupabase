import 'package:flutter/material.dart';
import 'list.dart';
import 'create.dart';
import 'edit.dart';
import 'package:provider/provider.dart';
import '../viewmodels/notaviewmodel.dart';

class NotasApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NotaViewModel()..read(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "/list": (context) => ListPage(),
          "/create": (context) => CreatePage(),
          "/edit": (context) => EditPage(),
        },
        initialRoute: "/list",
      ),
    );
  }
}