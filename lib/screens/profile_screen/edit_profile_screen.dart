import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:twitter/constants.dart';
import 'package:twitter/screens/profile_screen/profile_screen.dart';
import '../timeline_screen/timeline_components/profile_picture.dart';
import 'package:twitter/dummy/users_data.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = '/edit-profile-screen';
  @override
  State<StatefulWidget> createState() {
    return EditProfileScreen_State();
  }
}

class EditProfileScreen_State extends State<EditProfileScreen> {
  Future getImage() async {
    setState(() {});
  }

  late FocusNode myFocusNode = FocusNode();

  String _selectedDate = '2002/2/222';
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //here a nested scroll view widget needs ti be done
      body: SafeArea(
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) => [
            SliverAppBar(
              forceElevated: innerBoxIsScrolled,
              pinned: true,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
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
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.blue[600],
                      ),
                    ),
                  ),
                  const Text(
                    'Edit Profile',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
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
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.blue[600],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
          physics: const BouncingScrollPhysics(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //cover
              Container(
                height: 120,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://images.pexels.com/photos/2531709/pexels-photo-2531709.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                      fit: BoxFit.cover),
                ),
                width: double.infinity,
              ),
              //profile picture
              Container(
                transform: Matrix4.translationValues(0, -50, 0),
                padding: const EdgeInsets.all(20),
                child: CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.white,
                  child: ProfilePicture(
                    profilePictureFunctionality: () {
                      Scaffold.of(context).openDrawer();
                    },
                    profilePictureImage: Auth.profilePicUrl,
                    profilePictureSize: 40,
                  ),
                ),
              ),
              //form
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 0.3, color: Colors.grey)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: TextField(
                        focusNode: myFocusNode,
                        autocorrect: true,
                        style: const TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 14,
                            color: Colors.blue),
                        decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: UsersData.getMyData().name,
                          hintStyle:
                              const TextStyle(fontSize: 14, color: Colors.blue),
                          border: InputBorder.none,
                          hintMaxLines: 1,
                        ),
                      ),
                      flex: 2,
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 0.3, color: Colors.grey)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: const [
                    Expanded(
                      child: Text(
                        'Bio',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: TextField(
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 14,
                            color: Colors.blue),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'Add a bio to your profile',
                          hintStyle:
                              TextStyle(fontSize: 14, color: Colors.black45),
                          border: InputBorder.none,
                        ),
                      ),
                      flex: 2,
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 0.3, color: Colors.grey)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: const [
                    Expanded(
                      child: Text(
                        'Location',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: TextField(
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 14,
                            color: Colors.blue),
                        decoration: InputDecoration(
                          hintText: 'Add your location',
                          hintStyle:
                              TextStyle(fontSize: 14, color: Colors.black45),
                          border: InputBorder.none,
                          hintMaxLines: 1,
                        ),
                      ),
                      flex: 2,
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 0.3, color: Colors.grey)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: const [
                    Expanded(
                      child: Text(
                        'Website',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: TextField(
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 14,
                            color: Colors.blue),
                        decoration: InputDecoration(
                          hintText: 'Add your website',
                          hintStyle:
                              TextStyle(fontSize: 14, color: Colors.black45),
                          border: InputBorder.none,
                          hintMaxLines: 1,
                        ),
                      ),
                      flex: 2,
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 0.3, color: Colors.grey)),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Birth date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: DateTimePicker(
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.blue,
                        ),
                        initialValue: DateTime.now().toString(),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: _selectedDate,
                        ),
                        type: DateTimePickerType.date,
                        firstDate: DateTime(1995),
                        lastDate: DateTime
                            .now(), // This will add one year from current date
                        validator: (value) {
                          return null;
                        },
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              _selectedDate = value;
                            });
                          }
                        },
                        // We can also use onSaved
                        onSaved: (value) {
                          if (value!.isNotEmpty) {
                            _selectedDate = value;
                          }
                        },
                      ),
                      flex: 2,
                    ),
                  ],
                ),
              ),

              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 0.3, color: Colors.grey)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
