import 'package:database/practice.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
  FirebaseDatabase database = FirebaseDatabase.instance;
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
            height: 20,
          ),
          TextField(
            controller: passController,
            decoration: InputDecoration(hintText: "Password"),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                String? key = database.ref('User').push().key;
                database.ref("User").child(key!).set({
                  'email': emailController.text,
                  'pass': passController.text,
                  'key': key,
                });
              },
              child: Text("Input")),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                database.ref("User").child(selectedKey).update({
                  'email': emailController.text,
                  'pass': passController.text
                });
              },
              child: Text("एक समय की बात है, एक गांव में ढेर सारे मुर्गे रहते थे। गांव के बच्चे ने किसी एक मुर्गे को तंग कर दिया था। मुर्गा परेशान हो गया, उसने सोचा अगले दिन सुबह मैं आवाज नहीं करूंगा। सब सोते रहेंगे तब मेरी अहमियत सबको समझ में आएगी, और मुझे तंग नहीं करेंगे। मुर्गा अगली सुबह कुछ नहीं बोला।  सभी लोग समय पर उठ कर अपने-अपने काम में लग गए इस पर मुर्गे को समझ में आ गया कि किसी के बिना कोई काम नहीं रुकता। सबका काम चलता रहता है\n\nनैतिक शिक्षा – घमंड नहीं करना चाहिए आपकी अहमियत लोगो को बिना बताये पता चलता है।\n\nMoral of this short hindi story – Never be too arrogant. Your work should tell your importance to the world.")),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                database.ref("User").child(selectedKey).remove();
              },
              child: Text("Delete")),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                var d = await database.ref("User").once();
                Map temp = d.snapshot.value as Map;
                data.clear();
                temp.forEach((key, value) {
                  data.add(value);
                });
                print("-------------$data");
                setState(() {});
              },
              child: Text("Select")),
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
