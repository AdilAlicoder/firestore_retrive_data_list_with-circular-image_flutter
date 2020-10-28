import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(list());
}
class list extends StatefulWidget {
  @override
  _listState createState() => _listState();
}

class _listState extends State<list> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tab',
      theme: ThemeData(
        primaryColor: Colors.blueGrey[600],
      ),
      home:homepage(),
    );
  }
}
class  homepage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<homepage> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Tabbar"),
          actions: [
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.search),
            ),
            SizedBox(width: 23.0),
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.more_vert),
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: 'Chats'),
              Tab(text: 'Friends'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('userdata').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.data == null) {
                  return CircularProgressIndicator();
                }
                return ListView(
                  children: snapshot.data.documents
                      .map<Widget>((DocumentSnapshot document) {
                    return eventCard(
                        image: document['image'],
                        name: document['name']);
                  }).toList(),
                );
              },
            ),
            Center(
              child: Text('Tab 2'),
            )
          ],
        ),
      ),
    );
  }

  Widget eventCard({image, name}) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(image),
            radius: 40.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(name,style: TextStyle(fontSize: 20.0),),
        )
      ],
    );
  }
}


