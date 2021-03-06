import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_example/screens/auth/data/providers/auth_state.dart';
import 'package:firebase_example/screens/home/data/models/cars_model.dart';
import 'package:firebase_example/screens/home/widgets/car_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  List<String> documentsID = [];

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
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("cars").snapshots(),
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

              documentsID =
                  snapshot.data!.docs.map((DocumentSnapshot document) {
                return document.id;
              }).toList();

              return ListView.builder(
                shrinkWrap: true,
                itemCount: _listOfCars.length,
                itemBuilder: (context, index) {
                  Cars _car = _listOfCars[index];

                  return listItem(
                    _car,
                    documentsID[index],
                    context,
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Cars data = Cars(
            model: " ",
            brand: "",
          );

          showDialog(
            context: context,
            builder: (_) => Dialog(
              child: CarModal(
                car: data,
                docId: "",
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget listItem(Cars car, documentID, context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd ||
            direction == DismissDirection.endToStart) {
          FirebaseFirestore.instance
              .collection("cars")
              .doc(documentID)
              .delete();
        }
      },
      child: ListTile(
        title: Text(car.brand!),
        subtitle: Text(car.model!),
        trailing: IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => Dialog(
                child: CarModal(
                  car: car,
                  docId: documentID,
                ),
              ),
            );
          },
          icon: Icon(Icons.edit),
        ),
      ),
    );
  }
}
