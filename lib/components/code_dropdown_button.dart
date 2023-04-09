import 'package:flutter/material.dart';

class CodeDropDownButton extends StatefulWidget {
  String? val;
  List<String>? codes;
  Function onChanged;
  CodeDropDownButton(
      {super.key, this.val, this.codes, required this.onChanged});

  @override
  State<CodeDropDownButton> createState() => _CodeDropDownButtonState();
}

class _CodeDropDownButtonState extends State<CodeDropDownButton> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width - 50,
      height: 60,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: widget.val!,
              items: widget.codes!
                  .map((code) =>
                      DropdownMenuItem<String>(value: code, child: Text(code)))
                  .toList(),
              onChanged: (value) {
                widget.onChanged(value);
                setState(() {
                  widget.val = value;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
