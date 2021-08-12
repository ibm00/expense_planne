import 'package:flutter/material.dart';

import '../models/transactions.dart';
import './transactionItem.dart';

class TransactionList extends StatelessWidget {
  TransactionList(this.transactions, this._deleteTarnsaction);
  final List<Transacton> transactions;
  final Function _deleteTarnsaction;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandScape = mediaQuery.orientation == Orientation.landscape;
    return (transactions.isEmpty)
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  SizedBox(
                    height: constraints.maxHeight * .02,
                  ),
                  Container(
                    height: constraints.maxHeight * (isLandScape ? .11 : .06),
                    child: FittedBox(
                      child: Text(
                        'No transaction added yet',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * .07,
                  ),
                  Container(
                    height: constraints.maxHeight * (isLandScape ? .8 : .7),
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return TransactionItem(
                index: index,
                transaction: transactions[index],
                mediaQuery: mediaQuery,
                deleteTarnsaction: _deleteTarnsaction,
              );
            },
            itemCount: transactions.length,
          );
  }
}
