
import 'package:flutter/material.dart';

class UpdateData{
  String name;
  String databaseName;
  IconData icon;
  String value = "";

  UpdateData(this.name,this.databaseName,this.icon);



  static final List<UpdateData> updatedData = [
    UpdateData("First Name","firstName", Icons.person_outline),
    UpdateData("Last Name","lastName", Icons.person_search_outlined),
    UpdateData("Email","email", Icons.alternate_email),
    UpdateData("Price","price", Icons.monetization_on),
    UpdateData("Subjects","subjects", Icons.school),
  ];
}
