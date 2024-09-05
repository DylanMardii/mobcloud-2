import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'MyApp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: "https://kbmyebncsevyuxdmfdzq.supabase.co/",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtibXllYm5jc2V2eXV4ZG1mZHpxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjU1MjA2NDgsImV4cCI6MjA0MTA5NjY0OH0.1blUE3aH0rJrbMTq1eA7AFaVhHJJuiS21pIU_ntByCo");

  runApp(MyApp());
}
