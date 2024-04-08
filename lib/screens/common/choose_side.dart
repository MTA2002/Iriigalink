import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:irrigalink/generated/l10n.dart';

class ChooseSide extends StatelessWidget {
  const ChooseSide({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(170, 217, 187, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Align(
                child: SizedBox(
                  height: 150,
                ),
              ),
              GestureDetector(
                onTap: () =>
                    {Navigator.of(context).pushNamed('/authenticate_farmer')},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(
                            0, 3), // changes the position of the shadow
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'images/i_am_farmer.jpeg',
                          width: 355,
                          height: 220,
                          fit: BoxFit
                              .cover, // You can adjust this based on your design
                        ),
                      ),
                      Positioned(
                        top: 180,
                        left: 20,
                        child: Text(
                          S.of(context).i_am_farmer,
                          style: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 180,
                        left: 300,
                        child: SvgPicture.asset('images/Ellipse 3.svg'),
                      ),
                      Positioned(
                        top: 188,
                        left: 309,
                        child: SvgPicture.asset('images/Ellipse 4.svg'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () =>
                    {Navigator.of(context).pushNamed('/authenticate_dist')},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(
                            0, 3), // changes the position of the shadow
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'images/i_am_dist.jpeg',
                          width: 355,
                          height: 220,
                          fit: BoxFit
                              .cover, // You can adjust this based on your design
                        ),
                      ),
                      Positioned(
                        top: 180,
                        left: 20,
                        child: Text(
                          S.of(context).i_am_dist,
                          style: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 180,
                        left: 300,
                        child: SvgPicture.asset(
                          'images/Ellipse 3.svg',
                        ),
                      ),
                      Positioned(
                        top: 188,
                        left: 309,
                        child: SvgPicture.asset(
                          'images/Ellipse 4.svg',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
