import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dam_u4_proyecto2_17401034/services/bd_services.dart';

class Consultados extends StatefulWidget {
  @override
  _ConsultadosState createState() => _ConsultadosState();
}

class _ConsultadosState extends State<Consultados> {
  DateTime selectedFecha = DateTime.now();
  DateTime selectedHora = DateTime.now();


  Future<List<Map<String, dynamic>>>? asistenciaFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Consultar asistencias de un rango de fechas para todos los maestros en todos los salones"),),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('Seleccione Fecha: ${selectedFecha.toLocal()}'),
              onTap: _selectedDate,

            ),
            ListTile(
              title: Text('Seleccione Fecha: ${selectedHora.toLocal()}'),
              onTap: _selectedDate,

            ),

            ElevatedButton(onPressed: (){
              setState(() {
                asistenciaFuture= getAsistenciasPorRangoFechas(selectedFecha, selectedHora);
              });
            }, child: Text("Buscar")),

            Expanded(child: FutureBuilder<List<Map<String, dynamic>>>(
              future: asistenciaFuture,
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator(),);
                }else if(snapshot.hasError){
                  return const Center(child: Text("Ha ocurrido un error"),);
                }else{

                  final asistencias = snapshot.data ?? [];
                  print(asistencias);
                  return ListView.builder(
                    shrinkWrap: true,
                      itemCount: asistencias.length,
                      itemBuilder: (context,index){
                        print("si jala");
                        final asistencia=asistencias[index];
                        return ListTile(

                          title:Text('Fecha: ${(asistencia['fechahora']as Timestamp).toDate().toString()?? 'No disponible'}') ,
                          //subtitle: Text('Revisor: ${asistencia['revisor']}'),
                        );
                      });
                }
              },
            ))
          ],
        ),
      ),
    );
  }
  _selectedDate()async{
    final DateTime? seleccion = await showDatePicker(
      context: context,
      initialDate: selectedFecha,
      firstDate: DateTime(2015),
      lastDate:DateTime(2025),
    );
    if(seleccion != null && seleccion != selectedFecha)
      setState(() {
        selectedFecha = seleccion;
      });
  }

}



