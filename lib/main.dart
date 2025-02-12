import 'package:engelsizdolmus/sofor_login.dart';
import 'package:engelsizdolmus/user_login.dart';
import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

//------------------------------- GİRİŞ EKRANI -------------------------------
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/giris_ekrani.png",
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

//------------------------------- ANA EKRAN -------------------------------
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 📌 Butonların varsayılan resimleri
  String yolcuButonResmi = "assets/kullanici_button.png";
  String soforButonResmi = "assets/sofor_button.png";

  // 📌 Tıklanınca değişecek resimler
  final String yolcuTiklanmis = "assets/kullanici_buttontiklama.png";
  final String soforTiklanmis = "assets/sofor_buttontiklama.png";

  bool isListening = false;
  double rippleSize = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // 📌 Arka Plan Resmi
          Positioned.fill(
            child: Image.asset(
              "assets/arka_plan.png",
              fit: BoxFit.cover,
            ),
          ),

          // 📌 Butonlar (Ortalı)
          Positioned(
            top: screenHeight * 0.35,
            child: Column(
              children: [
                // Yolcu Butonu
                GestureDetector(
                  onTapDown: (_) =>
                      setState(() => yolcuButonResmi = yolcuTiklanmis),
                  onTapUp: (_) => setState(
                      () => yolcuButonResmi = "assets/kullanici_button.png"),
                  onTapCancel: () => setState(
                      () => yolcuButonResmi = "assets/kullanici_button.png"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserLogin()),
                    );
                  },
                  child: SizedBox(
                    width: screenWidth * 0.6,
                    height: screenHeight * 0.08,
                    child: Image.asset(yolcuButonResmi, fit: BoxFit.contain),
                  ),
                ),

                const SizedBox(height: 20), // 📌 Butonlar arası boşluk

                // Şoför Butonu
                GestureDetector(
                  onTapDown: (_) =>
                      setState(() => soforButonResmi = soforTiklanmis),
                  onTapUp: (_) => setState(
                      () => soforButonResmi = "assets/sofor_button.png"),
                  onTapCancel: () => setState(
                      () => soforButonResmi = "assets/sofor_button.png"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SoforLogin()),
                    );
                  },
                  child: SizedBox(
                    width: screenWidth * 0.6,
                    height: screenHeight * 0.08,
                    child: Image.asset(soforButonResmi, fit: BoxFit.contain),
                  ),
                ),
              ],
            ),
          ),

          // 📌 Özel Resimli Buton (Mikrofon yerine kendi resmin)
          Positioned(
            bottom: screenHeight * 0.07,
            child: GestureDetector(
              onTapDown: (_) => setState(() {
                isListening = true;
                rippleSize = 200;
              }),
              onTapUp: (_) => setState(() {
                isListening = false;
                rippleSize = 0;
              }),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // 📌 Dalga Efekti (Tıklanınca büyüyen animasyon)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    width: rippleSize,
                    height: rippleSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.withOpacity(0.3),
                    ),
                  ),

                  // 📌 Özel Resimli Buton (Kendi resmini kullanabilirsin)
                  Container(
                    width: screenWidth * 0.18,
                    height: screenWidth * 0.18,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            spreadRadius: 3),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        "assets/sesli_asistan.png", // 📌 Buraya kendi resmini koy
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
