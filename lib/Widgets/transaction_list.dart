import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expence_planning/Moduls/transaction.dart';

class TranasactionList extends StatelessWidget {
  final List<Transaction> transctions;
  final Function deleteTX;
  TranasactionList(this.transctions, this.deleteTX);
  @override
  Widget build(BuildContext context) {
    return transctions.isEmpty
        ? Column(
            children: [
              Text(
                'No transactions added yet',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 300,
                child:
                    Image.asset('assets/images/waiting.png', fit: BoxFit.cover),
              ),
            ],
          )
        : Container(
            height: 500,
            child: ListView.builder(
              itemCount: transctions.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: FittedBox(
                          child: Text('\$${transctions[index].amount}'),
                        ),
                      ),
                    ),
                    title: Text(
                      transctions[index].title,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    subtitle: Text(
                        DateFormat.yMMMMd().format(transctions[index].date)),
                    trailing: IconButton(
                      onPressed: () => deleteTX(transctions[index].id),
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                );
              },
            ),
          );
  }
}
