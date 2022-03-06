import 'package:flutter/material.dart';

class CarModal extends StatefulWidget {
  CarModal({Key? key, this.brand, this.model}) : super(key: key);

  final String? brand;
  final String? model;

  @override
  State<CarModal> createState() => _CarModalState();
}

class _CarModalState extends State<CarModal> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? _brandController;
  TextEditingController? _modelController;

  @override
  void initState() {
    _brandController = TextEditingController(text: widget.brand);
    _modelController = TextEditingController(text: widget.model);
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
                      if (_formKey.currentState!.validate()) {}
                      ;
                    },
                    child: Text("save"))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
