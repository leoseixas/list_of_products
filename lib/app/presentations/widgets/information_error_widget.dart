import 'package:flutter/material.dart';

class InformationErrorWidget extends StatelessWidget {
  final String text;
  const InformationErrorWidget({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.red.shade100,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.red.shade800,
          ),
        ),
      ),
    );
  }
}
