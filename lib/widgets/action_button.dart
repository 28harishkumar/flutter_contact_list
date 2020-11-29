import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final int index;
  final bool isSelected;
  final Function(int) onRemove;
  final Function(int) onSelect;

  ActionButton({this.index, this.isSelected, this.onRemove, this.onSelect});

  void onPress() {
    if (isSelected) {
      onRemove(index);
    } else {
      onSelect(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isSelected) {
      return RaisedButton(
        color: Colors.white,
        elevation: 0,
        child: Text(
          'Remove',
          style: TextStyle(color: Colors.redAccent),
        ),
        onPressed: onPress,
      );
    }

    return RaisedButton(
      color: Colors.white,
      elevation: 0,
      child: Text(
        'Select',
        style: TextStyle(color: Colors.blueAccent),
      ),
      onPressed: onPress,
    );
  }
}
