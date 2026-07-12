import 'package:crafty_bay/app/app_colors.dart';
import 'package:flutter/material.dart';

class IncDecButton extends StatefulWidget {
  const IncDecButton({
    Key? key,
    required this.maxcount,
    required this.mincount,
    required this.initialValue,
    required this.onChange,
  });

  final int maxcount;
  final int mincount;
  final int initialValue;
  final Function(int) onChange;

  @override
  State<IncDecButton> createState() => _IncDecButtonState();
}

class _IncDecButtonState extends State<IncDecButton> {
  int _counter = 0;
  @override
  void initState() {
    super.initState();
    _counter = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        _IconButton(Icons.remove, () {
          if (_counter > widget.mincount) {
            _counter--;
            widget.onChange(_counter);
          }
          setState(() {});
        }),
        Text('$_counter',style: TextStyle(fontSize: 24),),
        _IconButton(Icons.add, () {
          if (_counter < widget.maxcount) {
            _counter++;
          }
          widget.onChange(_counter);
          setState(() {});
        }),
      ],
    );
  }

  Widget _IconButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
  
        padding: .all(10),
        decoration: BoxDecoration(
          color: AppColors.themeColor,
          borderRadius: .circular(4),
        ),
        child: Center(child: Icon(icon, color: Colors.white,size: 13,)),
      ),
    );
  }
}
