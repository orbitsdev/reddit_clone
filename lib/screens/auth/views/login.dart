


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redit/assistant/assets.dart';
import 'package:redit/screens/auth/controller/authcontroller.dart';
import 'package:redit/theme/pallete.dart';
import 'package:redit/widgets/h_space.dart';
import 'package:redit/widgets/loader.dart';
import 'package:redit/widgets/signin_button.dart';
import 'package:redit/widgets/v_space.dart';

class Login extends ConsumerWidget {
 Login({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref){

    final isLoading = ref.watch(authControllerProvider);
    return  Scaffold(
      appBar: AppBar(
        title: Image.asset(Assets.imagePath('logo.png'), width: 40,  ),
        centerTitle: true,

        actions: [
          TextButton(onPressed: (){}, child: Text('Skip',  style:TextStyle(
            color:  Pallete.blueColor,
          ),))
          // IconButton(onPressed: (){
          // }, icon: Icon(Icons.more_vert)),
        ],
        
      ),
      body: 
        isLoading ? const Loader()
       : SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
        
          mainAxisSize: MainAxisSize.max,
        
          children: [
              VSpace(MediaQuery.of(context).size.height * 0.05),
               const Text('Dive into anything', style: TextStyle(fontSize: 22 , fontWeight: FontWeight.bold),),
              const VSpace(20),
              Image.asset(Assets.imagePath('loginEmote.png'), height: 300, ),
              VSpace(MediaQuery.of(context).size.height * 0.08),

             SigninButton(),
            
          ],
        ),
      ),
    );
  }
}