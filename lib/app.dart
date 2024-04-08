import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:irrigalink/models/distributor_model.dart';
import 'package:irrigalink/models/farmer_model.dart';
import 'package:irrigalink/models/market_price_model.dart';
import 'package:irrigalink/route_animate.dart';
import 'package:irrigalink/screens/common/change_language.dart';
import 'package:irrigalink/screens/common/choose_side.dart';
import 'package:irrigalink/screens/common/contact_us.dart';
import 'package:irrigalink/screens/common/market%20price/market_price_detail.dart';
import 'package:irrigalink/screens/common/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:irrigalink/generated/l10n.dart';
import 'package:irrigalink/screens/distributor/authentication/authenticate_distributor.dart';
import 'package:irrigalink/screens/distributor/authentication/signup_screen.dart';
import 'package:irrigalink/screens/distributor/distributor_home_screen.dart';
import 'package:irrigalink/screens/distributor/farmers/farmers_detail.dart';
import 'package:irrigalink/screens/distributor/profile_screen.dart';
import 'package:irrigalink/screens/farmer/authentication/authenticate_farmer.dart';
import 'package:irrigalink/screens/common/login_screen.dart';
import 'package:irrigalink/screens/farmer/authentication/signup_screen.dart';
import 'package:irrigalink/screens/common/otp_verfication.dart';
import 'package:irrigalink/screens/common/chat/chat_detail.dart';
import 'package:irrigalink/screens/farmer/disributors/distributors_detail.dart';
import 'package:irrigalink/screens/farmer/farmer_home_screen.dart';
import 'package:irrigalink/screens/farmer/profile_screen.dart';
import 'package:irrigalink/services/chat_provider.dart';
import 'package:irrigalink/services/distributor_provider.dart';
import 'package:irrigalink/services/farmer_provider.dart';
import 'package:irrigalink/services/sensor_data_provider.dart';
import 'package:irrigalink/services/weather_location_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:irrigalink/screens/farmer/soil_info.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    final _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();

    // ignore: invalid_use_of_protected_member
    state!.setState(() {
      state.locale = newLocale;
    });
  }
}

class _MyAppState extends State<MyApp> {
  Locale locale = const Locale('en');
  Widget? initialWidget;
  @override
  void initState() {
    super.initState();
    _loadLanguage();
    findInitialWidget();
  }

  void findInitialWidget() async {
    initialWidget = await identifyUser();
  }

  Future<void> _loadLanguage() async {
    final languageCode = await getLanguage();
    setState(() {
      locale = Locale(languageCode);
    });
  }

  Future<String> getLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("language_code") ?? "en";
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FarmerProvider>(
          create: (context) => FarmerProvider(),
        ),
        ChangeNotifierProvider<DistributorProvider>(
          create: (context) => DistributorProvider(),
        ),
        ChangeNotifierProvider<ChatProvider>(
          create: (context) => ChatProvider(),
        ),
        ChangeNotifierProvider<WeatherDataProvider>(
          create: (context) => WeatherDataProvider(),
        ),
        ChangeNotifierProvider<SensorDataProvider>(
          create: (context) => SensorDataProvider(),
        ),
        ChangeNotifierProvider<MoistureProvider>(
          create: (context) => MoistureProvider(7),
        ),
      ],
      child: MaterialApp(
        locale: locale,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/choose_side':
              return createRoute(const ChooseSide());
            case '/authenticate_farmer':
              return createRoute(const AuthenticateFarmer());
            case '/sign_up_farmer':
              return createRoute(const FarmerSignupScreen());
            case '/otp_verification':
              List datas = settings.arguments as List;
              return createRoute(OtpVerificationScreen(datas: datas));
            case '/farmer_home_page':
              return createRoute(const FarmerHomePage());
            case '/change_language':
              return createRoute(const ChangeLanguage());
            case '/farmer_detail':
              final Farmer farmer = settings.arguments as Farmer;
              return createRoute(FarmerDetailPage(farmer: farmer));
            case '/market_price_detail':
              final MarketPrice farmer = settings.arguments as MarketPrice;
              return createRoute(MarketPriceDetailPage(marketPrice: farmer));
            case '/chat_detail':
              final List<dynamic> datas = settings.arguments as List<dynamic>;
              return createRoute(ChatDetails(
                currentUser: datas[0],
                otherUser: datas[1],
              ));
            case '/login':
              bool isFarmer = settings.arguments as bool;
              return createRoute(FarmerLoginScreen(isFarmer: isFarmer));
            case '/manage_profile_farmer':
              final Farmer farmer = settings.arguments as Farmer;
              return createRoute(ManageProfileFarmer(farmer: farmer));
            case '/authenticate_dist':
              return createRoute(const AuthenticateDistributor());
            case '/sign_up_dist':
              return createRoute(const DistributorSignupScreen());
            case '/dist_home_page':
              return createRoute(const DistributorHomePage());
            case '/manage_profile_dist':
              final Distributor distributor = settings.arguments as Distributor;
              return createRoute(
                  ManageProfileDistributor(distributor: distributor));
            case '/dist_detail':
              final Distributor distributor = settings.arguments as Distributor;
              return createRoute(
                  DistributorDetailPage(distributor: distributor));
            case '/soilInfo':
              return createRoute(const WheatProductionPage());
            case '/contact_us':
              return createRoute(const ContactUs());
            default:
              // Handle unknown routes
              return MaterialPageRoute(
                  builder: (context) => const SplashScreen());
          }
        },
        home: FutureBuilder(
          future: identifyUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return snapshot.data ?? const SplashScreen();
            } else {
              // Return a loading indicator or a different widget while loading
              return const Scaffold(
                  backgroundColor: Color.fromRGBO(170, 217, 187, 1),
                  body: Center(child: CircularProgressIndicator()));
            }
          },
        ),
      ),
    );
  }
}

Future<Widget> identifyUser() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isUsedLogedIn = auth.currentUser != null;
  if (isUsedLogedIn) {
    String? userPhoneNumber = auth.currentUser!.phoneNumber;
    CollectionReference farmers =
        FirebaseFirestore.instance.collection('farmers');
    QuerySnapshot<Object?> farmerQuery =
        await farmers.where("phone_number", isEqualTo: userPhoneNumber).get();

    if (farmerQuery.docs.isEmpty) {
      return const DistributorHomePage();
    } else {
      return const FarmerHomePage();
    }
  } else {
    return const SplashScreen();
  }
}
