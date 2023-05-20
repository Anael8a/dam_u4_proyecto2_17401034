import 'package:dam_u4_proyecto2_17401034/home.dart';
import 'package:dam_u4_proyecto2_17401034/pages/actualizarasignacion.dart';
import 'package:dam_u4_proyecto2_17401034/pages/asignacion.dart';
import 'package:dam_u4_proyecto2_17401034/pages/insertasignacion.dart';
import 'package:dam_u4_proyecto2_17401034/pages/insertasistencia.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dam_u4_proyecto2_17401034/services/bd_services.dart';

import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),initialRoute: '/',
      routes: {
        '/' :(context) => const HomePricipal(),
        '/Asignacion':(context) => const Asignacion(),
        '/insertAsignacion': (context) => const insertAsignacion(),
        '/actualizarAsignacion': (context) => const ActualizarAsignacion(),
       // '/insertarAsistencia':(context) => const insertAsistencia(asignacionid: 'asignacionid'),
      },
    );
  }
}
