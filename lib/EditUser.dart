import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class EditUser extends StatefulWidget {
  const EditUser({Key? key, required this.id, required this.name, required this.age, required this.phone}) : super(key: key);
  final String id, name, age, phone;

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {

  final CollectionReference firebaseRef =
  FirebaseFirestore.instance.collection('users');

  late String name, age, phone;

  var nameFieldController = TextEditingController();
  var ageFieldController = TextEditingController();
  var phoneFieldController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameFieldController.text = widget.name;
    phoneFieldController.text = widget.phone;
    ageFieldController.text = widget.age;
    name = widget.name;
    phone = widget.phone;
    age = widget.age;
  }

  void editUser(String name, age, phone) async {
    await firebaseRef.doc(widget.id).update({'Name': name, 'Age': age, 'Phone': phone});
    nameFieldController.clear();
    ageFieldController.clear();
    phoneFieldController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Update User')),
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
              child: const Text('Update'),
              onPressed: () {
                editUser(name, age, phone);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

