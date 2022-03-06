import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_example/screens/home/data/models/cars_model.dart';
import 'package:flutter/material.dart';

class CarModal extends StatefulWidget {
  CarModal({Key? key, this.docId, this.car}) : super(key: key);

  final Cars? car;
  final String? docId;

  @override
  State<CarModal> createState() => _CarModalState();
}

class _CarModalState extends State<CarModal> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? _brandController;
  TextEditingController? _modelController;
  Cars? _car;

  @override
  void initState() {
    _car = widget.car!;
    _brandController = TextEditingController(text: _car!.brand);
    _modelController = TextEditingController(text: _car!.model);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                onChanged: (v) {
                  setState(() {
                    _car!.brand = v;
                  });
                },
                controller: _brandController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a brand";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                onChanged: (v) {
                  setState(() {
                    _car!.model = v;
                  });
                },
                controller: _modelController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a model";
                  }
                  return null;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("cancel")),
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (widget.docId == "") {
                        FirebaseFirestore.instance
                            .collection("cars")
                            .add(_car!.toJson())
                            .whenComplete(
                              () => Navigator.of(context).pop(),
                            );
                      } else {
                        FirebaseFirestore.instance
                            .collection("cars")
                            .doc(widget.docId)
                            .update(_car!.toJson())
                            .whenComplete(
                              () => Navigator.of(context).pop(),
                            );
                      }
                    }
                  },
                  child: Text("save"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
