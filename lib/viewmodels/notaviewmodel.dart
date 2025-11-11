import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/nota.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotaViewModel extends ChangeNotifier {
  // realizando a comunicação com banco de dados da Supabase
  final SupabaseClient client = Supabase.instance.client;
  final String table = 'Notas';

  List<Nota> _notas = [];

  List<Nota> get notas => _notas;

   // CREATE
  Future<void> create(Nota nota) async {
    nota.id = const Uuid().v4();

    await client.from(table).insert({
      'id': nota.id,
      'title': nota.title,
      'date': nota.date.toIso8601String(), // Converte data para formato ISO
    });

    _notas.add(nota);
    notifyListeners();
  }

  // READ
  Future<void> read() async {
    final data = await client.from(table).select();
    //Converte os dados do Supabase (JSON) em objetos Nota
    _notas = (data as List<dynamic>)
        .map((e) => Nota.fromJson(Map<String, dynamic>.from(e)))
        .toList();
    notifyListeners();
  }

  // UPDATE
  Future<void> update(Nota nota) async {
    await client
        .from(table)
        .update({
          'title': nota.title,
          'date': nota.date.toIso8601String(),
        })
        .eq('id', nota.id);

    final index = _notas.indexWhere((e) => e.id == nota.id);
    if (index != -1) {
      _notas[index] = nota;
      notifyListeners();
    }
  }

  // DELETE
  Future<void> delete(String id) async {
    await client.from(table).delete().eq('id', id);
    _notas.removeWhere((e) => e.id == id);
    notifyListeners();
  }
}