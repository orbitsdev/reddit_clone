


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class CommunityDrawer extends ConsumerWidget {

  final BuildContext context;
  CommunityDrawer({
    required this.context,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref){
    return SafeArea(
      child: Drawer(
          child: ListView(
            padding: EdgeInsets.only(top: 40),
            children: [
              ListTile(
                onTap: (){
                    Navigator.pop(context);
                    Routemaster.of(context).push('/create-community');

                },
                leading: Icon(Icons.add ,color: Colors.white,),
                title: Text('Create a community', style: TextStyle(color: Colors.white ,fontSize: 18),),
              ),
              ListTile(
                title: Text('Logout'),
                onTap: () async {
                  // await ref.read(authControllerProvider.notifier).logout();
                  // ref.read(userProvider.notifier).update((state)=> null );
                  Navigator.pop(context);
                },
              )
            ], 
          ),
        ),
    );
  }
}
