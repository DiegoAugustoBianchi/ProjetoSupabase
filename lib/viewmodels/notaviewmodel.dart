import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/nota.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotaViewModel extends ChangeNotifier {
  final SupabaseClient client = Supabase.instance.client;
  final String table = 'Notas';

  List<Nota> _notas = [];

  List<Nota> get notas => _notas;

  // código novo para CRUD

  // CREATE
  Future<void> create(Nota nota) async {
    // gera id uuid se não tiver
    nota.id = const Uuid().v4();

    try {
      await client.from(table).insert({
        'id': nota.id,
        'title': nota.title,
        // enviar string ISO para o postgres timestamptz
        'date': nota.date.toIso8601String(),
      });

      _notas.add(nota);
      notifyListeners();
    } catch (e) {

      // Msg de erro simples
      print('Erro ao criar nota: $e');

    }
  }

  // READ
  Future<void> read() async {
    try {
      // Seleciona todas as colunas
      final data = await client.from(table).select();
      _notas = (data as List<dynamic>)
          .map((e) => Nota.fromJson(Map<String, dynamic>.from(e)))
          .toList();
      notifyListeners();
    } catch (e) {

      // Msg de erro simples
      
      print('Erro ao ler notas: $e');
    }
  }

  // UPDATE
  Future<void> update(Nota nota) async {
    try {
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
    } catch (e) {

      // Msg de erro simples

      print('Erro ao atualizar nota: $e');
    }
  }

  // DELETE
  Future<void> delete(String id) async {
    try {
      await client.from(table).delete().eq('id', id);
      _notas.removeWhere((e) => e.id == id);
      notifyListeners();
    } catch (e) {

      // Msg de erro simples

      print('Erro ao deletar nota: $e');
    }
  }
}