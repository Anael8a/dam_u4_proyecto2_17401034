import 'package:dam_u4_proyecto2_17401034/pages/asignacion.dart';
import 'package:dam_u4_proyecto2_17401034/pages/asistencia.dart';
import 'package:dam_u4_proyecto2_17401034/pages/consultacuatro.dart';
import 'package:dam_u4_proyecto2_17401034/pages/consultados.dart';
import 'package:dam_u4_proyecto2_17401034/pages/consultas.dart';
import 'package:flutter/material.dart';
class HomePricipal extends StatefulWidget {
  const HomePricipal({Key? key}) : super(key: key);

  @override
  State<HomePricipal> createState() => _HomePricipalState();
}

class _HomePricipalState extends State<HomePricipal> {
  int _indice = 0;

  void _cambiarIndice(int indice){
    setState(() {
      _indice=indice;
    });
  }
  final List<Widget> _paginas=[
    Asignacion(),
          Consultas(),
    ConsultaCuatro(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _indice == 1 ? Colors.blueGrey[200]: Colors.white,
      body: _paginas[_indice],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label:"Asignacion",),
          BottomNavigationBarItem(icon: Icon(Icons.insert_drive_file_outlined),label: "Consultas"),
          BottomNavigationBarItem(icon: Icon(Icons.insert_drive_file_outlined),label: "Consulta Cuatro"),
          //BottomNavigationBarItem(icon: Icon(Icons.insert_drive_file_outlined),label: "Consulta dos"),


        ],
        currentIndex: _indice,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.blue[200],
        showUnselectedLabels: false,
        iconSize: 25,
        backgroundColor: Colors.blueGrey[100],

        onTap: _cambiarIndice,
      ),
    );
  }
}
