class Farmer {
  final String? id;
  final String name;
  final int experience;
  final int landSize;
  final String status;
  final String location;
  final String phoneNumber;
  final List<dynamic> cropsProduced;
  bool? isFarmConfigured;
  final dynamic profilePicture;
  final dynamic farmImage;

  Farmer({
    this.id,
    required this.landSize,
    required this.name,
    required this.experience,
    required this.status,
    required this.location,
    required this.phoneNumber,
    required this.cropsProduced,
    this.isFarmConfigured,
    required this.profilePicture,
    required this.farmImage,
  });
  factory Farmer.fromMap(Map<String, dynamic> data) {
    return Farmer(
      landSize: data['land_size'] ?? 0,
      name: data['full_name'] ?? '',
      experience: data['experience'] ?? 0,
      status: data['status'] ?? '',
      location: data['address'] ?? '',
      phoneNumber: data['phone_number'] ?? '',
      cropsProduced: List<dynamic>.from(data['crops_produced'] ?? []),
      isFarmConfigured: data['isFarmConfigured'] ?? false,
      profilePicture: data['profile_pic'] ?? '',
      farmImage: data['farm_pic'] ?? '',
    );
  }
}
