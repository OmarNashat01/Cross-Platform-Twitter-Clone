class User {
  User(
      {required this.username,
      required this.name,
      this.website,
      required this.followingCount,
      required this.followersCount,
      required this.followers,
      required this.following,
      required this.tweetCount,
      required this.admin,
      required this.email,
      required this.dateOfBirth,
      required this.creationDate,
      required this.id,
      required this.location,
      this.bio,
      required this.profilePicUrl,
      required this.coverPicUrl,
      required this.gender});
  String id;
  String email;
  String name;
  String? username;
  String dateOfBirth;
  String gender;
  String creationDate;
  String? bio;
  String location;
  String? website;
  bool admin;
  List<dynamic> followers;
  List<dynamic> following;
  int followersCount;
  int followingCount;
  int tweetCount;
  String? profilePicUrl;
  String? coverPicUrl;

  factory User.fromJson(Map<String, dynamic> jsonData) {
    return User(
        id: jsonData["_id"],
        email: jsonData["email"],
        profilePicUrl: jsonData["prof_pic_url"],
        name: jsonData["name"],
        username: jsonData["username"],
        bio: jsonData["bio"],
        followersCount: jsonData["followers_count"],
        followingCount: jsonData["following_count"],
        creationDate: jsonData["creation_date"],
        website: jsonData['website'],
        following: jsonData['following'],
        tweetCount: jsonData['tweet_count'],
        admin: jsonData['admin'],
        followers: jsonData['followers'],
        coverPicUrl: jsonData['cover_pic_url'],
        location: jsonData['location'],
        dateOfBirth: jsonData['date_of_birth'],
        gender: jsonData['gender']);
  }
}
