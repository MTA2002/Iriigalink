import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

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
        title: const Text(
          "Contact Us",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Montserrat',
          ),
        ),
        elevation: 0,
        backgroundColor: const Color.fromARGB(80, 255, 251, 251),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 30, 25, 30),
          child: Column(
            children: [
              contactUsCard('Contact Our Team', Icons.phone, '0929146352', () {
                launchUrl(Uri(scheme: 'tel', path: '0929146352'));
              }),
              const SizedBox(
                height: 30,
              ),
              contactUsCard(
                  'For all inquireies', Icons.mail, 'mahfouzteyib57@gmail.com',
                  () {
                launchUrl(
                    Uri(scheme: 'mailto', path: 'mahfouzteyib57@gmail.com'));
              }),
              const SizedBox(
                height: 30,
              ),
              contactUsCard(
                  'For Assistance', Icons.telegram, 'Live chat on Telegram',
                  () {
                launch('https://t.me/mta9402');
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget contactUsCard(
      String title, IconData iconData, String info, Function() callBack) {
    return GestureDetector(
      onTap: callBack,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color.fromARGB(255, 150, 205, 171),
            width: 3,
          ),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontFamily: 'Inter',
              ),
            ),
            Icon(
              iconData,
              color: const Color.fromARGB(255, 150, 205, 171),
              size: 70,
            ),
            Text(
              info,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
