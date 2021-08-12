import '../models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  Chart({this.reccentTransaction});
  final List<Transacton> reccentTransaction;
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(
      7,
      (index) {
        var weekDay = DateTime.now().subtract(Duration(days: index));
        var totalAmount = 0.0;
        var n = reccentTransaction.length;
        for (int i = 0; i < n; i++) {
          if (reccentTransaction[i].date.day == weekDay.day &&
              reccentTransaction[i].date.month == weekDay.month &&
              reccentTransaction[i].date.year == weekDay.year) {
            totalAmount += reccentTransaction[i].amount;
          }
        }
        return {
          'day': DateFormat.E().format(weekDay).substring(0, 1),
          'amount': totalAmount,
        };
      },
    ).reversed.toList();
  }

  double get amountSpentLastWeek {
    return groupedTransactionValues.fold(0.0, (previousValue, element) {
      return previousValue + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      elevation: 7,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((e) {
            var percent = (amountSpentLastWeek == 0)
                ? 0.0
                : (e['amount'] as double) / amountSpentLastWeek;
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                day: e['day'],
                amount: e['amount'],
                amountPercentage: percent,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
