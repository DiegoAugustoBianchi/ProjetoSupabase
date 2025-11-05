import 'package:flutter/material.dart';
import 'package:notas_app/viewmodels/notaviewmodel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<NotaViewModel>(context, listen: true);

    return Scaffold(
      appBar: AppBar(title: Text("Notas")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, "/create"),
        child: Icon(Icons.add),
      ),
      body: ListView(
        children: provider.notas.map((nota) => Dismissible(
          background: Container(color: Colors.red),
          onDismissed: (_) => provider.delete(nota.id),
          key: Key(nota.id),
          child: ListTile(
            onTap: () => Navigator.pushNamed(context, '/edit', arguments: nota),
            title: Text(
              nota.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(DateFormat.yMd('en_US').format(nota.date)),
            trailing: Icon(Icons.chevron_right_outlined),
          ),
        )).toList()
      ),
    );
  }
}