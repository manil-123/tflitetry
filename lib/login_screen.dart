import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.blue,
              child: IconButton(
                onPressed: () async {
                  // User? user = await Authentication.signInWithGoogle(
                  //     context: context);
                  // if (user != null) {
                  //   Navigator.of(context).pushReplacement(
                  //     MaterialPageRoute(
                  //       builder: (context) => HomeScreen(
                  //         user: user,
                  //       ),
                  //     ),
                  //   );
                  // }
                  // );
                },
                icon: Icon(Zocial.google),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.blue,
              child: IconButton(
                onPressed: () async {
                  // final LoginResult result =
                  //     await FacebookAuth.instance.login();
                  // if (result.status == LoginStatus.success) {
                  //   final AccessToken accessToken = result.accessToken!;
                  //   final userData =
                  //       await FacebookAuth.instance.getUserData();
                  //   Navigator.of(context).pushReplacement(
                  //     MaterialPageRoute(
                  //       builder: (context) => HomeScreen(
                  //         facebookUserData: userData,
                  //       ),
                  //     ),
                  //   );
                  // } else {
                  //   print(result.status);
                  //   print(result.message);
                  // }
                },
                icon: Icon(Zocial.facebook),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
