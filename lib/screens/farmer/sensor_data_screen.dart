import 'package:flutter/material.dart';
import 'package:irrigalink/generated/l10n.dart';
import 'package:irrigalink/models/farmer_model.dart';
import 'package:irrigalink/services/farmer_provider.dart';
import 'package:irrigalink/services/sensor_data_provider.dart';
import 'package:irrigalink/services/weather_location_provider.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SensorDataScreen extends StatefulWidget {
  const SensorDataScreen({Key? key}) : super(key: key);

  @override
  State<SensorDataScreen> createState() => _SensorDataScreenState();
}

class _SensorDataScreenState extends State<SensorDataScreen> {
  bool? isFarmConfigured;
  String location = "";
  late TooltipBehavior _tooltip;
  Farmer? farmer;
  List<ChartData>? dummyData;
  @override
  void initState() {
    super.initState();
    farmer = Provider.of<FarmerProvider>(context, listen: false).farmer!;
    isFarmConfigured = farmer!.isFarmConfigured;
    // Change to your translation
    _tooltip = TooltipBehavior(enable: true);
    dummyData = [
      ChartData(dayOfWeek: 'Tue'),
      ChartData(dayOfWeek: 'Mon'),
      ChartData(dayOfWeek: 'Sun'),
      ChartData(dayOfWeek: 'Sat'),
      ChartData(dayOfWeek: 'Fri'),
      ChartData(dayOfWeek: 'Thr'),
      ChartData(dayOfWeek: 'Wed'),
    ];
  }

  bool isAutomaticMode = false;
  bool isPumpOn = false;

  @override
  Widget build(BuildContext context) {
    location = "${farmer!.location}, ${S.of(context).ethiopia}";
    return isFarmConfigured == false
        ? Center(child: Text(S.of(context).farmNotConfiguredMessage))
        : ListView(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    location,
                    style: const TextStyle(
                      fontSize: 18.5,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat',
                      color: Color.fromARGB(255, 2, 33, 58),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              CustomCard2(
                content: weatherCard(),
              ),
              const SizedBox(height: 20),
              CustomCard(
                content: soilMoistureRadialSeekBar(),
              ),
              const SizedBox(height: 20),
              _buildSoilMoistureChart(),
              const SizedBox(height: 20),
              CustomCard(
                content: switchModes(),
              ),
            ],
          );
  }

  Widget weatherCard() {
    Widget? icon;
    String recommendation = "";
    if (Provider.of<WeatherDataProvider>(context, listen: true)
            .weatherData!
            .temperature <
        10) {
      icon = const Icon(
        Icons.cloudy_snowing,
        color: Colors.white,
        size: 130,
      );
      recommendation = S.of(context).manualModeRecommendation;
    } else if (Provider.of<WeatherDataProvider>(context, listen: true)
            .weatherData!
            .temperature <
        24) {
      icon = const Icon(
        Icons.cloud,
        color: Colors.white,
        size: 130,
      );
      recommendation = S.of(context).manualModeRecommendation;
    } else {
      icon = Icon(
        Icons.wb_sunny_rounded,
        color: Colors.orange.shade300,
        size: 130,
      );
      recommendation = S.of(context).automaticModeRecommendation;
    }
    return Row(
      children: [
        Expanded(child: icon),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).currentWeather,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade50,
                    fontFamily: 'Montserrat',
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "${Provider.of<WeatherDataProvider>(context, listen: true).weatherData!.temperature.toString()}\u00B0C",
                  style: TextStyle(
                    fontSize: 34,
                    fontFamily: 'Montserrat',
                    color: Colors.blueGrey.shade50,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  recommendation,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                    color: Colors.blueGrey.shade50,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget soilMoistureRadialSeekBar() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wb_sunny, color: Colors.orange),
            const SizedBox(width: 8),
            Text(
              S.of(context).soilMoistureSensorData,
              style: const TextStyle(
                fontSize: 18.5,
                fontWeight: FontWeight.w600,
                fontFamily: 'Montserrat',
                color: Color.fromARGB(255, 18, 81, 132),
              ),
            ),
          ],
        ),
        const SizedBox(height: 26),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                const Icon(
                  Icons.invert_colors,
                  color: Colors.blue,
                ),
                Text(
                  S.of(context).moistureLevel,
                  style: TextStyle(fontSize: 16, fontFamily: 'Montserrat'),
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
            SleekCircularSlider(
              appearance: CircularSliderAppearance(
                customColors: CustomSliderColors(
                  trackColor: Colors.blue.shade200,
                  progressBarColors: [
                    const Color.fromARGB(255, 42, 74, 4),
                    Colors.blue.shade500
                  ],
                  shadowMaxOpacity: 20.0,
                ),
                infoProperties: InfoProperties(
                    topLabelText:
                        Provider.of<SensorDataProvider>(context, listen: true)
                            .status!,
                    topLabelStyle: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      color: Colors.blueGrey.shade900,
                    )),
              ),
              initialValue:
                  Provider.of<SensorDataProvider>(context, listen: true)
                      .moistureValue!,
            ),
          ],
        ),
      ],
    );
  }

  Widget switchModes() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.of(context).switchModes,
              style: const TextStyle(
                fontSize: 18.5,
                fontWeight: FontWeight.w600,
                fontFamily: 'Montserrat',
                color: Color.fromARGB(255, 18, 81, 132),
              ),
            ),
            const Icon(
              Icons.lightbulb_outline,
              color: Color.fromARGB(255, 229, 207, 9),
              size: 24,
            ),
          ],
        ),
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isAutomaticMode = !isAutomaticMode;
                  if (isAutomaticMode) {
                    _startAutomaticMode();
                  }
                });
              },
              child: Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isAutomaticMode
                      ? Colors.green.shade300
                      : Colors.blue.shade300,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isAutomaticMode ? Icons.wb_auto : Icons.settings,
                        color: Colors.white,
                        size: 32,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        isAutomaticMode
                            ? S.of(context).auto
                            : S.of(context).manual,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  isAutomaticMode
                      ? S.of(context).automaticModeEnabled
                      : S.of(context).manualModeEnabled,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                  ),
                  textAlign: TextAlign.center,
                ),
                if (!isAutomaticMode)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Add your logic to turn the pump on
                        isPumpOn = !isPumpOn;
                        setState(() {
                          if (isPumpOn) {
                            SensorDataProvider.setMode(0);
                          } else {
                            SensorDataProvider.setMode(1);
                          }
                        });
                      },
                      icon: const Icon(
                        Icons.power_settings_new,
                        color: Colors.white,
                      ),
                      label: Text(
                        isPumpOn == false
                            ? S.of(context).turnOn
                            : S.of(context).turnOff,
                        style: const TextStyle(
                            fontFamily: 'Montserrat', color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isPumpOn == false
                            ? Colors.green
                            : Colors.red.shade400,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
              ],
            )
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void _startAutomaticMode() {
    Future.delayed(Duration(seconds: 5), () {
      if (isAutomaticMode) {
        _startAutomaticMode();
      }
    });
  }

  Widget _buildSoilMoistureChart() {
    return CustomCard(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                S.of(context).last7DaysSoilMoisture,
                style: const TextStyle(
                  fontSize: 18.5,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat',
                  color: Color.fromARGB(255, 18, 81, 132),
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.bar_chart, color: Colors.lightBlue.shade300),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 200,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
              tooltipBehavior: _tooltip,
              series: <ChartSeries<ChartData, String>>[
                ColumnSeries<ChartData, String>(
                  dataSource: dummyData!,
                  // Provider.of<MoistureProvider>(context, listen: false)
                  //     .chartData!,
                  xValueMapper: (ChartData data, _) => data.dayOfWeek,
                  yValueMapper: (ChartData data, _) => data.y,
                  width: 0.5,
                  color: Colors.blue.shade300,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final Widget content;

  const CustomCard({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(211, 255, 255, 255),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: content,
        ),
      ),
    );
  }
}

class CustomCard2 extends StatelessWidget {
  final Widget content;

  const CustomCard2({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(123, 199, 221, 1),
              Color.fromRGBO(98, 161, 199, 1),
            ],
          ),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: content,
        ),
      ),
    );
  }
}
