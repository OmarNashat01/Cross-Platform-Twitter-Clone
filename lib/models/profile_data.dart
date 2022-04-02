
class ProfileData {
  ProfileData({
    required this.name,
    required this.title,
    this.followersNumber,
    this.followingNumber,
  });
  String name;
  String title;
  int? followingNumber;
  int? followersNumber;
}
