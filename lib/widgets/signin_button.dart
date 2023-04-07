

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redit/assistant/assets.dart';
import 'package:redit/screens/auth/controller/authcontroller.dart';
import 'package:redit/theme/pallete.dart';
import 'package:redit/widgets/h_space.dart';

class SigninButton extends ConsumerWidget {
const SigninButton({ Key? key }) : super(key: key);

void signInWithGoogle(WidgetRef ref, BuildContext context){


  ref.read(authControllerProvider.notifier).signinWithGoogle(context);
}

  @override
  Widget build(BuildContext context, WidgetRef ref){
    return  IconButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Pallete.greyColor,
                ),
                onPressed: ()=> signInWithGoogle(ref,context), icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Image.asset(Assets.imagePath('google.png'), width: 40, ) ,
                  HSpace(14),
                  Text('Continue with Google', style: TextStyle(fontSize: 18 ,fontFamily: 'MyFlutterApp'),)
                ],
              ));
  }
}