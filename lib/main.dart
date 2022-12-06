import 'package:expence_planning/Widgets/chart.dart';
import 'package:flutter/material.dart';
import 'Widgets/new_transaction.dart';
import 'Widgets/transaction_list.dart';
import 'Moduls/transaction.dart';

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        // errorColor: Colors.red,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleSmall: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                titleSmall: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),

      // theme: ThemeData(
      //   primarySwatch: Colors.purple,
      //   accentColor: Colors.amber,
      //   textTheme: ThemeData.light().textTheme.copyWith(
      //         titleSmall: TextStyle(
      //           fontFamily: 'OpenSans',
      //           fontSize: 18,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //   appBarTheme: AppBarTheme(
      //       toolbarTextStyle: ThemeData.light()
      //           .textTheme
      //           .copyWith(
      //             titleSmall: TextStyle(
      //               fontFamily: 'OpenSans',
      //               fontSize: 20,
      //               fontWeight: FontWeight.bold,
      //             ),
      //           )
      //           .bodyText2,
      //       titleTextStyle: ThemeData.light()
      //           .textTheme
      //           .copyWith(
      //               titleSmall: TextStyle(
      //             fontFamily: 'OpenSans',
      //             fontSize: 20,
      //             fontWeight: FontWeight.bold,
      //           ))
      //           .headline6),
      //   errorColor: Colors.red,
      // ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // double totalamount = 0;
  final List<Transaction> _userTrasaction = [
    // Transaction(
    //   amount: 51.25,
    //   date: DateTime.now(),
    //   id: 't1',
    //   title: "shoes",
    // ),
    // Transaction(
    //   id: 't2',
    //   title: "clothes",
    //   amount: 10.25,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTrasaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txtitle, double txamount, DateTime choosenDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txtitle,
      amount: txamount,
      date: choosenDate,
    );
    setState(() {
      _userTrasaction.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTrsnsaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTrasaction.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Personal Expenses'),
      actions: [
        IconButton(
          onPressed: () {
            _startAddNewTransaction(context);
          },
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height) *
                  0.3,
              child: Chart(_recentTransactions),
            ),
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.7,
              child: TranasactionList(_userTrasaction, _deleteTransaction),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _startAddNewTransaction(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
