// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:irrigalink/generated/l10n.dart';
import 'package:image_picker/image_picker.dart';
import 'package:irrigalink/models/farmer_model.dart';
import 'package:irrigalink/services/farmer_service.dart';

class FarmerSignupScreen extends StatefulWidget {
  const FarmerSignupScreen({Key? key}) : super(key: key);

  @override
  _FarmerSignupScreenState createState() => _FarmerSignupScreenState();
}

class _FarmerSignupScreenState extends State<FarmerSignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _profilePictureURLController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _landSizeController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _farmLandPictureURLController =
      TextEditingController();
  bool loading = false;

  final _formKey = GlobalKey<FormState>();
  File? _farmLandPicture;
  File? _profilePicture;
  List<String> selectedCrops = [];
  int _selectedAddressIdx = 0;

  List<String> ethiopianCities = [];

  List<String> initCities() {
    List<String> cites = [];
    cites.add(S.of(context).addis_ababa);
    cites.add(S.of(context).afar);
    cites.add(S.of(context).amhara);
    cites.add(S.of(context).benishangul_gumuz);
    cites.add(S.of(context).dire_dawa);
    cites.add(S.of(context).gambela);
    cites.add(S.of(context).harari);
    cites.add(S.of(context).oromia);
    cites.add(S.of(context).sidama);
    cites.add(S.of(context).somali);
    cites.add(S.of(context).tigray);
    return cites;
  }

  List<String> initCrops() {
    List<String> crops = [];
    crops.add(S.of(context).onion);
    crops.add(S.of(context).tomato);
    crops.add(S.of(context).wheat);
    crops.add(S.of(context).corn);
    crops.add(S.of(context).rice);
    crops.add(S.of(context).barley);
    crops.add(S.of(context).teff);
    crops.add(S.of(context).sorghum);
    crops.add(S.of(context).cofee);
    crops.add(S.of(context).khat);
    crops.add(S.of(context).potato);
    return crops;
  }

  List<String> availableCrops = [];
  int selectedCropIndex = 0;

  Future _pickFarmImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _farmLandPicture = File(pickedFile.path);
      });
    }
  }

  Future _pickProfileImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profilePicture = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ethiopianCities = initCities();
    availableCrops = initCrops();
    return Scaffold(
      appBar: loading == true
          ? null
          : AppBar(
              title: Text(
                S.of(context).farmer_signup,
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
      body: loading == false ? formBody(context) : loadingIndicator(context),
    );
  }

  Padding formBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: S.of(context).full_name,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z ]+$')),
              ],
              validator: (value) {
                if (value!.isEmpty) {
                  return S.of(context).enter_full_name;
                }
                RegExp alphabeticRegex = RegExp(r'^[a-zA-Z ]+$');
                if (!alphabeticRegex.hasMatch(value)) {
                  return S.of(context).name_alphabet_characters;
                }
                return null;
              },
            ),
            const SizedBox(height: 5),
            TextFormField(
              readOnly: true,
              onTap: () {
                _pickProfileImage();
              },
              controller: _profilePictureURLController,
              decoration: InputDecoration(
                labelText: S.of(context).profile_picture,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.image),
                  onPressed: _pickProfileImage,
                ),
              ),
              validator: (value) {
                if (_profilePicture == null) {
                  return S.of(context).select_profile_picture;
                }
                return null;
              },
            ),
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
            const SizedBox(height: 5),
            DropdownButtonFormField<String>(
              value: ethiopianCities[_selectedAddressIdx],
              onChanged: (String? value) {
                setState(() {
                  _selectedAddressIdx = ethiopianCities.indexOf(value!);
                });
              },
              items: ethiopianCities.map((String city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: S.of(context).address,
              ),
              validator: (value) {
                if (_selectedAddressIdx == -1) {
                  return S.of(context).enter_address;
                }
                return null;
              },
            ),
            const SizedBox(height: 5),
            DropdownButtonFormField<String>(
              value: availableCrops.first,
              onChanged: (String? value) {
                setState(() {
                  selectedCropIndex = availableCrops.indexOf(value!);
                  if (selectedCrops.contains(value) == false) {
                    selectedCrops.add(value);
                  }
                });
              },
              items: availableCrops.map((String crop) {
                return DropdownMenuItem<String>(
                  value: crop,
                  child: Text(crop),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: S.of(context).cropsProduced,
              ),
              validator: (value) {
                if (selectedCrops.isEmpty) {
                  return S.of(context).enter_crops_produced;
                }
                return null;
              },
            ),
            Wrap(
              spacing: 8.0,
              children: selectedCrops.map((crop) {
                return Chip(
                  label: Text(crop),
                  onDeleted: () {
                    setState(() {
                      selectedCrops.remove(crop);
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: _landSizeController,
              decoration: InputDecoration(
                labelText: S.of(context).land_size,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return S.of(context).enter_land_size;
                }
                RegExp phoneRegex = RegExp(r'^[0-9]+$');
                if (!phoneRegex.hasMatch(value)) {
                  return S.of(context).land_size_numbers;
                }
                return null;
              },
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: _experienceController,
              decoration: InputDecoration(
                labelText: S.of(context).farming_experience,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return S.of(context).enter_farming_experience;
                }
                RegExp phoneRegex = RegExp(r'^[0-9]+$');
                if (!phoneRegex.hasMatch(value)) {
                  return S.of(context).experience_numbers;
                }
                return null;
              },
            ),
            const SizedBox(height: 5),
            TextFormField(
              readOnly: true,
              onTap: () {
                _pickFarmImage();
              },
              controller: _farmLandPictureURLController,
              decoration: InputDecoration(
                labelText: S.of(context).farm_land_picture,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.image),
                  onPressed: _pickFarmImage,
                ),
              ),
              validator: (value) {
                if (_farmLandPicture == null) {
                  return S.of(context).select_farm_land_picture;
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 251, 240, 240),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(220, 20),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  // Form is valid, proceed with signup logic
                  // You can use the entered values from the controllers
                  // and send them to your signup/authentication service
                  setState(() {
                    loading = true;
                  });
                  bool status = await FarmerService.saveFarmer(
                    Farmer(
                      name: _nameController.text,
                      landSize: int.parse(_landSizeController.text),
                      experience: int.parse(_experienceController.text),
                      phoneNumber: '+251${_phoneController.text}',
                      profilePicture: _profilePicture!,
                      farmImage: _farmLandPicture!,
                      status: 'Online',
                      location: ethiopianCities[_selectedAddressIdx],
                      cropsProduced: selectedCrops,
                      isFarmConfigured: false,
                    ),
                  );
                  if (status) {
                    FarmerService.sendOtp(
                        '+251${_phoneController.text}', context, true);
                  } else {
                    setState(() {
                      loading = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("User exists with this phone number!!!"),
                      ),
                    );
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
    );
  }
}

Widget loadingIndicator(BuildContext context) {
  return const Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CircularProgressIndicator(), // Loading indicator
      SizedBox(height: 16),
      Text("Saving Farmer Data"), // Text message
    ],
  ));
}
