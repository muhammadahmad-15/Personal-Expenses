
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime _selectedDate;

  void handleSubmit() {
    if (amountController.text.isEmpty || titleController.text.isEmpty) {
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if(enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate
    );
    Navigator.of(context).pop();
  }
  void _displayDatePicker() {
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now()
      ).then((pickedDate) {
        if(pickedDate == null) {
          return;
        }
        setState(() {
          _selectedDate = pickedDate;
        });
      }); 
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              autofocus: true,
              decoration: InputDecoration(labelText: "Title"),
              controller: titleController,
              onSubmitted: (_) {
                handleSubmit();
              },

            ),
            TextField(
              decoration: InputDecoration(labelText:"Amount"),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) {
                 handleSubmit();
              },
            ),
            Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: Text(
                    _selectedDate == null 
                    ? "No date chosen!" : 
                    "Picked Date: ${DateFormat().add_yMd().format(_selectedDate)}",
                  ),
                ),
                FlatButton(
                  child: Text(
                    "Choose Date",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onPressed: _displayDatePicker,),
            ],),
            RaisedButton(
              child: Text("Add Transaction"),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: handleSubmit, 
              )
          ],
        ),
      ),
    );
  }
}