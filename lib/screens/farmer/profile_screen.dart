// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:irrigalink/generated/l10n.dart';
import 'package:irrigalink/models/farmer_model.dart';
import 'package:irrigalink/services/farmer_service.dart';

class ManageProfileFarmer extends StatefulWidget {
  final Farmer farmer;

  const ManageProfileFarmer({Key? key, required this.farmer}) : super(key: key);

  @override
  _ManageProfileFarmerState createState() => _ManageProfileFarmerState();
}

class _ManageProfileFarmerState extends State<ManageProfileFarmer> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _profilePictureURLController =
      TextEditingController();
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
  List<String> availableCrops = [];
  int selectedCropIndex = 0;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.farmer.name;
    _profilePictureURLController.text = widget.farmer.profilePicture;
    selectedCrops = List.from(widget.farmer.cropsProduced);
    _landSizeController.text = widget.farmer.landSize.toString();
    _experienceController.text = widget.farmer.experience.toString();
    _farmLandPictureURLController.text = widget.farmer.farmImage;
  }

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
      appBar: loading == false
          ? AppBar(
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
              title: Text(
                S.of(context).manageProfile,
                style: const TextStyle(color: Colors.black),
              ),
              elevation: 0,
              backgroundColor: Color.fromARGB(80, 255, 251, 251),
            )
          : null,
      body: loading == false
          ? Padding(
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
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^[a-zA-Z ]+$')),
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
                        labelText: S.of(context).crops_produced,
                      ),
                      validator: (value) {
                        if (selectedCropIndex == -1) {
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
                        backgroundColor: const Color.fromRGBO(98, 142, 144, 1),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size(220, 20),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          bool status = await FarmerService.updateFarmer(
                            Farmer(
                              name: _nameController.text,
                              landSize: int.parse(_landSizeController.text),
                              experience: int.parse(_experienceController.text),
                              profilePicture: _profilePicture!,
                              farmImage: _farmLandPicture!,
                              status: 'Online',
                              location: ethiopianCities[_selectedAddressIdx],
                              cropsProduced: selectedCrops,
                              phoneNumber: '',
                            ),
                          );
                          if (status) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Profile updated successfully"),
                              ),
                            );
                          }
                        }
                      },
                      child: Text(
                        S.of(context).save_changes,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
