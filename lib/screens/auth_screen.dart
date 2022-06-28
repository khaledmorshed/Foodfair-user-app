import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../widgets/error_dialog.dart';
import '../../widgets/loading_dialog.dart';
import '../../global/global_instance_or_variable.dart';
import '../../widgets/container_decoration.dart';
import '../global/color_manager.dart';
import 'registration_screen.dart';
import 'user_home_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();

  _formValidation() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    login();
  }

  Future login() async {
    showDialog(
      context: context,
      builder: (context) {
        return LoadingDailog(
          message: "Authentication Checking.",
        );
      },
    );

    User? currentUser;
    await firebaseAuth
        .signInWithEmailAndPassword(
      email: emailController!.text.trim(),
      password: passwordController!.text.trim(),
    )
        .then((auth) {
      currentUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) {
            return ErrorDialog(
              message: error.message.toString(),
            );
          });
    });

    if (currentUser != null) {
      readDataAndSaveDataLocally(currentUser!);
    }
  }

//by this function user id is going to store on the using device
  Future readDataAndSaveDataLocally(User currentUser) async {
    //FirebaseFirestore.instance.collection('riders').doc(currentUser.uid).get() = we are retreiving
    //the current user data from Firebase Database uder users collection and store data into
    //snapShot
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get()
        .then((snapShot) async {
      //if users data has come and not is equal to null or is exist.
      if (snapShot.data() != null) {
        //currentUser.uid = this come from Authentication
        await sPref!.setString("uid", currentUser.uid);
        //snapshot.data()![""] = all comes from FireStore Database
        await sPref!.setString("email", snapShot.data()!["userEmail"]);
        await sPref!.setString("name", snapShot.data()!["userName"]);
        await sPref!.setString("photoUrl", snapShot.data()!["userPhotoUrl"]);

        //from firestore the data come as dynamic so here need to be casted 
        List<String> userCartList = snapShot.data()!["userCart"].cast<String>();
        await sPref!.setStringList("userCart", userCartList);

        Navigator.pop(context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const UserHomeScreen()));
      } else {
        firebaseAuth.signOut();
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return ErrorDialog(
                message:
                    "There is no user record corresponding to this identifier. The user may have been deleted.",
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // padding: EdgeInsets.only(top: 200),
        //height: MediaQuery.of(context).size.height,
        decoration: const ContainerDecoration().decoaration(),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, right: 20, left: 20),
                  child: Image.asset(
                    "assets/images/welcome.png",
                    //scale: 2,
                    //height: MediaQuery.of(context).size.height * 0.30,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              //isCollapsed: true,
                              // isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 2),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  borderSide: BorderSide.none),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.cyan,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "email",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter an email";
                              } else if (!value.contains('@')) {
                                return "Invalid email";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 2),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  borderSide: BorderSide.none),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.cyan,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "password",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter password";
                              } else if (value.length < 6) {
                                return "password must be at least 6 characters";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    // CustomButton(
                    //   onTap: () {
                    //     _formValidation();
                    //   },
                    //   //icon: Icons.check_outlined,
                    //   text: "sign in",
                    //   buttonColor: ColorManager.orange4,
                    //   boxShadowColorTop: ColorManager.amber2,
                    //   boxShadowColorDown: ColorManager.blue3,
                    // ),
                    ElevatedButton(
                      child: const Text(
                        "Sing In",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.purple[300],
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: ColorManager.depOrange1),
                        ),
                      ),
                      onPressed: () {
                        _formValidation();
                      },
                    ),
                    ElevatedButton(
                      child: const Text(
                        "Sing Up",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.purple[300],
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: ColorManager.depOrange1),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegistrationScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
