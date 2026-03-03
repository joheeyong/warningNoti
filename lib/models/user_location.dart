class UserLocation {
  final double latitude;
  final double longitude;
  final String? address;
  final String? region;

  const UserLocation({
    required this.latitude,
    required this.longitude,
    this.address,
    this.region,
  });

  static UserLocation defaultLocation() {
    return const UserLocation(
      latitude: 37.5665,
      longitude: 126.9780,
      address: '서울특별시 중구',
      region: '서울특별시',
    );
  }
}
