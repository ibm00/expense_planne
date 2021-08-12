import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.index,
    @required this.mediaQuery,
    @required Function deleteTarnsaction,
  })  : _deleteTarnsaction = deleteTarnsaction,
        super(key: key);

  final Transacton transaction;
  final MediaQueryData mediaQuery;
  final Function _deleteTarnsaction;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      elevation: 8,
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Text('\$${transaction.amount.toStringAsFixed(2)}'),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        subtitle: Text(DateFormat.yMMMd().format(transaction.date)),
        trailing: (mediaQuery.size.width > 460)
            ? FlatButton.icon(
                textColor: Theme.of(context).errorColor,
                onPressed: () => _deleteTarnsaction(index),
                icon: Icon(
                  Icons.delete,
                ),
                label: Text('Delete'),
              )
            : IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () => _deleteTarnsaction(index),
              ),
      ),
    );
  }
}
