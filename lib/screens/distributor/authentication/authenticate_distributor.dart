import 'package:flutter/material.dart';
import 'package:irrigalink/generated/l10n.dart';

class AuthenticateDistributor extends StatelessWidget {
  const AuthenticateDistributor({super.key});

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
        elevation: 0,
        backgroundColor: const Color.fromRGBO(170, 217, 187, 1),
      ),
      backgroundColor: const Color.fromRGBO(170, 217, 187, 1),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 120,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Transform.scale(
                  scale: 1.2,
                  child: const Image(
                    image: AssetImage('images/dist_img (1).png'),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 80,
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
                Navigator.of(context).pushNamed('/sign_up_dist');
              },
              child: Text(
                S.of(context).sign_up,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                  fontFamily: 'Inter',
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
                Navigator.of(context).pushNamed('/login', arguments: false);
              },
              child: Text(
                S.of(context).login,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
