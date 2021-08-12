import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputCard extends StatefulWidget {
  InputCard(this.addTransaction);
  final Function addTransaction;

  @override
  _InputCardState createState() => _InputCardState();
}

class _InputCardState extends State<InputCard> {
  final titleControler = TextEditingController();

  final amountControler = TextEditingController();
  DateTime _date;

  void addNewItem() {
    final String title = titleControler.text;
    final String amount = amountControler.text;

    if (title.isEmpty || amount.isEmpty || _date == null) {
      DoNothingAction();
    } else {
      widget.addTransaction(title, amount, _date);
      Navigator.of(context).pop();
    }
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then(
      (pickedDate) {
        if (pickedDate == null) return;
        setState(() {
          _date = pickedDate;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          color: Colors.grey[100],
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                onSubmitted: (_) => addNewItem(),
                controller: titleControler,
                decoration: InputDecoration(
                  labelText: 'title',
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                onSubmitted: (_) => addNewItem(),
                controller: amountControler,
                decoration: InputDecoration(
                  labelText: 'amount',
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _date == null
                          ? 'No choosen date yet'
                          : 'Picked Date: ${DateFormat.yMd().format(_date)}',
                      style: TextStyle(fontSize: 15),
                    ),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: _showDatePicker,
                      child: Text(
                        'Choose the date',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
              RaisedButton(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                textColor: Theme.of(context).textTheme.button.color,
                color: Theme.of(context).primaryColor,
                onPressed: addNewItem,
                child: Text(
                  'Add transaction',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
