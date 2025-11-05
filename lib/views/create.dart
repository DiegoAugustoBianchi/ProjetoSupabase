import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/nota.dart';
import '../viewmodels/notaviewmodel.dart';

class CreatePage extends StatelessWidget {

  TextEditingController ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nova Nota"),
        actions: [
          IconButton(
            onPressed: () {
              // Salvar num banco de dados local (em memória).
              var provider = Provider.of<NotaViewModel>(context, listen: false);
              provider.create(Nota("1", ctrl.text, DateTime.now()));
              Navigator.pop(context);
            },
            icon: Icon(Icons.save)
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: TextField(
          controller: ctrl,
          keyboardType: TextInputType.multiline,
          minLines: 1,
          maxLines: null,
          decoration: InputDecoration(
            hintText: "Digite suas anotações...",
            border: InputBorder.none,
          ),
        ),
      )
    );
  }
}