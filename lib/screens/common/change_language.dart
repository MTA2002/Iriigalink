import 'package:flutter/material.dart';
import 'package:irrigalink/app.dart';
import 'package:irrigalink/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeLanguage extends StatefulWidget {
  const ChangeLanguage({super.key});

  @override
  State<ChangeLanguage> createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  void saveLanguage(String languageCode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("language_code", languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            size: 35,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          S.of(context).change_language,
          style: const TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Color.fromARGB(80, 255, 251, 251),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  MyApp.setLocale(context, const Locale('en'));
                  saveLanguage('en');
                });
              },
              style: ElevatedButton.styleFrom(
                // Set the background color
                minimumSize: const Size(120, 40),
                backgroundColor: const Color.fromRGBO(98, 142, 144, 1),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20.0), // Set the border radius
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 15.0), // Set padding
              ),
              child: Text(
                S.of(context).language1,
                style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontFamily: 'Inter' // Set text color
                    ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              S.of(context).or,
              style: const TextStyle(
                fontSize: 22,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  MyApp.setLocale(context, const Locale('am'));
                  saveLanguage('am');
                });
              },
              style: ElevatedButton.styleFrom(
                // Set the background color
                minimumSize: const Size(120, 40),
                backgroundColor: const Color.fromRGBO(98, 142, 144, 1),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20.0), // Set the border radius
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 15.0), // Set padding
              ),
              child: Text(
                S.of(context).language2,
                style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontFamily: 'Inter' // Set text color
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
