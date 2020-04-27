import 'package:cloud_firestore/cloud_firestore.dart';
import './models/Student.dart';

String collectionName = "Students";

getStudents() {
  print('GET Students#############');
  return Firestore.instance.collection(collectionName).snapshots();
}

addStudent(String name,String admissionNo,String gender,String address){
  Student student = Student(admissionNo: admissionNo,name: name,gender:gender,address:address);
  try{
    Firestore.instance.runTransaction(
          (Transaction transaction) async{
        await Firestore.instance
            .collection(collectionName)
            .document()
            .setData(student.toJson());
      },
    );
  } catch(e){
    print(e.toString());
  }
}

updateStudent(Student student, String name,String admissionNo,String gender,String address){
  try {
    Firestore.instance.runTransaction((transaction) async {
      await transaction.update(student.documentReference, {'name': name,'admissionNo':admissionNo,'gender': gender,'address':address});
    });
  } catch(e) {
    print(e.toString());
  }
}

deleteStudent(Student student){
  Firestore.instance.runTransaction(
        (Transaction transaction) async{
      await transaction.delete(student.documentReference);
    },
  );
}