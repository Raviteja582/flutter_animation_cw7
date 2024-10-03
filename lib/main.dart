import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Rotating Image Example')),
        body: const Center(child: AnimatedTextToggle()),
      ),
    );
  }
}

class AnimatedTextToggle extends StatefulWidget {
  const AnimatedTextToggle({super.key});

  @override
  _AnimatedTextToggleState createState() => _AnimatedTextToggleState();
}

class _AnimatedTextToggleState extends State<AnimatedTextToggle>
    with SingleTickerProviderStateMixin {
  bool _isVisible = true;
  bool _showFrame = false;
  final Duration _animationDuration = const Duration(seconds: 2);
  Curve _animationCurve = Curves.easeInOut;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
        GestureDetector(
          onTap: _toggleVisibility,
          child: AnimatedOpacity(
            opacity: _isVisible ? 1.0 : 0.0,
            duration: const Duration(seconds: 1),
            child: const Text(
              'Flutter is Awesome!',
              style: TextStyle(fontSize: 24, color: Colors.blue),
            ),
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
        const SizedBox(height: 20),
        SwitchListTile(
          title: const Text('Show Frame'),
          value: _showFrame,
          onChanged: (bool value) {
            setState(() {
              _showFrame = value;
            });
          },
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: _toggleVisibility,
          child: AnimatedOpacity(
            opacity: _isVisible ? 1.0 : 0.0,
            duration: _animationDuration,
            curve: _animationCurve,
            child: RotationTransition(
              turns: _controller,
              child: Container(
                decoration: BoxDecoration(
                  border: _showFrame
                      ? Border.all(color: Colors.blue, width: 4.0)
                      : null,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.network(
                  'https://picsum.photos/200/300',
                  width: 150,
                  height: 150,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
