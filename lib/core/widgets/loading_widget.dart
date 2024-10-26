import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  final String jsonPath;

  final Color textColor;
  const LoadingWidget({
    super.key,
    required this.jsonPath,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Loading...",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          SizedBox(
              width: 150,
              height: 150,
              child: Lottie.asset('assets/images/$jsonPath.json')),
        ],
      ),
    );
  }
}
