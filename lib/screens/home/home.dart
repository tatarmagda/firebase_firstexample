import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_example/screens/auth/data/providers/auth_state.dart';
import 'package:firebase_example/screens/home/data/models/cars_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () {
              Provider.of<AuthState>(context, listen: false).signOutWithEmail();
            },
            child: Text("Log out"),
            shape: CircleBorder(
                side: BorderSide(color: Color.fromARGB(0, 31, 32, 94))),
          ),
        ],
      ),
      body: Center(
        // streambuilder lub future builder ale future tylko raz
        child: FutureBuilder(
          future: FirebaseFirestore.instance.collection("cars").get(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List _listOfCars =
                  snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Cars.fromJson(data);
              }).toList();

              return ListView.builder(
                shrinkWrap: true,
                itemCount: _listOfCars.length,
                itemBuilder: (context, index) {
                  Cars _car = _listOfCars[index];

                  return listItem(
                    _car.brand,
                    _car.model,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget listItem(brand, model) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd ||
            direction == DismissDirection.endToStart) print("delete");
      },
      child: ListTile(
        title: Text(brand),
        subtitle: Text(model),
        trailing: IconButton(
          onPressed: () {
            print("delete");
          },
          icon: Icon(Icons.edit),
        ),
      ),
    );
  }
}
