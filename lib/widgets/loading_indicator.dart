import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final String? status;

  const LoadingIndicator({super.key, this.status});

  // Helper widget to display a loading indicator
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 56.0, maxHeight: 56.0),
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
          if (status != null)
            const SizedBox(
              height: 16.0,
            ),
          if (status != null)
            Text(
              status!,
              style: const TextStyle(color: Colors.black),
            ),
        ],
      ),
    );
  }
}
