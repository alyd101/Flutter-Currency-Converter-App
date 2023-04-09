import 'package:flutter/material.dart';

class ConvertButton extends StatelessWidget {
  final Function onTap;
  ConvertButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () => onTap(),
      child: SizedBox(
        width: width - 100,
        height: 70,
        child: Card(
          color: Theme.of(context).primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: const Center(
            child: Text(
              "Convert",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
