import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FailureWidget extends StatelessWidget {
  final String errorMassage;
  const FailureWidget({
    super.key,
    required this.errorMassage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorMassage,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
              width: 200,
              height: 200,
              child: Lottie.asset('assets/images/morty_crying.json')),
        ],
      ),
    );
  }
}
