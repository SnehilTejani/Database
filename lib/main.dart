
import 'package:database/practice.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
 // await Firebase.initializeApp();
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class Database extends StatefulWidget {
  const Database({Key? key}) : super(key: key);

  @override
  State<Database> createState() => _DatabaseState();
}

class _DatabaseState extends State<Database> {
  List<Map> data = [];
  String selectedKey = "";
 // FirebaseDatabase database = FirebaseDatabase.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(hintText: "Email"),
          ),
          SizedBox(
            //height: 20,
          ),
          TextField(
            controller: passController,
            decoration: InputDecoration(hintText: "Password"),
          ),
          SizedBox(
            height: 20,
          ),
          // ElevatedButton(
          //     onPressed: () {
          //       String? key = database.ref('User').push().key;
          //       database.ref("User").child(key!).set({
          //         'email': emailController.text,
          //         'pass': passController.text,
          //         'key': key,
          //       });
          //     },
          //     child: Text("Input")),
          SizedBox(
            height: 20,
          ),
          // ElevatedButton(
          //     onPressed: () {
          //       database.ref("User").child(selectedKey).update({
          //         'email': emailController.text,
          //         'pass': passController.text
          //       });
          //     },
          SizedBox(
            height: 20,
          ),
          // ElevatedButton(
          //     onPressed: () {
          //       database.ref("User").child(selectedKey).remove();
          //     },
          //     child: Text("Delete")),
          SizedBox(
            height: 20,
          ),
          // ElevatedButton(
          //     onPressed: () async {
          //       var d = await database.ref("User").once();
          //       Map temp = d.snapshot.value as Map;
          //       data.clear();
          //       temp.forEach((key, value) {
          //         data.add(value);
          //       });
          //       print("-------------$data");
          //       setState(() {});
          //     },
          //     child: Text("Select")),
          SizedBox(height: 15.0),
          Expanded(
            child: GridView.builder(
              itemCount: data.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  emailController.text = data[index]['email'];
                  passController.text = data[index]['pass'];
                  selectedKey = data[index]['key'];
                },
                child: Container(
                  child: Text(
                    data[index]['email'],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
