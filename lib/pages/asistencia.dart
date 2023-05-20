import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dam_u4_proyecto2_17401034/pages/insertasistencia.dart';
import 'package:dam_u4_proyecto2_17401034/services/bd_services.dart';
import 'package:flutter/material.dart';
class Asistencia extends StatefulWidget {
  final String asignacionid;
  const Asistencia({Key? key, required this.asignacionid}) : super(key: key);

  @override
  State<Asistencia> createState() => _AsistenciaState();
}

class _AsistenciaState extends State<Asistencia> {
  @override
  Widget build(BuildContext context) {
    String asignacionid = widget.asignacionid;

    return Scaffold(
      appBar: AppBar(title: Text("Asistencia"),centerTitle: true, backgroundColor: Colors.teal),
      body: FutureBuilder(
      future: getAsistencia(widget.asignacionid),
      builder: (context,snapshot){
        if(snapshot.hasData){
          return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index){
                return ListTile(
                  title: Text(
                    '${(snapshot.data?[index]['fechahora'] )}',
                  ),
                  subtitle: Text(snapshot.data?[index]['revisor']??''),

                );
              });
        }else{
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
       
       
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          await Navigator.push(context, MaterialPageRoute(builder: (context)=> insertAsistencia(asignacionid: asignacionid)));
          setState(() {
          });
        },
        child: Icon(Icons.add),
      ),
      );
    
  }
}
