import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Animated Opacity Example')),
        body: Center(child: AnimatedTextToggle()),
      ),
    );
  }
}

class AnimatedTextToggle extends StatefulWidget {
  @override
  _AnimatedTextToggleState createState() => _AnimatedTextToggleState();
}

class _AnimatedTextToggleState extends State<AnimatedTextToggle> {
  bool _isVisible = true;
  Duration _animationDuration = Duration(seconds: 2);
  Curve _animationCurve = Curves.easeInOut;

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: _animationDuration,
          curve: _animationCurve,
          child: Text(
            'Flutter is Awesome!',
            style: TextStyle(fontSize: 24, color: Colors.blue),
          ),
        ),
        SizedBox(height: 20),
        DropdownButton<Curve>(
          value: _animationCurve,
          onChanged: (Curve? newValue) {
            setState(() {
              _animationCurve = newValue!;
            });
          },
          items: [
            DropdownMenuItem(child: Text('Ease In'), value: Curves.easeIn),
            DropdownMenuItem(child: Text('Ease Out'), value: Curves.easeOut),
            DropdownMenuItem(child: Text('Ease In Out'), value: Curves.easeInOut),
            DropdownMenuItem(child: Text('Bounce In'), value: Curves.bounceIn),
            DropdownMenuItem(child: Text('Bounce Out'), value: Curves.bounceOut),
          ],
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _toggleVisibility,
          child: Text('Play'),
        ),
      ],
    );
  }
}
