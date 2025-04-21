import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoEkskul',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xFFE04E4E), // Warna merah yang sudah diupdate
        fontFamily: 'Roboto', // Font bawaan sebagai alternatif Montserrat
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

// Splash Screen
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _logoAnimation;

  late AnimationController _imageController;
  late Animation<Offset> _imageAnimation;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );
    _logoAnimation = CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeInOutBack,
    );

    _imageController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _imageAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _imageController,
      curve: Curves.easeOutCubic,
    ));

    _logoController.forward();
    _imageController.forward();

    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 800),
          pageBuilder: (_, __, ___) => WelcomePage(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            // Memindahkan logo ke atas dengan menggunakan Transform
            child: Transform.translate(
              offset: Offset(0, -40), // Pindahkan ke atas 40 pixel
              child: ScaleTransition(
                scale: _logoAnimation,
                child: Image.asset(
                  'assets/group92.png', // Gambar logo
                  width: 250,
                  height: 100,
                ),
              ),
            ),
          ),
          // GAMBAR muncul dari bawah
          Align(
            alignment: Alignment.bottomCenter,
            child: SlideTransition(
              position: _imageAnimation,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Image.asset(
                  'assets/spenda1.png',
                  width: 230,
                  height: 200,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Welcome Page
class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1000));

    _offsetAnimation = Tween<Offset>(
      begin: Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double buttonHeight = 50; // Tombol lebih pendek sesuai permintaan
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _offsetAnimation,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  // Gambar logo
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Image.asset(
                      'assets/logokedua.png', 
                      width: 500,
                      height: 500, // Ukuran gambar dikurangi untuk lebih dekat dengan teks
                    ),
                  ),
                  // Jarak antara gambar dan teks dikurangi sesuai permintaan
                  SizedBox(height: 10),
                  Text(
                    'Selamat Datang',
                    style: TextStyle(
                      fontFamily: 'Roboto', // Font bawaan sebagai alternatif
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  // Jarak antara teks dan tombol
                  SizedBox(height: 40),
                  // Tombol Masuk - lebih lebar tetapi lebih pendek
                  SizedBox(
                    width: screenWidth * 0.85, // Tombol lebih lebar, 85% dari lebar layar
                    height: buttonHeight, // Tinggi lebih pendek
                    child: ElevatedButton(
                      onPressed: () {
                        // Aksi Masuk
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFE04E4E), // Warna merah yang diupdate
                        foregroundColor: Colors.white,
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: Text('Masuk'),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Tombol Daftar - lebih lebar tetapi lebih pendek
                  SizedBox(
                    width: screenWidth * 0.85, // Tombol lebih lebar, 85% dari lebar layar
                    height: buttonHeight, // Tinggi lebih pendek
                    child: OutlinedButton(
                      onPressed: () {
                        // Aksi Daftar
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Color(0xFFE04E4E), // Warna merah yang diupdate
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide(color: Color(0xFFE04E4E), width: 1.5), // Warna merah yang diupdate
                      ),
                      child: Text('Daftar'),
                    ),
                  ),
                  // Ruang kosong di bawah
                  Expanded(
                    child: SizedBox(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}