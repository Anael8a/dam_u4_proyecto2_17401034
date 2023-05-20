import 'package:dam_u4_proyecto2_17401034/services/bd_services.dart';
import 'package:flutter/material.dart';


class ActualizarAsignacion extends StatefulWidget {
  const ActualizarAsignacion({Key? key}) : super(key: key);

  @override
  State<ActualizarAsignacion> createState() => _ActualizarAsignacionState();
}

class _ActualizarAsignacionState extends State<ActualizarAsignacion> {

  TextEditingController salonControler = TextEditingController();
  TextEditingController edificioControler = TextEditingController();
  TextEditingController horarioControler = TextEditingController();
  TextEditingController docenteControler = TextEditingController();
  TextEditingController materiaControler = TextEditingController();


  @override
  Widget build(BuildContext context) {

    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map? ?? {};
    if (arguments.isNotEmpty) {
      salonControler.text = arguments['salon'] ?? '';
      edificioControler.text = arguments['edificio'] ?? '';
      horarioControler.text = arguments['horario'] ?? '';
      docenteControler.text = arguments['docente'] ?? '';
      materiaControler.text = arguments['materia'] ?? '';

    }



    return Scaffold(
      appBar: AppBar(title: Text("Actualizar Asignacion"), centerTitle: true,backgroundColor: Colors.teal),
    body: Padding(
      padding: EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(controller: salonControler, decoration: InputDecoration(labelText: "Salon"),),
            TextField(controller: edificioControler, decoration: InputDecoration(labelText: "Edificio"),),
            TextField(controller: horarioControler, decoration: InputDecoration(labelText: "Horario "),),
            TextField(controller: docenteControler, decoration: InputDecoration(labelText: "Docente"),),
            TextField(controller: materiaControler, decoration: InputDecoration(labelText: "Materia"),),
            ElevatedButton(onPressed: ()async{
              await actualizarAsignacion(arguments['uid'], salonControler.text, edificioControler.text,
                  horarioControler.text, docenteControler.text, materiaControler.text).then((value) {
                    Navigator.pop(context);
              });
            }, child: const Text("Actualizar")),
          ],
        ),
      ),
    ),
    );
  }
}
