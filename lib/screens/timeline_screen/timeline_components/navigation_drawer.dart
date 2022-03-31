import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'profile_picture.dart';
import 'package:twitter/constants.dart';
import 'package:twitter/users/users_data.dart';
//this navigation drawer is made for whenever the user press on his profile picture in the time line drawer is popped up
class NavigationDrawer extends StatelessWidget {
  final double top=5;
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 15,bottom:10 ,left:20 ,right:20 ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                //this row contains the profile picture in the navigation drawer sheet and the users accounts
                //both of them have actions whenever you press on them
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //profile picture of navigation drawer
                  ProfilePicture(
                      profilePictureFunctionality: ()
                      {

                      },
                      profilePicturePath: myProfilePicturePath,
                      profilePictureSize: navigationDrawerProfilePicSize,
                  ),

                  // user accounts of navigation drawer
                  GestureDetector(
                    onTap: ()
                    {
                      print('hi');
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Container(

                          child: const Icon(
                            FontAwesomeIcons.square,
                            size:25 ,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 12,top: 15),
                          child: Image.asset(
                            squareLogoPath,
                            width: 20,
                            height: 20,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 12,top: 17),
                          child: const Icon(
                            FontAwesomeIcons.user,
                            size: 15,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 13,
              ),
              //my profile name
              Text(
                UsersData.getMyData().name,
                style: boldName,
              ),

              //my profile title name
              Text(
                UsersData.getMyData().title,
                style:titleName,
              ),

              const SizedBox(
                height: 13,
              ),

              //my number of followers and following
              Row(
                children: [
                  Text(
                    UsersData.getMyData().followingNumber.toString(),
                    style: boldName,
                  ),
                  followingString,
                  Text(
                    UsersData.getMyData().followersNumber.toString(),
                    style: boldName,
                  ),
                  followersString,
                ],
              ),

              const SizedBox(
                height: 16,
              ),


            ],
          ),
        ),
      ),
    );
  }
}
