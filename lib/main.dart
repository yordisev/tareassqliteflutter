import 'package:alarmasqlite/config/temas.dart';
import 'package:alarmasqlite/db/basededatos.dart';
import 'package:alarmasqlite/screens/inicio.dart';
import 'package:alarmasqlite/services/temas_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  await GetStorage.init();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Alarma Nueva',
      debugShowCheckedModeBanner: false,
      theme: Temas.modoclaro,
      darkTheme: Temas.modooscuro,
      themeMode: TemasServices().theme,
      home: InicioScreen(),
    );
  }
}
