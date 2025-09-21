import 'package:flutter/material.dart';

void main()=> runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState()=> _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;
  void _toggleTheme() {
    setState(() {
      _themeMode=
          _themeMode==ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CW1 App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: HomePage(onToggleTheme: _toggleTheme),
    );
  }
}

class HomePage extends StatefulWidget {
  final VoidCallback onToggleTheme;
  const HomePage({Key? key, required this.onToggleTheme}) : super(key: key);

  @override
  State<HomePage> createState()=>_HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  bool _showFirstImage = true;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration:const Duration(milliseconds: 700));
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  void _toggleImage() {
    setState(() {
      _showFirstImage= !_showFirstImage;
    });
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CW1 Flutter App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
//Task 1: Counter Button
            Text(
              'You have pushed this button this many times: $_counter',
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _increment,
              child: const Text('Increment'),
            ),

            const SizedBox(height: 40),

//Task 2: Image Toggle with Fade 
            FadeTransition(
              opacity: _fadeAnimation,
              child: Image.network(
                _showFirstImage
                    ? 'https://images.unsplash.com/photo-1758380388614-66e9fd1aa159?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
                    : 'https://images.unsplash.com/photo-1756142753970-72d9849dd73e?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                height: 200,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleImage,
              child: const Text('toggle Image'),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: widget.onToggleTheme,
              child: const Text('Toggle Light/Dark theme'),
            ),
          ],
        ),
      ),
    );
  }
}
