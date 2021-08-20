import 'package:flutter/material.dart';

class MainButtons extends StatelessWidget {
  final String label;
  final Function onPress;
  final Widget icon;
  const MainButtons(
      {Key? key,
      required this.label,
      required this.onPress,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.blue.withAlpha(200),
      highlightColor: Colors.blue.withAlpha(130),
      onTap: () {
        onPress();
      },
      borderRadius: BorderRadius.circular(35),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        decoration: BoxDecoration(
          color: Colors.blue.withAlpha(40),
          borderRadius: BorderRadius.circular(35),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon,
              Expanded(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
