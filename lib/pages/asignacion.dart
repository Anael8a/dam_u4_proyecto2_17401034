import 'package:dam_u4_proyecto2_17401034/pages/asistencia.dart';
import 'package:dam_u4_proyecto2_17401034/pages/insertasignacion.dart';
import 'package:dam_u4_proyecto2_17401034/services/bd_services.dart';
import 'package:flutter/material.dart';

class Asignacion extends StatefulWidget {
  const Asignacion({Key? key}) : super(key: key);

  @override
  State<Asignacion> createState() => _AsignacionState();
}

class _AsignacionState extends State<Asignacion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Asigancion"), centerTitle: true,backgroundColor: Colors.teal),
      body: FutureBuilder(
        future: getAsignacion(),
        builder: ((context,snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {

                return Dismissible(
                    onDismissed:(direction)async{
                      await deleteAsignacion(snapshot.data?[index]['uid']);
                      setState(() {});
                    },
                    confirmDismiss: (direction)async{
                      bool result = false;
                      setState(() {});

                      result = await showDialog(context: context, builder: (context){

                        return AlertDialog(
                          title:  Text("Que deseas hacer con el  ${snapshot.data?[index]['docente']}?"),
                          

                          actions: [
                            TextButton(
                              child: Text('Asistencia'),
                              onPressed: () async{
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Asistencia(asignacionid: snapshot.data?[index]['uid'] ?? ''),
                                  ),
                                );
                                setState(() {});
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(onPressed: (){
                              return Navigator.pop(context,true);
                            }, child: Text("Eliminar")),


                            TextButton(onPressed: (){
                              return Navigator.pop(context,false);
                            }, child: Text("Cancelar")),


                          ],

                        );
                      });

                      return result;
                    },
                    background: Container(
                      child: Icon(Icons.settings),
                      color:Colors.blue,
                    ),
                    key: Key(snapshot.data?[index]['uid']),
                    child:ListTile(
                      title: Text(snapshot.data?[index]['docente'] ?? ''
                        ,style:TextStyle(fontWeight: FontWeight.bold),),

                      subtitle: Text(
                        'Salon: ${snapshot.data?[index]['salon']??''}\n'
                            'Materia: ${snapshot.data?[index]['materia']?? ''}\n'
                            'Edificio: ${snapshot.data?[index]['edificio']?? ''}',

                      ),
                      onTap: (()async {

                        await Navigator.pushNamed(context, '/actualizarAsignacion',arguments: {
                          "salon":snapshot.data?[index]['salon'],
                          "uid":snapshot.data?[index]['uid'],
                          "edificio":snapshot.data?[index]['edificio'],
                          "horario":snapshot.data?[index]['horario'],
                          "docente":snapshot.data?[index]['docente'],
                          "materia":snapshot.data?[index]['materia'],

                        });
                        setState(() {

                        });
                      }),
                    ));
              },
            );
          }else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          await Navigator.push(context, MaterialPageRoute(builder: (builder)=> insertAsignacion() ));
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
