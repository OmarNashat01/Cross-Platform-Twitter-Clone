import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/screens/profile_screen/profile_screen.dart';
import '../timeline_screen/timeline_components/profile_picture.dart';
import 'package:twitter/dummy/users_data.dart';


class EditProfileScreen extends StatelessWidget {
  static const routeName = '/edit-profile-screen';

  final controller = ScrollController();

  TextEditingController _nameTEC = TextEditingController();
  TextEditingController _bioTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(

          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.blue,
            child: Icon(
              FontAwesomeIcons.plus,
              size: 20,
            ),
          ),

          body: SafeArea(
            child: NestedScrollView(
              controller: controller,
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  floating: true,
                  pinned: false,
                  centerTitle: true,
                  backgroundColor: Colors.white,
                  forceElevated: innerBoxIsScrolled,
                  shadowColor: Colors.white,
                  automaticallyImplyLeading: false,
                  title: TextButton(
                    onPressed: () {
                      controller.animateTo(0.0, curve: Curves.easeIn, duration: Duration(seconds: 1));
                    },
                    style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return ProfileScreen();
                              }),
                            );
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return ProfileScreen();
                              }),
                            );
                          },
                          child: Text('Save'),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ProfilePicture(
                              profilePictureFunctionality: () {
                                Scaffold.of(context).openDrawer();
                              },
                              profilePictureImage: UsersData
                                  .getMyData()
                                  .profilePicture,
                              profilePictureSize: 40,
                            ),

                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              body: Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Name', style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: TextFormField(
                        controller: _nameTEC,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Add your name',


                        ),
                      ),
                    ),
                    Text('Bio', style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: TextFormField(
                        controller: _bioTEC,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Add a bio to your profile',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
