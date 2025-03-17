// C:\Users\Administrateur\Desktop\recharges\projet\lib\screens\splash_screen.dart

import 'package:flutter/material.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RotationTransition(
              turns: _controller,
              child: Image.network(
                'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/logoplatform-DgxAovCp3okoOLDVEuBm1Y9jk5vqiT.png',
                height: 100,
                width: 100,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'PrepayConnect',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF06B6D4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
