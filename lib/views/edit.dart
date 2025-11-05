import 'package:flutter/material.dart';
import 'package:notas_app/models/nota.dart';
import 'package:provider/provider.dart';

import '../viewmodels/notaviewmodel.dart';

class EditPage extends StatelessWidget {

  TextEditingController ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var nota = ModalRoute.of(context)!.settings.arguments as Nota;
    ctrl.text = nota.title;

    return Scaffold(
      appBar: AppBar(
        title: Text("Edita Nota"),
        actions: [
          IconButton(
            onPressed: () {
              var provider = Provider.of<NotaViewModel>(context, listen: false);
              nota.title = ctrl.text;
              provider.update(nota);

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