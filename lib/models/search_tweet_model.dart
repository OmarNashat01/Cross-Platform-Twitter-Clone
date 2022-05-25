class SearchTweet {
  String? bio;
  int commentCount;
  List<dynamic> comments;
  String createdAt;
  int followersCount;
  int followingCount;
  List<dynamic>? images;
  int likeCount;
  List<dynamic> likedByIds;
  String name;
  String profilePicUrl;
  int retweetCount;
  String text;
  String tweetId;
  String type;
  String userId;
  String? userName;
  List<dynamic>? videos;

  SearchTweet({
    required this.bio,
    required this.commentCount,
    required this.comments,
    required this.createdAt,
    required this.followersCount,
    required this.followingCount,
    required this.images,
    required this.likeCount,
    required this.likedByIds,
    required this.name,
    required this.profilePicUrl,
    required this.retweetCount,
    required this.text,
    required this.tweetId,
    required this.type,
    required this.userId,
    required this.userName,
    required this.videos,
  });

  factory SearchTweet.fromJson(Map<String, dynamic> jsonData) {
    return SearchTweet(
      bio: jsonData['bio'],
      commentCount: jsonData['comment_count'],
      comments: jsonData['comments'],
      createdAt: jsonData['created_at'],
      followersCount: jsonData['followers_count'],
      followingCount: jsonData['following_count'],
      images: jsonData['images'],
      likeCount: jsonData['like_count'],
      likedByIds: jsonData['liked_by_ids'],
      name: jsonData['name'],
      profilePicUrl: jsonData['prof_pic_url'],
      retweetCount: jsonData['retweet_count'],
      text: jsonData['text'],
      tweetId: jsonData['tweet_id'],
      type: jsonData['type'],
      userId: jsonData['user_id'],
      userName: jsonData['username'],
      videos: jsonData['videos'],
    );
  }
}
