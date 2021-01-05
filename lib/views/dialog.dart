import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timetracker/controllers/dialog.dart';
import 'package:timetracker/controllers/trackers.dart';
import 'package:timetracker/models/timetracker.dart';

class TrackerDialog extends GetView<DialogController> {
  @override
  Widget build(BuildContext context) {
    TrackersController trackersController = Get.find<TrackersController>();
    controller.model = TimeTracker("New tracker");

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
                child: Text(
                  "Add new tracker",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Name:"),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (value) => controller.model.name = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Description:"),
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
                      onPressed: () => controller.submit(
                          () => trackersController.addItem(controller.model)
                      ),
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
