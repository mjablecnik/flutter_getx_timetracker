import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timetracker/controllers/dialog.dart';
import 'package:timetracker/models/tracker.dart';

class TrackerDialog extends GetView<DialogController> {

  TrackerDialog({tracker, @required title, @required onSubmit}) {
    controller.title = title;
    controller.model = tracker ?? Tracker("");
    controller.onSubmit = onSubmit;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 6,
      //backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(30),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: controller.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(controller.title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Name:"),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                initialValue: controller.model.name,
                onSaved: (value) => controller.model.name = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Description:"),
                initialValue: controller.model.description,
                onSaved: (value) => controller.model.description = value,
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(top: 8.0),
                child: ButtonBar(
                  children: [
                    RaisedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: () => controller.submit( ),
                      child: Text("Submit"),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
