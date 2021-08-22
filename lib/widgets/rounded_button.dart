
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final text;
  final VoidCallback onpressed;
  const RoundedButton({
    Key? key,
    required this.text,
    required this.onpressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onpressed,
      child: Text(text, style: TextStyle(color: Colors.white, fontSize: 18.0)),
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 8.0),
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}
