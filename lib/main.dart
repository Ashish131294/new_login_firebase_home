import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:new_login_firebase/secondpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      //options: DefaultFirebaseOptions.currentPlatform,
      );
  runApp(MaterialApp(
    home: demo(),
  ));
}

class demo extends StatefulWidget {
  const demo({Key? key}) : super(key: key);

  @override
  State<demo> createState() => _demoState();
}

class _demoState extends State<demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Login Firebase"),
      ),
      body: Center(
        child: Column(
          children: [
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    signInWithGoogle().then((value) {
                      //print(value);
                      if(value!=null)
                        {
                          Navigator.push(context, MaterialPageRoute(builder:  (context) {
                            return secondpage();
                          },));
                        }
                      else{
                        
                      }
                    });
                  },
                  child: Text("Google Login")),
            ),
            ElevatedButton(onPressed: () {
              GoogleSignIn().signOut().then((value) {
                print(value);
              });
            }, child: Text("Logout"))
          ],
        ),
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
