import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:irrigalink/generated/l10n.dart';
import 'package:irrigalink/screens/common/market%20price/market_price_screen.dart';
import 'package:irrigalink/screens/common/chat/chat_list.dart';
import 'package:irrigalink/screens/farmer/disributors/distributors_list.dart';
import 'package:irrigalink/screens/farmer/farmer_drawer.dart';
import 'package:irrigalink/screens/farmer/sensor_data_screen.dart';
import 'package:irrigalink/screens/farmer/widgets/home.dart';
import 'package:irrigalink/services/farmer_provider.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class FarmerHomePage extends StatefulWidget {
  const FarmerHomePage({Key? key}) : super(key: key);

  @override
  State<FarmerHomePage> createState() => _FarmerHomePageState();
  static setIndex(BuildContext context, int index) {
    final _FarmerHomePageState? state =
        context.findAncestorStateOfType<_FarmerHomePageState>();
    // ignore: invalid_use_of_protected_member
    state!.setState(() {
      state._currentIndex = index;
    });
  }
}

class _FarmerHomePageState extends State<FarmerHomePage> {
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      HomePage(
        userName: Provider.of<FarmerProvider>(context, listen: false)
            .farmer!
            .name
            .split(' ')
            .first,
        userImage: 'images/distributor_home.png',
        user: S.of(context).distributors,
        userDescription: S.of(context).distributors_message,
        indexToGo1: 3,
        indexToGo2: 4,
      ),
      const SensorDataScreen(),
      const ChatList(),
      const DistibutorsList(),
      const MarketPriceList(),
    ];
    List<String> titles = [
      S.of(context).irrigaLink,
      S.of(context).sensorData.toUpperCase(),
      S.of(context).chats.toUpperCase(),
      S.of(context).distributors,
      S.of(context).marketPrice,
    ];

    context = context;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        title: Padding(
          padding: const EdgeInsets.fromLTRB(19, 32, 25, 20),
          child: Row(
            children: [
              Builder(
                builder: (context) => IconButton(
                  icon: SvgPicture.asset(
                    "images/menu-Bold.svg",
                    height: 30,
                    width: 30,
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
              const SizedBox(width: 13),
              Text(
                titles[_currentIndex],
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(80, 255, 251, 251),
        // backgroundColor: const Color.fromRGBO(170, 217, 187, 1),
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: screens[_currentIndex % 5],
      ),
      drawer: const Drawer(
        child: MyDrawer(),
      ),
      bottomNavigationBar: SafeArea(
        child: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            SalomonBottomBarItem(
              icon: Transform.scale(
                scale: 1.0,
                child: const ImageIcon(
                  AssetImage("images/home-button 1.png"),
                ),
              ),
              title: bottomBarText(S.of(context).home),
              selectedColor: const Color.fromARGB(255, 62, 175, 223),
            ),
            SalomonBottomBarItem(
              icon: Transform.scale(
                scale: 1.0,
                child: const ImageIcon(
                  AssetImage('images/sensor.png'),
                ),
              ),
              title: bottomBarText(S.of(context).sensorData),
              selectedColor: const Color.fromARGB(255, 125, 64, 231),
            ),
            SalomonBottomBarItem(
              icon: Transform.scale(
                scale: 1.0,
                child: const ImageIcon(
                  AssetImage('images/chat.png'),
                ),
              ),
              title: bottomBarText(S.of(context).chats),
              selectedColor: Colors.orange,
            ),
            SalomonBottomBarItem(
              icon: Transform.scale(
                scale: 1.0,
                child: const ImageIcon(
                  AssetImage('images/product.png'),
                ),
              ),
              title: bottomBarText(S.of(context).distributors),
              selectedColor: const Color.fromARGB(255, 204, 89, 6),
            ),
            SalomonBottomBarItem(
              icon: Transform.scale(
                scale: 1.0,
                child: const ImageIcon(
                  AssetImage("images/price-tag.png"),
                ),
              ),
              title: bottomBarText(S.of(context).marketPrice),
              selectedColor: const Color.fromARGB(255, 3, 154, 53),
            ),
          ],
        ),
      ),
    );
  }

  Padding bottomBarText(String text) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12, fontFamily: 'Inter'),
      ),
    );
  }
}
