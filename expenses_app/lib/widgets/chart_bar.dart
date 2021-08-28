import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

class ChartBar extends StatelessWidget {
  final double filledHeight;
  final BoxConstraints constraints;

  ChartBar(this.filledHeight, this.constraints);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: constraints.maxHeight * 0.6,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(75),
              color: Colors.grey,
            ),
          ),
          FractionallySizedBox(
            heightFactor: filledHeight,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(75),
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
