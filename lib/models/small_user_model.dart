class SmallUser
{
  SmallUser({required this.profilePicUrl,required this.followersCount,required this.followingCount,required this.name,required this.username,required this.userId,this.bio});
  String userId;
  String name	;
  String username;
  String profilePicUrl;
  String? bio	;
  int followersCount;
  int followingCount;
  factory SmallUser.fromJson(Map<String,dynamic> jsonData)
  {
    return SmallUser(userId: jsonData["user_id"], profilePicUrl: jsonData["prof_pic_url"],name:jsonData["name"] , username: jsonData["username"],bio: jsonData["bio"] ,followersCount: jsonData["followers_count"],followingCount: jsonData["following_count"]);
  }
}