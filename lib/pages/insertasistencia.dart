import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dam_u4_proyecto2_17401034/services/bd_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class insertAsistencia extends StatefulWidget {
  final String asignacionid;
  const insertAsistencia({Key? key, required this.asignacionid})
      : super(key: key);

  @override
  State<insertAsistencia> createState() => _insertAsistenciaState();
}

class _insertAsistenciaState extends State<insertAsistencia> {
  DateTime selectedFecha = DateTime.now();
  DateTime selectedHora = DateTime.now();
  TextEditingController revisorControler = TextEditingController();
  String fechahora ='';

  @override
  Widget build(BuildContext context) {
    setState(() {

      fechahora =
      'Fecha: ${selectedFecha.day.toString() +'/'+ selectedFecha.month.toString() +'/'+ selectedFecha.year.toString()} '
          'Hora: ${selectedHora.hour.toString() +':'+ selectedHora.minute.toString()}';
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("Insertar Asistencias"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            TextButton(
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: selectedFecha,
                  firstDate: DateTime(2015, 5),
                  lastDate: DateTime(2222),
                );
                final TimeOfDay? pickedH = await showTimePicker(
                    context: context, initialTime: TimeOfDay.fromDateTime(selectedHora));
                if (picked != null && picked != selectedFecha &&
                    pickedH !=  null && pickedH != selectedHora) {
                  setState(() {
                    selectedFecha=picked;
                    selectedHora = DateTime(selectedFecha.year, selectedFecha.month,selectedFecha.day, pickedH!.hour,pickedH.minute);
                    fechahora =
                        'Fecha: ${selectedFecha.day.toString() +'/'+ selectedFecha.month.toString() +'/'+ selectedFecha.year.toString()} '
                        'Hora: ${selectedHora.hour.toString() +':'+ selectedHora.minute.toString()}';
                  });
                }
              },
              child:
                  Text('Fecha/hora: ${DateFormat.yMd().format(selectedFecha)}'),
            ),
            TextField(
              controller: revisorControler,
              decoration: const InputDecoration(labelText: "Revisor"),
            ),
            ElevatedButton(
              onPressed: () async {
                print("si jala");
                await insertarAsistencias(widget.asignacionid, {
                  "fechahora": fechahora,
                  "revisor": revisorControler.text
                }).then((_) {
                  Navigator.pop(context);
                });
                print("No esta jalando");
              },
              child: const Text("Insertar"),
            )
          ],
        ),
      ),
    );
  }
}
