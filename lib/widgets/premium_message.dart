import 'package:flutter/material.dart';
import 'package:optimize/constants/active_constants.dart';

class PremiumMessage extends StatelessWidget {
  final Function onClick;
  const PremiumMessage({Key? key, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding:
            EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.25),
        child: Column(
          children: [
            const Text("You need to subscribe premium account",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                )),
            TextButton(
              style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                  backgroundColor: activeColors.primary),
              onPressed: () {
                onClick();
              },
              child: const Text(
                'Get Now',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
