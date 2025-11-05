import 'package:flutter/material.dart';
import 'views/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// importei o supabase e mudei o void main
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://irghblnebfitvqlociwh.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlyZ2hibG5lYmZpdHZxbG9jaXdoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjEwNjYxNTcsImV4cCI6MjA3NjY0MjE1N30.iDTsUSEZX-BZS1SGSPCasnPOfxt_bZHqo0napLEEitg',
  );

  runApp(NotasApp());
}