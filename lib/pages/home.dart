import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:band_names/models/band.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: "Matallica", votes: 5),
    Band(id: '2', name: "rock", votes: 2),
    Band(id: '3', name: "pop", votes: 3),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Band Names",
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, index) => _bandTile(bands[index]),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), elevation: 1, onPressed: addNewBand),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (directio) {
        print('direcino: $directio');
        print('direcino: ${band.id}');
      },
      background: Container(
          padding: EdgeInsets.only(left: 8.0),
          color: Colors.red,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('Delete band', style: TextStyle(color: Colors.white)),
          )),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text('${band.votes}',
            style: TextStyle(fontSize: 25, color: Colors.blue)),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  addNewBand() {
    final texController = new TextEditingController();
    if (Platform.isAndroid) {
      return showDialog(
          context: context,
          builder: (contex) {
            return AlertDialog(
              title: Text('New band name'),
              content: TextField(
                controller: texController,
              ),
              actions: [
                MaterialButton(
                    child: Text('Add'),
                    elevation: 5,
                    textColor: Colors.blue,
                    onPressed: () => addBandToList(texController.text))
              ],
            );
          });
    }

    showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: Text("New bnad name"),
            content: CupertinoTextField(
              controller: texController,
            ),
            actions: [
              CupertinoDialogAction(
                child: Text("add"),
                isDefaultAction: true,
                onPressed: () => addBandToList(texController.text),
              ),
              CupertinoDialogAction(
                  child: Text("Dismiss"),
                  isDefaultAction: true,
                  onPressed: () => Navigator.pop(context))
            ],
          );
        });
  }

  void addBandToList(String name) {
    print(name);
    if (name.length > 1) {
      this
          .bands
          .add(new Band(id: DateTime.now().toString(), name: name, votes: 0));
    }
    setState(() {});
    Navigator.pop(context);
  }
}
