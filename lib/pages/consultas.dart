import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dam_u4_proyecto2_17401034/services/bd_services.dart';

class Consultas extends StatefulWidget {
  @override
  _ConsultasState createState() => _ConsultasState();
}

class _ConsultasState extends State<Consultas> {


  TextEditingController controller = TextEditingController();
  Future<List<Map<String, dynamic>>>? asistenciaFuture;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Consultar  asistencia de un docente determinado "),),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: controller,
              decoration: InputDecoration(labelText: "Nombre del docente"),
            ),
            Padding(padding: EdgeInsets.all(15)),
            ElevatedButton(onPressed: (){
              setState(() {
                asistenciaFuture = getAsistenciaPorDocente(controller.text);
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
                  return ListView.builder(
                      itemCount: asistencias.length,
                      itemBuilder: (context,index){
                        final asistencia=asistencias[index];
                        return ListTile(
                          title:Text('Fecha/hora: ${(asistencia['fechahora'])}') ,
                          subtitle: Text('Revisor: ${asistencia['revisor']}'),
                        );
                      });
                }
              },
            )),
            SizedBox(height: 35,),

          ],
        ),
      ),
    );
  }
}
