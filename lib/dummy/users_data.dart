import 'package:twitter/models/profile_data.dart';

class UsersData {
  static final ProfileData _myData = ProfileData(
      name: 'abdallah ahmed',
      title: '@bodzz',
      followersNumber: 1000,
      followingNumber: 500);
  List<ProfileData> usersData = [
    ProfileData(
        name: 'mahmoud',
        title: '@hoda',
        followersNumber: 200,
        followingNumber: 100),
    ProfileData(
        name: 'ahmed',
        title: '@abohmed',
        followersNumber: 400,
        followingNumber: 200),
    ProfileData(
        name: 'waseem',
        title: '@abdallahwael',
        followersNumber: 500,
        followingNumber: 200),
    ProfileData(
        name: 'ziad',
        title: '@ziko',
        followersNumber: 1000,
        followingNumber: 100),
  ];
  void addUser(ProfileData user) {
    usersData.add(user);
  }

  static ProfileData getMyData() {
    return _myData;
  }
}
