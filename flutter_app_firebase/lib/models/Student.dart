import 'package:cloud_firestore/cloud_firestore.dart';

class Student{

  String name;
  String admissionNo;
  String address;
  String mobileNo;
  String average;

  DocumentReference documentReference;

  Student({this.address,this.mobileNo,this.average,this.admissionNo,this.name});

  Student.fromMap(Map <String,dynamic> map,{this.documentReference}){
    name = map["name"];
    admissionNo = map["admissionNo"];
    address = map["address"];
    mobileNo = map["mobileNo"];
    average = map["average"];

  }

  Student.fromSnapshot(DocumentSnapshot snapshot)
      :this.fromMap(snapshot.data,documentReference:snapshot.reference);

  toJson(){
    return{'name': name, 'admissionNo' : admissionNo, 'address':address, 'mobileNo':mobileNo,'average': average};
  }

}