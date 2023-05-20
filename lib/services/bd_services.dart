import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';

FirebaseFirestore BD = FirebaseFirestore.instance;
//var usarRef= BD.collection("asignacion").doc("asistencia");

Future<List> getAsignacion() async{
  List asignacion =[];
  QuerySnapshot querySnapshot=await BD.collection("asignacion").get();
  for(var doc in querySnapshot.docs){
    final Map<String,dynamic> data = doc.data() as Map<String, dynamic>;
    final asiganacionObject ={
      "salon":data["salon"],
      "edificio":data["edificio"],
      "horario":data["horario"],
      "docente":data["docente"],
      "materia":data["materia"],
      "uid":doc.id,
    };
    asignacion.add(asiganacionObject);
  }
await Future.delayed(Duration(seconds: 2),);
  return asignacion;
}



//insertar Asignacion
Future<void> inserAsignacion(
String salon,
String edificio,
String horario,
String docente,
String materia) async{
  await BD.collection("asignacion").add({
    "salon":salon,
    "edificio":edificio,
    "horario":horario,
    "docente":docente,
    "materia":materia
  });
}

//Actualizar Asignacion
Future<void> updateAsigacion(
    String uid,
    String salon,
    String edificio,
    String horario,
    String docente,
    String materia
    ) async{
  await BD.collection("asignacion").doc(uid).set({
    "salon":salon,
    "edificio":edificio,
    "horario":horario,
    "docente":docente,
    "materia":materia
  });
}

Future<void> deleteAsignacion(String uid)async{
  await BD.collection("asignacion").doc(uid).delete();
}

Future<void> actualizarAsignacion(
    String uid,
    String newsalon,
    String newedificio,
    String newhorario,
    String newdocente,
    String newmateria,

    ) async {
  await BD.collection("asignacion").doc(uid).set({
    "salon": newsalon,
    "edificio": newedificio,
    "horario": newhorario,
    "docente": newdocente,
    "materia": newmateria,

  });
}


////////////////////////////////////////////////////////////////////////////////
//get asistencia
Future<List> getAsistencia(String asignacionid) async{
  List asistencia =[];
  QuerySnapshot queryAsistencia=await BD.collection('asignacion').doc(asignacionid).collection('asistencia').get();
  for(var doc in queryAsistencia.docs){
    final Map<String,dynamic> data = doc.data() as Map<String, dynamic>;
    final asistenciaDoc ={
      "fechahora":data["fechahora"],
      "revisor":data["revisor"],
      "uid":doc.id,
    };
    asistencia.add(asistenciaDoc);
  }
  await Future.delayed(const Duration(seconds: 2));
  return asistencia;
}



Future<void> insertarAsistencias(String asignacionid, Map<String, dynamic> asistenciaData) async{
  await BD.collection('asignacion').doc(asignacionid).collection('asistencia').add(asistenciaData);
}



//////consultas
Future<List<Map<String, dynamic>>> getAsistenciaPorDocente(String docente) async {
  List<Map<String, dynamic>> asistencias = [];
  QuerySnapshot querySnapshot = await BD
      .collection('asignacion')
      .where('docente', isEqualTo: docente)
      .get();
  for (var doc in querySnapshot.docs) {
    QuerySnapshot asistenciasSnapshot = await doc.reference
        .collection('asistencia')
        .get();
    asistencias.addAll(asistenciasSnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList());
  }
  return asistencias;
}

////consulta 2
Future<List<Map<String, dynamic>>> getAsistenciasPorRangoFechas(DateTime fechaInicio, DateTime fechaFin) async {
  List<Map<String,dynamic>> asistencias = [];
  QuerySnapshot asignacionesSnapshot = await BD
      .collection('asignacion')
      .get();
  for (var doc in asignacionesSnapshot.docs) {
    QuerySnapshot asistenciasSnapshot = await doc.reference
        .collection('asistencia')
        .where('fechahora', isGreaterThanOrEqualTo: Timestamp.fromDate(fechaInicio), isLessThan: Timestamp.fromDate(fechaFin))
        .get();
    asistencias.addAll(asistenciasSnapshot.docs.map((doc) => doc.data() as Map<String,dynamic>).toList());
  }
  return asistencias;
}





//consulta 3
Future<List<Map<String, dynamic>>> getAsistenciasPorRangoFechasEdificio(DateTime fechaInicio, DateTime fechaFin, String edificio) async {
  List<Map<String,dynamic>> asistencias = [];
  QuerySnapshot querySnapshot = await BD
      .collection('asignacion')
      .where('edificio', isEqualTo: edificio)
      .get();
  for (var doc in querySnapshot.docs) {
    QuerySnapshot asistenciasSnapshot = await doc.reference
        .collection('asistencia')
        .where('fecha/hora', isGreaterThanOrEqualTo: fechaInicio, isLessThan: fechaFin)
        .get();
    asistencias.addAll(asistenciasSnapshot.docs.map((doc) => doc.data() as Map<String,dynamic>).toList());
  }
  return asistencias;
}

//consulta 4
Future<List<Map<String, dynamic>>> getAsistenciasPorRevisor(String revisor) async {
    List<Map<String, dynamic>> asistencias = [];
    QuerySnapshot querySnapshot = await BD
        .collection('asignacion')

        .get();
    for (var doc in querySnapshot.docs) {
      QuerySnapshot asistenciasSnapshot = await doc.reference
          .collection('asistencia')
          .where('revisor', isEqualTo: revisor)
          .get();
      asistencias.addAll(asistenciasSnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList());
    }
    return asistencias;
  }


