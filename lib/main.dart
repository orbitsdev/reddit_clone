import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redit/routes.dart';
import 'package:redit/screens/auth/controller/authcontroller.dart';
import 'package:redit/theme/pallete.dart';
import 'package:redit/widgets/error_text.dart';
import 'package:redit/widgets/loader.dart';
import 'package:routemaster/routemaster.dart';

import 'package:redit/models/user.dart' as model;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(ProviderScope(child: RidditClone()));
}

class RidditClone extends ConsumerStatefulWidget {
  const RidditClone({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RidditCloneState();
}

class _RidditCloneState extends ConsumerState<RidditClone> {
  model.User?  user;
  void getData(WidgetRef ref, User data) async {
        user = await ref.watch(authControllerProvider.notifier).getUserData(data.uid).first;
        ref.read(userProvider.notifier).update((state)=> user );
        setState(() {
          
        });
   }
  @override
  Widget build(BuildContext context) {
     return ref.watch(authStateChangeProvider).when(
      data: ((data) =>  MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: Pallete.darkModeAppTheme,
      routerDelegate: RoutemasterDelegate(routesBuilder: (_) {

        print(data);
        if(data != null){
          getData(ref, data);

          if(user != null){
              return authenticatedroutes;

          }
        }
          return unauthenticatedroutes;


      }),
      routeInformationParser: const RoutemasterParser(),
    )),
      error: (error, StackPageState) =>  ErrorText(error: error.toString()) ,
      loading: ()=> const Loader(),
      );
  }
}

