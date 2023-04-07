import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redit/screens/auth/controller/authcontroller.dart';
import 'package:redit/screens/home/views/community_drawer.dart';
import 'package:redit/widgets/h_space.dart';

class Home extends ConsumerWidget {
  Home({Key? key}) : super(key: key);

  void displayDrawer(BuildContext context){
    Scaffold.of(context).openDrawer();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
      drawer: CommunityDrawer(context: context,),
      appBar: AppBar(
        leading: Builder(builder: (context)=> IconButton(onPressed: ()=> displayDrawer(context), icon: const Icon(Icons.menu ,color: Colors.white,))),
        title: const Text('Home'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
           IconButton(
            onPressed: (){},
             icon: ClipOval(
               child: CachedNetworkImage(
                width: 30 ,
                height: 30,
                imageUrl:'${user.profile_url}',
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                     
                            ),
                  ),
                ),
                placeholder: (context, url) => const CircularProgressIndicator(color: Colors.white,),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                       ),
             ),
           ),
           const HSpace(20),
        ],
      ),
      body: Column(
        children: [
          Text('${user.uid}'),
          Text('${user.name}'),
         
          // Image.network('${user.profile_url}')
        ],
      ),
    );
  }
}
