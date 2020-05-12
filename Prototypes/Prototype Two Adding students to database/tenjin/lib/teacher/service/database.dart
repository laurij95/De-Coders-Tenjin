import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final CollectionReference studentCollection = Firestore.instance.collection("Students");
}