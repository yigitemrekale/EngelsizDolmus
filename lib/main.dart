import 'package:flutter/material.dart';
import 'dart:async'; // Zamanlayıcı için gerekli

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(), // İlk açılışta giriş ekranı gösterilecek
    );
  }
}

//------------------------------- GİRİŞ EKRANI (Splash Screen)-------------------------------
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // 3 saniye sonra ana sayfaya yönlendirme
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
          "assets/giris_ekrani.png", // 📌 Giriş ekranı için resim
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
  String yolcuButonResmi = "assets/yolcu_buton.png";
  String soforButonResmi = "assets/sofor_buton.png";

  // 📌 Tıklanınca değişecek resimler
  final String yolcuTiklanmis = "assets/yolcu_buton_tiklandi.png";
  final String soforTiklanmis = "assets/sofor_buton_tiklandi.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Arka plan resmi
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/arka_plan.png"), // Arka plan yolu
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Butonlar
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Yolcu Butonu
                GestureDetector(
                  onTapDown: (_) {
                    setState(() {
                      yolcuButonResmi = yolcuTiklanmis; // Basınca değiş
                    });
                  },
                  onTapUp: (_) {
                    setState(() {
                      yolcuButonResmi = "assets/yolcu_buton.png"; // Parmağı kaldırınca eski haline dön
                    });
                  },
                  onTapCancel: () {
                    setState(() {
                      yolcuButonResmi = "assets/yolcu_buton.png"; // Parmağı kaydırıp kaldırırsa eski haline dön
                    });
                  },
                  child: SizedBox(
                    width: 180,
                    height: 80,
                    child: Image.asset(
                      yolcuButonResmi,
                      fit: BoxFit.contain, // 📌 Resmi boyuta göre büyütüp küçült
                    ),
                  ),
                ),

                // Şoför Butonu
                GestureDetector(
                  onTapDown: (_) {
                    setState(() {
                      soforButonResmi = soforTiklanmis; // Basınca değiş
                    });
                  },
                  onTapUp: (_) {
                    setState(() {
                      soforButonResmi = "assets/sofor_buton.png"; // Parmağı kaldırınca eski haline dön
                    });
                  },
                  onTapCancel: () {
                    setState(() {
                      soforButonResmi = "assets/sofor_buton.png"; // Parmağı kaydırıp kaldırırsa eski haline dön
                    });
                  },
                  child: SizedBox(
                    width: 180,
                    height: 80,
                    child: Image.asset(
                      soforButonResmi,
                      fit: BoxFit.contain, // 📌 Resmi boyuta göre büyütüp küçült
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
