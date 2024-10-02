import 'package:flutter/material.dart';

class CardForLinkTree extends StatelessWidget {
  const CardForLinkTree({
    super.key,
    required this.icon,
    required this.text,
    this.onPressed,
  });

  final IconData icon;
  final String text;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed as void Function()?,
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.teal,
          ),
          title: Text(
            text,
            style: TextStyle(
              color: Colors.teal.shade900,
              fontFamily: 'Judson',
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
