import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:irrigalink/generated/l10n.dart';
import 'package:irrigalink/models/distributor_model.dart';
import 'package:irrigalink/services/distributorService.dart';

class ManageProfileDistributor extends StatefulWidget {
  final Distributor distributor;

  const ManageProfileDistributor({Key? key, required this.distributor})
      : super(key: key);

  @override
  _ManageProfileDistributorState createState() =>
      _ManageProfileDistributorState();
}

class _ManageProfileDistributorState extends State<ManageProfileDistributor> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _profilePictureURLController =
      TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _storePictureURLController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  File? _storePicture;
  File? _profilePicture;
  List<String> selectedCrops = [];
  int _selectedAddressIdx = 0;
  bool loading = false;
  List<String> ethiopianCities = [];
  List<String> availableCrops = [];
  int selectedCropIndex = 0;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.distributor.name;
    _profilePictureURLController.text = widget.distributor.profilePicture;
    selectedCrops = List.from(widget.distributor.cropsSelled);
    _experienceController.text = widget.distributor.experience.toString();
    _storePictureURLController.text = widget.distributor.storeImage;
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

  Future _pickStoreImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _storePicture = File(pickedFile.path);
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
            ),
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
                        labelText: S.of(context).crops_selled,
                      ),
                      validator: (value) {
                        if (selectedCropIndex == -1) {
                          return S.of(context).enter_crops_selled;
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
                      controller: _experienceController,
                      decoration: InputDecoration(
                        labelText: S.of(context).distributing_experience,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return S.of(context).enter_distributing_experience;
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
                        _pickStoreImage();
                      },
                      controller: _storePictureURLController,
                      decoration: InputDecoration(
                        labelText: S.of(context).store_picture,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.image),
                          onPressed: _pickStoreImage,
                        ),
                      ),
                      validator: (value) {
                        if (_storePicture == null) {
                          return S.of(context).select_store_picture;
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
                          bool status =
                              await DistributorService.updateDistributor(
                            Distributor(
                              name: _nameController.text,
                              experience: int.parse(_experienceController.text),
                              profilePicture: _profilePicture!,
                              storeImage: _storePicture!,
                              status: 'Online',
                              location: ethiopianCities[_selectedAddressIdx],
                              cropsSelled: selectedCrops,
                              phoneNumber: '',
                              id: '',
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
            ),
    );
  }
}
