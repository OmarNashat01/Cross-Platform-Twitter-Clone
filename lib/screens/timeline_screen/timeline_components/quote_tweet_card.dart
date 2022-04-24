// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:like_button/like_button.dart';
// import 'package:palette_generator/palette_generator.dart';
// import 'package:provider/provider.dart';
// import 'package:twitter/dummy/timeline_list.dart';
// import 'package:twitter/dummy/users_data.dart';
// import 'package:twitter/constants.dart';
// import 'package:twitter/models/tweet_model.dart';
// import 'package:twitter/screens/timeline_screen/timeline_components/profile_picture.dart';
// import 'package:twitter/screens/timeline_screen/timeline_components/tweet_bottom_bar.dart';
//
// import 'custom_page_route.dart';
// import 'image_detail_screen.dart';
//
// //TweetCard class is the widget responsible for rendering the tweet card at the timeline and any needed place
// //the tweet need information to be rendered
// //this information will come from class which is TweetCardData
// class QuoteTweetCard extends StatelessWidget {
//   QuoteTweetCard({required this.index});
//   final int index;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(left: 26,right: 26),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   //--here is the profile picture of the one who tweeted
//                   ProfilePicture(
//                       profilePictureFunctionality: () {},
//                       profilePictureImage:
//                       Provider.of<TweetsViewModel>(context).getTweetsList()[index].profilePicUrl,
//                       profilePictureSize: navigationDrawerProfilePicSize),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 10),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         //here is the name and title of the one who tweeted
//                         Text( Provider.of<TweetsViewModel>(context).getTweetsList()[index].username,
//                             style: boldName),
//                         // Text(Provider.of<TimelineList>(context).getTweetsList()[index].title,
//                         //     style: titleName),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//
//               //--for decoration sized box
//               SizedBox(height: 5,),
//               //--here is the text of the tweet
//               Provider.of<TweetsViewModel>(context).getTweetsList()[index].textExistence == TextExistence.exist
//                   ? Row(
//                 children: [
//                   Expanded(
//                     child: Text(
//                       Provider.of<TweetsViewModel>(context).getTweetsList()[index].text!,
//                       softWrap: false,
//                       overflow: TextOverflow.ellipsis,
//                       //max lines of writing a tweet is 8 like in the main twitter
//                       maxLines: 8,
//                       style: tweetsTexts,
//                     ),
//                   ),
//                 ],
//               )
//                   : const SizedBox.shrink(),
//             ],
//           ),
//         ),
//         //--for decoration sized box
//         SizedBox(height: 5,),
//
//         //--here is the image of the tweet
//         Provider.of<TweetsViewModel>(context).getTweetsList()[index].imageType == TweetImage.picture
//             ? GestureDetector(
//           onTap: ()
//           {
//             Navigator.of(context).push(
//               CustomPageRoute
//                 (child:ImageDetailScreen(
//                 index: index,
//               ),beginX: 0,beginY: 1),
//             );
//           },
//           // child: Image.asset(
//           //   Provider.of<TimelineList>(context).getTweetsList()[index].imageUrl!,
//           //   fit: BoxFit.cover,
//           //   width: double.infinity,
//           //   alignment: Alignment.center,
//           // ),
//         )
//             : const SizedBox.shrink(),
//
//         //here it will has inner tweet card to be drawn
//         Container(
//           color: Colors.black,
//             child: Provider.of<TweetsViewModel>(context).getTweetsList()[index].innerTweet),
//         //the row of icons for your reactions on the tweet
//         TweetBottomBar(index: index,iconsBoundry: Colors.grey.shade600,),
//
//
//         //decoration of tweet at the bottom (divider)
//         const SizedBox(
//           height: 5,
//         ),
//         //decoration of tweet at the bottom (divider)
//         const Divider(
//           thickness: 1.5,
//         ),
//         const SizedBox(
//           height: 8,
//         ),
//       ],
//     );
//   }
// }
//
//
