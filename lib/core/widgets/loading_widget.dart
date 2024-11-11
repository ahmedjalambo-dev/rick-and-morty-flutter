import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  final String jsonPath;
  final String loadingStatus;

  const LoadingWidget({
    super.key,
    required this.jsonPath,
    this.loadingStatus = "Loading...",
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            loadingStatus,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
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
