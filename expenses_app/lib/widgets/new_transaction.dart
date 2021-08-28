import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

import '../models/transction.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction({this.addTransaction});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _pickedDate;

  void triggerDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((date) {
      if (date == null) return;
      setState(() {
        _pickedDate = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _pickedDate == null
                          ? "No date selected"
                          : "Date: ${DateFormat.yMd().format(_pickedDate)}",
                    ),
                  ),
                  TextButton(
                    child: Text(
                      "Choose date",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: triggerDatePicker,
                  )
                ],
              ),
            ),
            ElevatedButton(
              child: Text('Add Transaction'),
              onPressed: () {
                var title = _titleController.text;
                var amount = double.parse(_amountController.text);

                if (title.isEmpty || amount <= 0 || _pickedDate == null) {
                  return;
                }

                final transaction = Transaction(
                  title: title,
                  amount: amount,
                  id: Uuid().v1(),
                  date: _pickedDate,
                );

                widget.addTransaction(transaction);
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}
