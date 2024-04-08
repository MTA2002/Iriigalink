// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:irrigalink/generated/l10n.dart';
import 'package:irrigalink/services/distributorService.dart';
import 'package:irrigalink/services/farmer_service.dart';

class FarmerLoginScreen extends StatefulWidget {
  const FarmerLoginScreen({Key? key, required this.isFarmer}) : super(key: key);
  final bool isFarmer;
  @override
  _FarmerSignupScreenState createState() => _FarmerSignupScreenState();
}

class _FarmerSignupScreenState extends State<FarmerLoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: loading == true
          ? null
          : AppBar(
              title: Text(
                S.of(context).login,
                style:
                    const TextStyle(color: Colors.black87, fontFamily: 'Inter'),
              ),
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
      body: loading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: _phoneController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        LengthLimitingTextInputFormatter(9),
                      ],
                      decoration: InputDecoration(
                        prefixText: '+251 ',
                        labelText: S.of(context).phone_number,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return S.of(context).enter_phone_number;
                        }
                        RegExp phoneRegex = RegExp(r'^[0-9]+$');
                        if (!phoneRegex.hasMatch(value)) {
                          return S.of(context).phone_number_numbers;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 251, 240, 240),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size(220, 20),
                      ),
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        if (_formKey.currentState!.validate()) {
                          if (widget.isFarmer) {
                            bool status =
                                await FarmerService.checkIfFarmerExists(
                                    '+251${_phoneController.text}');
                            if (status) {
                              FarmerService.sendOtp(
                                  '+251${_phoneController.text}',
                                  context,
                                  widget.isFarmer);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "User doesn't exist with this phone number!!!"),
                                ),
                              );
                              Navigator.of(context).pop();
                            }
                          } else {
                            bool status =
                                await DistributorService.checkIfDistExists(
                                    '+251${_phoneController.text}');
                            if (status) {
                              DistributorService.sendOtp(
                                  '+251${_phoneController.text}',
                                  context,
                                  widget.isFarmer);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "User doesn't exist with this phone number!!!"),
                                ),
                              );
                            }
                          }
                        }
                      },
                      child: Text(
                        S.of(context).next_step,
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
            ),
    );
  }
}
