class Distributor {
  final String id;
  final String name;
  final int experience;
  final String status;
  final String location;
  final String phoneNumber;
  final List<dynamic> cropsSelled;
  final dynamic profilePicture;
  final dynamic storeImage;

  Distributor({
    required this.id,
    required this.name,
    required this.experience,
    required this.status,
    required this.location,
    required this.phoneNumber,
    required this.cropsSelled,
    required this.profilePicture,
    required this.storeImage,
  });
  static int count = 0;
  factory Distributor.fromMap(Map<String, dynamic> data) {
    return Distributor(
      id: count.toString(),
      name: data['full_name'] ?? '',
      experience: data['experience'] ?? 0,
      status: data['status'] ?? '',
      location: data['address'] ?? '',
      phoneNumber: data['phone_number'] ?? '',
      cropsSelled: List<dynamic>.from(data['crops_selled'] ?? []),
      profilePicture: data['profile_pic'] ?? '',
      storeImage: data['store_pic'] ?? '',
    );
  }
}
