import 'package:flutter/material.dart';

class WheatProductionPage extends StatelessWidget {
  const WheatProductionPage({super.key});

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
          "Soil Insights for Wheat",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Montserrat',
          ),
        ),
        elevation: 0,
        backgroundColor: Color.fromARGB(80, 255, 251, 251),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Common Soil Types for Wheat Production in Ethiopia',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  SizedBox(height: 10.0),
                  ListTile(
                    title: Text(
                      '1. Vertisols',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '- Characteristics: High clay content, swelling and shrinking properties, low permeability.',
                          style: TextStyle(fontFamily: 'Inter'),
                        ),
                        Text(
                          '- Location: Chercher highlands, Northern rift, coastal zones, etc.',
                          style: TextStyle(fontFamily: 'Inter'),
                        ),
                      ],
                    ),
                    leading: Icon(Icons.layers, size: 30),
                  ),
                  SizedBox(height: 10.0),
                  ListTile(
                    title: Text(
                      '2. Nitisols',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '- Characteristics: Well-drained soils with moderate fertility.',
                          style: TextStyle(fontFamily: 'Inter'),
                        ),
                        Text(
                          '- Location: South-western and north-central highlands.',
                          style: TextStyle(fontFamily: 'Inter'),
                        ),
                      ],
                    ),
                    leading: Icon(Icons.layers, size: 30),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Soil Properties for Wheat Production',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  SizedBox(height: 10.0),
                  ListTile(
                    title: Text(
                      '1. Soil Texture',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    subtitle: Text(
                      '- Wheat prefers well-drained soils with a loamy texture.',
                      style: TextStyle(fontFamily: 'Inter'),
                    ),
                    leading: Icon(Icons.texture, size: 30),
                  ),
                  ListTile(
                    title: Text(
                      '2. Soil pH',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    subtitle: Text(
                      '- Wheat thrives in slightly acidic to neutral soils (pH 6.0 to 7.5).',
                      style: TextStyle(fontFamily: 'Inter'),
                    ),
                    leading: Icon(Icons.waves, size: 30),
                  ),
                  ListTile(
                    title: Text(
                      '3. Soil Fertility',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    subtitle: Text(
                      '- Adequate levels of essential nutrients (nitrogen, phosphorus, potassium) are crucial.',
                      style: TextStyle(fontFamily: 'Inter'),
                    ),
                    leading: Icon(Icons.eco, size: 30),
                  ),
                  ListTile(
                    title: Text(
                      '4. Soil Moisture',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    subtitle: Text(
                      '- Well-maintained soil moisture is required, especially during critical growth stages.',
                      style: TextStyle(fontFamily: 'Inter'),
                    ),
                    leading: Icon(Icons.opacity, size: 30),
                  ),
                  ListTile(
                    title: Text(
                      '5. Soil Drainage',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    subtitle: Text(
                      '- Well-drained soils prevent waterlogging, which can impact wheat production.',
                      style: TextStyle(fontFamily: 'Inter'),
                    ),
                    leading: Icon(Icons.water_damage, size: 30),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
