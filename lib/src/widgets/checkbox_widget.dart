import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class renderCekbox extends StatefulWidget {
  renderCekbox({this.value, @required this.onChanged});

  ValueChanged<bool> onChanged;
  bool value = false;

  Cekbox createState() => Cekbox(value: this.value);
}

class Cekbox extends State<renderCekbox> {
  bool value = false;

  Cekbox({this.value});

  void onTap() {
    setState(() {
      widget.onChanged(!value);
      value = !value;

    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    switch (value) {
      case true:
        return InkWell(
            onTap: onTap,
            child: Icon(
              Icons.check_box,
              color: Colors.redAccent,
            ));
        break;
      case false:
        return InkWell(
          onTap: onTap,
          child: Icon(Icons.check_box_outline_blank),
        );
        break;
    }
  }
}
