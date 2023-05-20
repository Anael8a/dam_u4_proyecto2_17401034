import 'package:dam_u4_proyecto2_17401034/services/bd_services.dart';
import 'package:flutter/material.dart';

class insertAsignacion extends StatefulWidget {
  const insertAsignacion({Key? key}) : super(key: key);

  @override
  State<insertAsignacion> createState() => _insertAsignacionState();
}

class _insertAsignacionState extends State<insertAsignacion> {
  TextEditingController salonControler = TextEditingController();
  TextEditingController edificioControler = TextEditingController();
  TextEditingController horarioControler = TextEditingController();
  TextEditingController docenteControler = TextEditingController();
  TextEditingController materiaCotnroler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Insertar Asignacion"),backgroundColor: Colors.teal),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: salonControler, decoration: InputDecoration(labelText: "Salon"),),
              TextField(controller: edificioControler, decoration: InputDecoration(labelText: "edificio"),),
              TextField(controller: horarioControler, decoration: InputDecoration(labelText: "Horario 10:00am"),),
              TextField(controller: docenteControler, decoration: InputDecoration(labelText: "Docente"),),
              TextField(controller: materiaCotnroler, decoration: InputDecoration(labelText: "Materia"),),

              ElevatedButton(onPressed: ()async{
                await inserAsignacion(salonControler.text, edificioControler.text, horarioControler.text
                    , docenteControler.text, materiaCotnroler.text).then((value){
                      Navigator.pop(context);
                });
              }, child: Text("Insertar"))

            ],
          ),
        ),
      ),
    );
  }
}
