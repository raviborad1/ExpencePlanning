import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTrsnsaction extends StatefulWidget {
  final Function addTx;
  NewTrsnsaction(this.addTx);

  @override
  State<NewTrsnsaction> createState() => _NewTrsnsactionState();
}

class _NewTrsnsactionState extends State<NewTrsnsaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selectedDate;

  void _SubmitData() {
    final enteredTex = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (amountController.text.isEmpty) {
      return;
    }
    if (enteredTex.isEmpty || enteredAmount < 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(
      enteredTex,
      enteredAmount,
      _selectedDate,
    );
    //it will help to close the most upper screen
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
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
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => _SubmitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _SubmitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No Date Choosen'
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate as DateTime)}',
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: _presentDatePicker,
                    child: Text(
                      'choose Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        // color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _SubmitData,
              child: Text(
                'Add Transaction',
              ),
            )
          ],
        ),
      ),
    );
  }
}
