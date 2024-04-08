import 'package:flutter/material.dart';
import 'package:irrigalink/app.dart';
import 'package:irrigalink/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int selectedIdx = 0;
  void saveLanguage(String languageCode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("language_code", languageCode);
  }

  void initIndex() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == "am") {
      selectedIdx = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    initIndex();
    List<String?> languages = [
      S.of(context).language1,
      S.of(context).language2,
    ];
    return Scaffold(
      backgroundColor: const Color.fromRGBO(170, 217, 187, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: languages[selectedIdx],
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Inter'),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedIdx = languages.indexOf(newValue);

                          if (selectedIdx == 1) {
                            MyApp.setLocale(context, const Locale('am'));
                            saveLanguage('am');
                          } else {
                            MyApp.setLocale(context, const Locale('en'));
                            saveLanguage('en');
                          }
                        });
                      },
                      items: languages
                          .map<DropdownMenuItem<String>>((String? value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value ?? S.of(context).language1,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Image.asset(
                "images/farm 2.png",
                width: 241,
                height: 267,
              ),
              const SizedBox(
                height: 60,
              ),
              Text(
                S.of(context).welcome_splash,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontFamily: 'Inter',
                  height: 1.5,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // Text color
                  backgroundColor: const Color.fromARGB(255, 251, 240, 240),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(220, 20),
                ),
                onPressed: () {
                  // Add your onPressed logic here
                  Navigator.of(context).pushReplacementNamed('/choose_side');
                },
                child: Text(
                  S.of(context).get_started,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    fontFamily: 'Inter',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
