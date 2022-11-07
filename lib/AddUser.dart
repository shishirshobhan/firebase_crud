import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final CollectionReference firebaseRef = FirebaseFirestore.instance.collection('users');
  List data = [];
  String ?name;
  String ?age;
  String ?phone;
  TextEditingController nameFieldController = TextEditingController();
  TextEditingController ageFieldController = TextEditingController();
  TextEditingController phoneFieldController = TextEditingController();

  Future <void> addUser() async {
    nameFieldController.clear();
    ageFieldController.clear();
    phoneFieldController.clear();

    await firebaseRef.add({
      'Name': name,
      'Age': age,
      'Phone': phone,
    }).catchError((e)=>print(e));
  }
  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add User')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children:  [
            TextField(
              controller: nameFieldController,
              onChanged: (value){
                name = value;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'User Name',
                hintText: 'Enter Your Name',
              ),
            ),
            TextField(
              controller: ageFieldController,
              onChanged: (value){
                age = value;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'User Age',
                hintText: 'Enter Your Age',
              ),
            ),
            TextField(
              controller: phoneFieldController,
              onChanged: (value){
                phone = value;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'User Phone',
                hintText: 'Enter Your Phone',
              ),
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              child: const Text('Add'),
              onPressed: () {
                addUser().then((value) => Navigator.pop(context));
              },
            ),
          ],
        ),
      ),
    );
  }
}
