import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToggleListTile extends StatelessWidget {
  ToggleListTile({Key key, this.title, this.enabled, this.onChange}) : super(key: key);
  final String title;
  final bool enabled;
  final void Function(bool value) onChange;

  Widget build(BuildContext context) {
    return ListTile(
        title: Text(title),
        onTap: () {onChange(!enabled);},
        trailing: Switch(
        value: enabled,
        onChanged: onChange,
      )
    );
  }
}

