



import 'package:flutter/material.dart';
import 'package:redit/screens/community/community_screen.dart';
import 'package:redit/screens/home/views/home.dart';
import 'package:routemaster/routemaster.dart';
import 'package:redit/screens/auth/views/login.dart';
import 'package:redit/screens/auth/views/register.dart';


final unauthenticatedroutes = RouteMap(
  routes: {
    '/': (_) =>  MaterialPage(child: Login() ),
  },
);
final authenticatedroutes = RouteMap(
  routes: {
    '/': (_) =>  MaterialPage(child: Home() ),
    '/create-community': (_) =>  MaterialPage(child: CommunityScreen() ),
  },
);