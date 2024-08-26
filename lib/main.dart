import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hesap Makinesi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String cikti = "0";
  String girdi = "";
  String operasyon = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text("Hesap Makinesi"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.centerRight,
                child: Text(
                  cikti,
                  style: const TextStyle(
                      fontSize: 40,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            buildButton()
          ],
        ),
      ),
    );
  }

  Widget buildButton() {
    return Column(
      children: [
        buildButtonRow(["7", "8", "9", "/"]),
        buildButtonRow(["4", "5", "6", "*"]),
        buildButtonRow(["1", "2", "3", "-"]),
        buildButtonRow(["C", "0", "=", "+"]),
      ],
    );
  }

  Widget buildButtonRow(List<String> buttons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.map((button) {
        return ElevatedButton(
          onPressed: () => _onButtonPressed(button),
          child: Text(button, style: const TextStyle(fontSize: 24)),
        );
      }).toList(),
    );
  }

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        // Eğer "C" butonuna basılırsa tüm değerleri sıfırla
        cikti = "0";
        girdi = "";
        operasyon = "";
      } else if (buttonText == "=") {
        // Eğer "=" butonuna basılırsa sonucu hesapla
        double sonuc = _hesapla();
        cikti = sonuc.toString();
        girdi = "";
        operasyon = "";
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "*" ||
          buttonText == "/") {
        // Eğer bir işlem operatörü seçilirse
        operasyon = buttonText;
        girdi = cikti; // İlk sayıyı girdi olarak kaydet
        cikti = ""; // Yeni sayıyı almak için çıktı sıfırlanır
      } else {
        // Sayılar tıklanırsa
        if (cikti == "0") {
          cikti = buttonText; // Eğer cikti 0 ise, yeni sayı ile değiştir
        } else {
          cikti += buttonText; // Mevcut sayıya tıklanan butonun değerini ekle
        }
      }
    });
  }

  double _hesapla() {
    double num1 = double.parse(girdi);
    double num2 = double.parse(cikti);

    switch (operasyon) {
      case "+":
        return num1 + num2;
      case "-":
        return num1 - num2;
      case "*":
        return num1 * num2;
      case "/":
        return num2 != 0 ? num1 / num2 : 0;
      default:
        return 0;
    }
  }
}
