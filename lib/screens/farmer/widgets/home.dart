import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:irrigalink/generated/l10n.dart';
import 'package:irrigalink/screens/distributor/distributor_home_screen.dart';
import 'package:irrigalink/screens/farmer/farmer_home_screen.dart';
import 'package:irrigalink/services/distributor_provider.dart';
import 'package:irrigalink/services/farmer_provider.dart';
import 'package:irrigalink/services/weather_location_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      {super.key,
      required this.user,
      required this.userDescription,
      required this.userImage,
      required this.indexToGo1,
      required this.indexToGo2,
      required this.userName});
  final String user;
  final String userDescription;
  final String userImage;
  final int indexToGo1;
  final int indexToGo2;
  final String userName;
  @override
  State<HomePage> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage> {
  Color allColor1 = const Color.fromRGBO(0, 136, 145, 1);
  Color allColor2 = const Color.fromRGBO(0, 136, 145, 1);
  Color fruitColor1 = Colors.white;
  Color fruitColor2 = Colors.black;
  Color vegColor1 = Colors.white;
  Color vegColor2 = Colors.black;
  Color otherColor1 = Colors.white;
  Color otherColor2 = Colors.black;
  String getCorrectName() {
    if (widget.user.characters.first ==
        S.of(context).distributors.characters.first) {
      return Provider.of<FarmerProvider>(context, listen: true).farmer!.name;
    } else {
      return Provider.of<DistributorProvider>(context, listen: true)
          .distributor!
          .name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18.0, 8, 8, 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "${S.of(context).welcome}, ",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(79, 105, 107, 1),
                  ),
                ),
                Text(
                  getCorrectName().split(' ').first,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(0, 136, 145, 1),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            searchBar(context),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).categories,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "+ ${S.of(context).add_more}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(89, 200, 133, 1),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 45,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        allColor1 = const Color.fromRGBO(0, 136, 145, 1);
                        allColor2 = const Color.fromRGBO(0, 136, 145, 1);
                        fruitColor1 = Colors.white;
                        fruitColor2 = Colors.black;
                        vegColor1 = Colors.white;
                        vegColor2 = Colors.black;
                        otherColor1 = Colors.white;
                        otherColor2 = Colors.black;
                      });
                    },
                    child: categoryTab(S.of(context).all, allColor1, allColor2),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        fruitColor1 = const Color.fromRGBO(0, 136, 145, 1);
                        fruitColor2 = const Color.fromRGBO(0, 136, 145, 1);
                        allColor1 = Colors.white;
                        allColor2 = Colors.black;
                        vegColor1 = Colors.white;
                        vegColor2 = Colors.black;
                        otherColor1 = Colors.white;
                        otherColor2 = Colors.black;
                      });
                    },
                    child: categoryTab(
                        S.of(context).fruits, fruitColor1, fruitColor2),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        vegColor1 = const Color.fromRGBO(0, 136, 145, 1);
                        vegColor2 = const Color.fromRGBO(0, 136, 145, 1);
                        fruitColor1 = Colors.white;
                        fruitColor2 = Colors.black;
                        allColor1 = Colors.white;
                        allColor2 = Colors.black;
                        otherColor1 = Colors.white;
                        otherColor2 = Colors.black;
                      });
                    },
                    child: categoryTab(
                        S.of(context).vegetables, vegColor1, vegColor2),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        otherColor1 = const Color.fromRGBO(0, 136, 145, 1);
                        otherColor2 = const Color.fromRGBO(0, 136, 145, 1);
                        fruitColor1 = Colors.white;
                        fruitColor2 = Colors.black;
                        vegColor1 = Colors.white;
                        vegColor2 = Colors.black;
                        allColor1 = Colors.white;
                        allColor2 = Colors.black;
                      });
                    },
                    child: categoryTab(
                        S.of(context).other, otherColor1, otherColor2),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              height: 85,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  fruitsTab('images/fruit_potato.png'),
                  const SizedBox(
                    width: 6,
                  ),
                  fruitsTab('images/fruit_banana.png'),
                  const Size
                  
                  dBox(
                    width: 6,
                  ),
                  fruitsTab('images/fruit_apple.png'),
                  const SizedBox(
                    width: 6,
                  ),
                  fruitsTab('images/fruit_cabage.png'),
                  const SizedBox(
                    width: 6,
                  ),
                  fruitsTab('images/fruit_avocado.png'),
                  const SizedBox(
                    width: 6,
                  ),
                  fruitsTab('images/fruit_tomato.png'),
                  const SizedBox(
                    width: 6,
                  ),
                  fruitsTab('images/fruit_mango.png'),
                  const SizedBox(
                    width: 6,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            featureCard(
              widget.userImage,
              SvgPicture.asset(
                'images/person_icon.svg',
                height: 18,
                width: 18,
              ),
              widget.user,
              widget.userDescription,
              widget.indexToGo1,
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              S.of(context).weather,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            weatherCard(
              Provider.of<WeatherDataProvider>(context, listen: true)
                  .weatherData!
                  .temperature,
              Provider.of<WeatherDataProvider>(context, listen: true)
                  .weatherData!
                  .maxTemp,
              Provider.of<WeatherDataProvider>(context, listen: true)
                  .weatherData!
                  .minTemp,
            ),
            const SizedBox(
              height: 24,
            ),
            featureCard(
              'images/market_price_home.png',
              SvgPicture.asset(
                'images/market_price_icon.svg',
                height: 18,
                width: 18,
              ),
              S.of(context).marketPrice,
              S.of(context).marketPriceMessage,
              widget.indexToGo2,
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              S.of(context).testimony,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 251,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  testimonyCard('images/farmer_profile.jpeg', 'Mahfouz Teyib',
                      'Farmers love our app! It helps me monitor my crops efficiently and make better decisions.'),
                  const SizedBox(
                    width: 8,
                  ),
                  testimonyCard('images/farm 2.png', 'Abebe Kebede',
                      'The Sensor page has made managing my farm easier. It\'s a game-changer for our business.'),
                  const SizedBox(
                    width: 8,
                  ),
                  testimonyCard('images/distr_profile.jpeg', 'Hawi Abdi',
                      'The distributor page has made managing orders a breeze. It\'s a game-changer for our business.'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget searchBar(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromRGBO(120, 130, 157, 0.1),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 5,
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color.fromRGBO(0, 136, 145, 1),
                        size: 30,
                      ),
                      hintText: S.of(context).looking_for,
                      hintStyle: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(120, 130, 157, 0.9),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget categoryTab(String text, Color borderColor, Color textColor) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Adjusted border radius
      ),
      color: Colors.white,
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 5, 16, 3),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16), // Adjusted border radius
          border: Border.all(
            color: borderColor,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget fruitsTab(String fruitPath) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Adjusted border radius
      ),
      color: Colors.white,
      elevation: 2,
      child: Container(
        height: 80,
        width: 80,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12), // Adjusted border radius
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16), // Image border
          child: SizedBox.fromSize(
            size: const Size.fromRadius(48), // Image radius
            child: Image.asset(fruitPath, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }

  Widget featureCard(String imagePath, Widget icon, String title,
      String description, int indexToGo) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Adjusted border radius
      ),
      elevation: 2,
      child: SizedBox(
        height: 400,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24), // Image border
              child: SizedBox.fromSize(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  height: 600,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          icon,
                          // Icon(
                          //   iconData,
                          //   color: const Color.fromRGBO(0, 136, 145, 1),
                          // ),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SvgPicture.asset(
                        'images/line.svg',
                        width: 340,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        description,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(0, 0, 0, 0.43),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (widget.user.characters.first == "D") {
                            FarmerHomePage.setIndex(context, indexToGo);
                          } else {
                            DistributorHomePage.setIndex(context, indexToGo);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(0, 136, 145, 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              S.of(context).explore,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget weatherCard(double temprature, double maxTemp, double minTemp) {
    IconData? weatherIcon;
    String? weatherDay;
    Color? weatherColor;
    if (temprature < 10) {
      weatherIcon = Icons.cloudy_snowing;
      weatherDay = S.of(context).rainy_day;
      weatherColor = Colors.grey;
    } else if (temprature < 20) {
      weatherIcon = Icons.cloud;
      weatherDay = S.of(context).cloudy_day;
      weatherColor = Colors.grey;
    } else {
      weatherIcon = Icons.sunny;
      weatherDay = S.of(context).sunny_day;
      weatherColor = Colors.orange;
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Adjusted border radius
        ),
        color: Colors.white,
        elevation: 2,
        child: Container(
          padding: EdgeInsets.all(16),
          // height: 113,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(11.5), // Adjusted border radius
                ),
                color: Colors.white,
                elevation: 2,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  // height: 81,
                  // width: 144,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(11.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${temprature.toInt().toString()}\u00B0C",
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(0, 136, 145, 1),
                        ),
                      ),
                      Text(
                        "$weatherDay ${maxTemp.toInt()}/${minTemp.toInt()}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(0, 0, 0, 0.53),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(11.5), // Adjusted border radius
                ),
                color: Colors.white,
                elevation: 2,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 81,
                  width: 144,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(11.5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        weatherIcon,
                        color: weatherColor,
                        size: 32,
                      ),
                      Text(
                        "${S.of(context).feels_like} ${temprature.toInt()}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(0, 0, 0, 0.53),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget testimonyCard(
      String personImage, String personName, String testimony) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Adjusted border radius
      ),
      color: Colors.white,
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        width: 220,
        height: 241,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16), // Image border
              child: SizedBox.fromSize(
                size: const Size.fromRadius(30), // Image radius
                child: Image.asset(personImage, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'images/person_icon.svg',
                  height: 16,
                  width: 16,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  personName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(11.5), // Adjusted border radius
              ),
              color: Colors.white,
              elevation: 2,
              child: Container(
                height: 100,
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11.5),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Text(
                    testimony,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(0, 0, 0, 0.43),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
