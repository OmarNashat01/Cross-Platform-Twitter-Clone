import 'package:twitter/models/profile_data.dart';
import '';
class UsersData {
  static final ProfileData _myData = ProfileData(
      name: 'abdallah ahmed',
      title: '@bodzz',
      profilePicture: 'assets/images/myProfilepic.jpeg',
      followersNumber: 1000,
      followingNumber: 500);
  static final List<ProfileData> _usersData = [
    ProfileData(
        name: 'Mahmoud',
        title: '@Hoda',
        profilePicture: 'assets/images/mahmoud.jpg',
        followersNumber: 200,
        followingNumber: 100),
    ProfileData(
        name: 'Zendaya',
        title: '@Zend',
        profilePicture: 'assets/images/zendaya.jpg',
        followersNumber: 100000,
        followingNumber: 200),
    ProfileData(
        name: 'Waseem',
        title: '@Abdallahwael',
        profilePicture: 'assets/images/waseem.jpg',
        followersNumber: 500,
        followingNumber: 200),
    ProfileData(
        name: 'Ziad',
        title: '@Ziko',
        profilePicture: 'assets/images/ziad.jpg',
        followersNumber: 1000,
        followingNumber: 100),
  ];
  void addUser(ProfileData user) {
    _usersData.add(user);
  }

  static ProfileData getMyData() {
    return _myData;
  }
  static List<ProfileData> getOtherUsersData() {
    return _usersData;
    }
}
