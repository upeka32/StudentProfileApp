import 'package:cloud_firestore/cloud_firestore.dart';

class Student{

  String name;
  String admissionNo;
  String gender;
  String address;

  DocumentReference documentReference;

  Student({this.address,this.gender,this.admissionNo,this.name});

  Student.fromMap(Map <String,dynamic> map,{this.documentReference}){
    name = map["name"];
    admissionNo = map["admissionNo"];
    gender = map["gender"];
    address = map["address"];

  }

  Student.fromSnapshot(DocumentSnapshot snapshot)
      :this.fromMap(snapshot.data,documentReference:snapshot.reference);

  toJson(){
    return{'name': name, 'admissionNo' : admissionNo, 'gender':gender, 'address':address};
  }

}