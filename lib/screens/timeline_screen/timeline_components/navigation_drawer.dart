import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/screens/others_profile_screen/others_profile_screen.dart';
import 'custom_page_route.dart';
import 'navigation_drawer_button.dart';
import 'navigation_drawer_labels.dart';
import 'profile_picture.dart';
import 'package:twitter/constants.dart';
import 'package:twitter/dummy/users_data.dart';
import 'package:provider/provider.dart';
import 'opacity_data.dart';
import 'package:twitter/screens/profile_screen/profile_screen.dart';
import 'package:twitter/screens/settings_screen/settings_screen.dart';

//this navigation drawer is made for whenever the user press on his profile picture in the time line drawer is popped up
class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 15, bottom: 10, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //this row contains the profile picture in the navigation drawer sheet and the users accounts
                  //both of them have actions whenever you press on them
                  Row(
                    //this row contains the profile picture in the navigation drawer sheet and the users accounts
                    //both of them have actions whenever you press on them
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //profile picture of navigation drawer
                      ProfilePicture(
                        profilePictureFunctionality: () {
                          //go to profile screen upon pressing it
                          Navigator.of(context).push(
                            CustomPageRoute(
                                child: (OthersProfileScreen(userId: Auth.userId,)), beginX: 1, beginY: 0),
                          );
                        },
                        profilePictureImage:
                            Auth.profilePicUrl,
                        profilePictureSize: navigationDrawerProfilePicSize,
                      ),

                      // user accounts icon of navigation drawer
                      GestureDetector(
                        onTap: () {
                          print('hi');
                        },
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            Container(
                              child: const Icon(
                                FontAwesomeIcons.square,
                                size: 25,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 12, top: 15),
                              child: Image.asset(
                                squareLogoPath,
                                width: 20,
                                height: 20,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 12, top: 17),
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
                  //-------------------------------------------------------------------------------------------------------
                  const SizedBox(
                    height: 13,
                  ),
                  //-------------------------------------------------------------------------------------------------------
                  //my profile name button
                  ChangeNotifierProvider(
                    create: (context) => OpacityValue(),
                    child: NavigationDrawerLabels(
                      jumpToProfile: true,
                      widget: Text(
                        Auth.name,
                        style: boldName,
                      ),
                    ),
                  ),

                  //my profile title name button
                  ChangeNotifierProvider(
                    create: (context) => OpacityValue(),
                    child: NavigationDrawerLabels(
                      jumpToProfile: true,
                      widget: Text(
                        Auth.username,
                        style: titleName,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 13,
                  ),

                  //my number of followers and following
                  Row(
                    children: [
                      //number of following button
                      ChangeNotifierProvider(
                        create: (context) => OpacityValue(),
                        child: NavigationDrawerLabels(
                          widget: Row(
                            children: [
                              Text(
                                UsersData.getMyData()
                                    .followingNumber
                                    .toString(),
                                style: boldName,
                              ),
                              followingString,
                            ],
                          ),
                        ),
                      ),

                      //number of followers button
                      ChangeNotifierProvider(
                        create: (context) => OpacityValue(),
                        child: NavigationDrawerLabels(
                          widget: Row(
                            children: [
                              Text(
                                UsersData.getMyData()
                                    .followersNumber
                                    .toString(),
                                style: boldName,
                              ),
                              followersString,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            //----------------------------------------------------------------------------------------------------
            //the upper code was like simulation of the drawer appbar with profile info
            //now the lower code is the buttons and its functionality
            //-------------------------------------------------------------------------------------------------------
            Expanded(
              child: Scrollbar(
                thumbVisibility: true,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    //------------------------------------------------------------
                    //profile button
                    NavigationDrawerButton(
                      icon: const Icon(
                        FontAwesomeIcons.user,
                        size: 20,
                        color: Colors.black,
                      ),
                      text: const Text(
                        'Profile',
                        style: titleName,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ProfileScreen(userId: Auth.userId);
                            },
                          ),
                        );
                      },
                    ),
                    //------------------------------------------------------------
                    //lists button
                    NavigationDrawerButton(
                      icon: const Icon(
                        FontAwesomeIcons.rectangleList,
                        size: 20,
                        color: Colors.black,
                      ),
                      text: const Text(
                        'Lists',
                        style: titleName,
                      ),
                      onPressed: () {},
                    ),
                    //------------------------------------------------------------
                    //topics button
                    NavigationDrawerButton(
                      icon: const Icon(
                        FontAwesomeIcons.rocketchat,
                        size: 20,
                        color: Colors.black,
                      ),
                      text: const Text(
                        'Topics',
                        style: titleName,
                      ),
                      onPressed: () {},
                    ),
                    //------------------------------------------------------------
                    //bookmarks button
                    NavigationDrawerButton(
                      icon: const Icon(
                        FontAwesomeIcons.bookmark,
                        size: 20,
                        color: Colors.black,
                      ),
                      text: const Text(
                        'Bookmarks',
                        style: titleName,
                      ),
                      onPressed: () {},
                    ),
                    //------------------------------------------------------------
                    //Moments button
                    NavigationDrawerButton(
                      icon: const Icon(
                        FontAwesomeIcons.boltLightning,
                        size: 20,
                        color: Colors.black,
                      ),
                      text: const Text(
                        'Moments',
                        style: titleName,
                      ),
                      onPressed: () {},
                    ),
                    //------------------------------------------------------------
                    //purchases button
                    NavigationDrawerButton(
                      icon: const Icon(
                        Icons.shopping_cart_outlined,
                        size: 20,
                        color: Colors.black,
                      ),
                      text: const Text(
                        'Purchases',
                        style: titleName,
                      ),
                      onPressed: () {},
                    ),
                    //------------------------------------------------------------
                    //monetization button
                    NavigationDrawerButton(
                      icon: const Icon(
                        FontAwesomeIcons.moneyBills,
                        size: 20,
                        color: Colors.black,
                      ),
                      text: const Text(
                        'Monetization',
                        style: titleName,
                      ),
                      onPressed: () {},
                    ),
                    //------------------------------------------------------------
                    //twitter for professional button
                    const Divider(
                      color: Color(0xffcfd8dc),
                      thickness: 0.5,
                    ),
                    NavigationDrawerButton(
                      icon: const Icon(
                        FontAwesomeIcons.rocket,
                        size: 20,
                        color: Colors.black,
                      ),
                      text: const Text(
                        'Twitter for Professionals',
                        style: titleName,
                      ),
                      onPressed: () {},
                    ),
                    const Divider(
                      color: Color(0xffcfd8dc),
                      thickness: 0.5,
                    ),
                    //------------------------------------------------------------
                    //settings and privacy button
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(SettingsScreen.routeName);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 4, left: 13, right: 20),
                        child: Row(
                          children: const [
                            Text(
                              'Settings and Privacy',
                              style: titleName,
                            ),
                          ],
                        ),
                      ),
                      style: ButtonStyle(
                        overlayColor: MaterialStateColor.resolveWith(
                            (states) => Colors.blueGrey.shade100),
                      ),
                    ),
                    //------------------------------------------------------------
                    //help center button
                    TextButton(
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 4, left: 13, right: 20),
                        child: Row(
                          children: const [
                            Text(
                              'Help Center',
                              style: titleName,
                            ),
                          ],
                        ),
                      ),
                      style: ButtonStyle(
                        overlayColor: MaterialStateColor.resolveWith(
                            (states) => Colors.blueGrey.shade100),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //-------------------------------------------------------------------------------
            //light bulb and qr code in the bottom bar of the navigator
            BottomAppBar(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 15, bottom: 10, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ChangeNotifierProvider(
                      create: (context) => OpacityValue(),
                      child: NavigationDrawerLabels(
                        widget: const Icon(
                          FontAwesomeIcons.lightbulb,
                        ),
                      ),
                    ),
                    ChangeNotifierProvider(
                      create: (context) => OpacityValue(),
                      child: NavigationDrawerLabels(
                        widget: const Icon(
                          FontAwesomeIcons.qrcode,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
