import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:stack/controller/auth/authController.dart';
import 'package:stack/screens/auth/Login.dart';
import 'package:stack/widgets/alerts/global_Dialog.dart';
import 'package:stack/widgets/wave/customWave.dart';
import 'package:permission_handler/permission_handler.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/Signup-screen';

  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
// request a user for permission first

// variable
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _fullName = '';
  late int _phoneNumber;
  File? _image;
  bool _isVisible = false;
  bool _isLoading = false;
  GlobalMethods globalMethods = GlobalMethods();
  FirebaseAuth _auth = FirebaseAuth.instance;
// functions
  Future _getImage() async {
    if (await Permission.contacts.request().isGranted) {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      // Either the permission was already granted before or the user just granted it.
    }

// You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
    ].request();
    print(statuses[Permission.location]);
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
    });
  }

  void _submitData() async {
    final _isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
//
    final date = DateTime.now().toString();
    final parseDate = DateTime.parse(date);
    final formatedDate =
        '${parseDate.day}/${parseDate.month}/${parseDate.year}';
    //
    if (_isValid) {
      _formKey.currentState!.save();
    }
    try {
      if (_image == null) {
        return globalMethods.showSnackBar(context,
            "Please Provide Image Then contineo", "Image can't be null", () {});
      } else {
        setState(() {
          _isLoading = true;
        });
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child(_fullName + '.jpg');
        await ref.putFile(_image!);
        final _url = await ref.getDownloadURL();
        await _auth.createUserWithEmailAndPassword(
          email: _email.toLowerCase().trim(),
          password: _password.trim(),
        );
        final User? user = _auth.currentUser;
        final _uid = user!.uid;
        FirebaseFirestore.instance.collection('users').doc(_uid).set({
          'uid': _uid,
          'email': _email.toLowerCase(),
          'fullName': _fullName.trim(),
          'phoneNumber': _phoneNumber,
          'image': _url,
          'joinedDate': formatedDate,
          'created': Timestamp.now(),
        });
        //

        Navigator.canPop(context) ? Navigator.pop(context) : null;
      }
    } on FirebaseAuthException catch (e) {
      globalMethods.authDialoge(context, e.code, e.message.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _numberFocusNode = FocusNode();

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    _numberFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    //

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          RotatedBox(
            quarterTurns: 2,
            child: Customwave(),
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 80),
                    Row(
                      children: [
                        InkWell(
                          onTap: _getImage,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                _image == null ? null : FileImage(_image!),
                            backgroundColor: Colors.teal.withOpacity(0.6),
                            child: Icon(
                              _image == null ? Icons.camera : null,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Text(
                          'Signup',
                          style: TextStyle(fontSize: 65),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      onSaved: (value) {
                        _fullName = value!;
                      },
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(_numberFocusNode),
                      key: ValueKey('name'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      onSaved: (value) {
                        _phoneNumber = int.parse(value!);
                      },
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(_emailFocusNode),
                      // keyboardType: TextInputType.emailAddress,
                      key: ValueKey('number'),
                      validator: (value) {
                        if (value!.length < 11) {
                          return 'Phone number must be 11 units';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: Icon(Icons.phone),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      onSaved: (value) {
                        _email = value!;
                      },
                      onEditingComplete: () => FocusScope.of(context)
                          .requestFocus(_passwordFocusNode),
                      keyboardType: TextInputType.emailAddress,
                      key: ValueKey('email'),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      focusNode: _passwordFocusNode,
                      onSaved: (value) {
                        _password = value!;
                      },
                      onEditingComplete: _submitData,
                      obscureText: _isVisible,
                      key: const ValueKey('password'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 8) {
                          return 'Password must be atleast 8 units';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isVisible = !_isVisible;
                            });
                          },
                          icon: Icon(_isVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: _submitData,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        width: MediaQuery.of(context).size.width - 60,
                        height: 55,
                        child: _isLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Center(
                                child: Text(
                                  'Sign up',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(LogInScreen.routeName);
                  },
                  child: const Text(
                    'Login to Your Account',
                    style: TextStyle(color: Colors.deepPurpleAccent),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ],
      ),
    );
  }
}
