import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Animated Opacity Example')),
        body: const Center(child: AnimatedTextToggle()),
      ),
    );
  }
}

class AnimatedTextToggle extends StatefulWidget {
  const AnimatedTextToggle({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AnimatedTextToggleState createState() => _AnimatedTextToggleState();
}

class _AnimatedTextToggleState extends State<AnimatedTextToggle> {
  bool _isVisible = true;
  final Duration _animationDuration = const Duration(seconds: 2);
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
          child: const Text(
            'Flutter is Awesome!',
            style: TextStyle(fontSize: 24, color: Colors.blue),
          ),
        ),
        const SizedBox(height: 20),
        DropdownButton<Curve>(
          value: _animationCurve,
          onChanged: (Curve? newValue) {
            setState(() {
              _animationCurve = newValue!;
            });
          },
          items: const [
            DropdownMenuItem(value: Curves.easeIn, child: Text('Ease In')),
            DropdownMenuItem(value: Curves.easeOut, child: Text('Ease Out')),
            DropdownMenuItem(value: Curves.easeInOut, child: Text('Ease In Out')),
            DropdownMenuItem(value: Curves.bounceIn, child: Text('Bounce In')),
            DropdownMenuItem(value: Curves.bounceOut, child: Text('Bounce Out')),
          ],
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _toggleVisibility,
          child: const Text('Play'),
        ),
      ],
    );
  }
}
