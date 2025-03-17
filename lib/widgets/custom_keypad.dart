import 'package:flutter/material.dart';

class CustomKeypad extends StatelessWidget {
  final Function(String) onKeyPressed;
  final Function() onBackspace;

  CustomKeypad({
    required this.onKeyPressed,
    required this.onBackspace,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Color(0xFF001F17),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildKeypadRow(['1', '2', '3']),
          _buildKeypadRow(['4', '5', '6']),
          _buildKeypadRow(['7', '8', '9']),
          _buildKeypadRow(['*', '0', 'backspace']),
        ],
      ),
    );
  }

  Widget _buildKeypadRow(List<String> keys) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: keys.map((key) => _buildKeypadButton(key)).toList(),
      ),
    );
  }

  Widget _buildKeypadButton(String key) {
    return Container(
      width: 80,
      height: 60,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (key == 'backspace') {
              onBackspace();
            } else {
              onKeyPressed(key);
            }
          },
          borderRadius: BorderRadius.circular(30),
          child: Center(
            child: key == 'backspace'
                ? Icon(Icons.backspace_outlined, color: Colors.white70, size: 24)
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        key,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (key == '2') Text('ABC', style: TextStyle(color: Colors.white70, fontSize: 12)),
                      if (key == '3') Text('DEF', style: TextStyle(color: Colors.white70, fontSize: 12)),
                      if (key == '4') Text('GHI', style: TextStyle(color: Colors.white70, fontSize: 12)),
                      if (key == '5') Text('JKL', style: TextStyle(color: Colors.white70, fontSize: 12)),
                      if (key == '6') Text('MNO', style: TextStyle(color: Colors.white70, fontSize: 12)),
                      if (key == '7') Text('PQRS', style: TextStyle(color: Colors.white70, fontSize: 12)),
                      if (key == '8') Text('TUV', style: TextStyle(color: Colors.white70, fontSize: 12)),
                      if (key == '9') Text('WXYZ', style: TextStyle(color: Colors.white70, fontSize: 12)),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
} 
