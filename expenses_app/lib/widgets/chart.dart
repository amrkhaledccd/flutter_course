import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

import '../models/transction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;

  Chart(this.transactions);

  double weekTotal = 0;

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      var weekDay = DateTime.now().subtract(Duration(days: index));
      var totalAmount = 0.0;

      for (var transaction in transactions) {
        if (weekDay.day == transaction.date.day &&
            weekDay.month == transaction.date.month &&
            weekDay.year == transaction.date.year) {
          totalAmount += transaction.amount;
        }
      }
      weekTotal += totalAmount;
      return {'day': DateFormat.E().format(weekDay), 'total': totalAmount};
    }).reversed.toList();
  }

  double getHeight(double amount) {
    return weekTotal == 0 ? 0 : amount / weekTotal;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: groupedTransactions
            .map((item) => LayoutBuilder(builder: (context, constraints) {
                  return Column(
                    children: [
                      Container(
                        height: constraints.maxHeight * 0.1,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text('\$${item['total']}'),
                        ),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.05,
                      ),
                      ChartBar(getHeight(item['total']), constraints),
                      SizedBox(
                        height: constraints.maxHeight * 0.05,
                      ),
                      Container(
                        height: constraints.maxHeight * 0.1,
                        child: Text(item['day']),
                      ),
                    ],
                  );
                }))
            .toList(),
      ),
    );
  }
}
