import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'AddUser.dart';
import 'EditUser.dart';

Future<void> main(async) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class ReadData extends StatefulWidget {
  const ReadData({Key? key}) : super(key: key);

  @override
  State<ReadData> createState() => _AddDataState();
}

class _AddDataState extends State<ReadData> {
  final CollectionReference firebaseRef =
  FirebaseFirestore.instance.collection('users');
  late List data = [];
  // late List uID = [];
  // String ?name;
  // String ?age;
  // String ?phone;

  Future<void> readData() async {
    data.clear();
    try {
      await firebaseRef.get().then((res) {
        res.docs.forEach((element) {
          var temp = {
            'ID': element.id,
            'Name': element.get('Name'),
            'Age': element.get('Age'),
            'Phone': element.get('Phone'),
          };
          data.add(temp);
        });
      });

      setState(() {
        data;
      });

    } catch (e) {
      print(e.toString());
    }
  }

  void updateUsers(int index) async {
    await firebaseRef.doc(data[index]['ID']).delete();
    readData();
  }

  @override
  void initState() {
    super.initState();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('User Data'),
        ),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            textColor: Colors.blueAccent,
            title: Column(
              children: [
                Text('Name: ${data[index]['Name']}'),
                Text('Age: ${data[index]['Age']}'),
                Text('Phone: ${data[index]['Phone']}'),
              ],
            ),
            // subtitle: data[index]['Age'],
            leading: IconButton(
              color: Colors.blue,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditUser(
                          id: data[index]['ID'],
                          name: data[index]['Name'],
                          age: data[index]['Age'],
                          phone: data[index]['Phone'],
                        ))).then((value) => readData());
                // editUser(index, data[index]['Name'], data[index]['Age'],data[index]['Phone'],)
              },
              icon: const Icon(Icons.edit),
            ),
            trailing: IconButton(
              color: Colors.red,
              onPressed: () {
                updateUsers(index);
              },
              icon: const Icon(Icons.delete),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddUser()))
              .then((value) => readData());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// await firebaseRef.add({
// 'Name': name,
// 'Age': age,
// 'Phone': phone,
// }) .then((value) => const SnackBar(content: Text('User Date'),),);
