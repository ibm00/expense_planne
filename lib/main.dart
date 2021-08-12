import 'package:flutter/material.dart';

import './widgets/input_card.dart';
import './models/transactions.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: ThemeData().textTheme.copyWith(
              subtitle1: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(
                color: Colors.white,
              ),
            ),
        fontFamily: 'Quicksand',
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  letterSpacing: 3,
                  fontFamily: 'OpenSans',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Home> {
  final List<Transacton> _transactions = [];
  bool _showChart = false;
  List<Transacton> get _recentTransaction {
    return _transactions.where(
      (element) {
        return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
      },
    ).toList();
  }

  void _addTransaction(
      String inputTitle, String inputAmount, DateTime inputDate) {
    Transacton newTx = Transacton(
      amount: double.parse(inputAmount),
      title: inputTitle,
      date: inputDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _transactions.add(newTx);
    });
  }

  void _deleteTransaction(int index) {
    setState(() {
      _transactions.removeAt(index);
    });
  }

  void _startAddingNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      backgroundColor: Colors.purple,
      context: ctx,
      builder: (_) => InputCard(_addTransaction),
    );
  }

  List<Widget> buildNotLandScap(
      {MediaQueryData mediaQuery, AppBar appBar, Container txCont}) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
        child: Chart(reccentTransaction: _recentTransaction),
      ),
      txCont
    ];
  }

  List<Widget> buildLandScape(
      {MediaQueryData mediaQuery, AppBar appBar, Container txCont}) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Show Chart',
            style: TextStyle(fontSize: 20),
          ),
          Switch(
              value: _showChart,
              onChanged: (showChart) {
                setState(() {
                  _showChart = showChart;
                });
              }),
        ],
      ),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Chart(reccentTransaction: _recentTransaction),
            )
          : txCont
    ];
  }

  AppBar buildAppBar2() {
    return AppBar(
      actions: [
        Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddingNewTransaction(context),
          ),
        )
      ],
      title: Center(child: Text('Expense planner')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = buildAppBar2();
    final isLandSacpe = mediaQuery.orientation == Orientation.landscape;
    final txCont = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(_transactions, _deleteTransaction),
    );

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (isLandSacpe)
                ...buildLandScape(
                  mediaQuery: mediaQuery,
                  appBar: appBar,
                  txCont: txCont,
                ),
              if (!isLandSacpe)
                ...buildNotLandScap(
                    appBar: appBar, mediaQuery: mediaQuery, txCont: txCont),
            ],
          ),
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () => _startAddingNewTransaction(context),
          child: Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
