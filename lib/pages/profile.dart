import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  final bool showBackButton;

  const Profile({super.key, required this.showBackButton});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _removeImage() {
    setState(() {
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white10,
            child: Column(
              children: [
                Stack(
                  children: [
                    if (widget.showBackButton)
                      Padding(
                        padding: const EdgeInsets.only(top: 45, left: 18),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back),
                          iconSize: 34,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    Container(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      height: MediaQuery.of(context).size.height / 4.3,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 15),
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: Material(
                            borderRadius: BorderRadius.circular(100),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: _image == null
                                  ? Icon(
                                      Icons.person,
                                      size: 180,
                                      color: Color(0Xff0c9cc8),
                                    )
                                  : Image.file(
                                      _image!,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              4,
                                      width:
                                          MediaQuery.of(context).size.height /
                                              4,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (_image != null)
                      Positioned(
                        top: MediaQuery.of(context).size.height / 3.5,
                        right: MediaQuery.of(context).size.width / 3.2,
                        child: IconButton(
                          icon: Icon(Icons.delete,
                              color: Colors.grey[400], size: 30),
                          onPressed: _removeImage,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 15.0),
                _buildInfoCard(icon: Icons.person, label: "Name"),
                SizedBox(height: 22.0),
                _buildInfoCard(icon: Icons.email, label: "Email"),
                SizedBox(height: 22.0),
                _buildInfoCard(icon: Icons.settings, label: "Settings"),
                SizedBox(height: 22.0),
                _buildInfoCard(icon: Icons.delete, label: "Delete Account"),
                SizedBox(height: 22.0),
                _buildInfoCard(icon: Icons.logout, label: "Log Out"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({required IconData icon, required String label}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Material(
        borderRadius: BorderRadius.circular(15),
        elevation: 2.0,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 15.0),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              Icon(icon, color: Color(0Xff0c9cc8)),
              SizedBox(width: 20.0),
              Text(
                label,
                style: TextStyle(
                    color: Color(0Xff3f3d3d),
                    fontSize: 19.5,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
