
class ProfileData {
  ProfileData({
    required this.profilePicture,
    required this.name,
    required this.title,
    this.followersNumber,
    this.followingNumber,
  });
  String profilePicture;
  String name;
  String title;
  int? followingNumber;
  int? followersNumber;
}
