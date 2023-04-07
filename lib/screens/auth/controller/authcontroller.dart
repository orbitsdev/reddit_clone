import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redit/dialogs/modals.dart';
import 'package:redit/screens/auth/repository/auth_repository.dart';

import 'package:redit/models/user.dart' as model;


final userProvider = StateProvider<model.User?>((ref)=> null);


final authControllerProvider = StateNotifierProvider<Authcontroller, bool>(
    (ref) => Authcontroller(
      authRepository: ref.watch(authRepositoryProvider),
      ref: ref
      ));

final authStateChangeProvider = StreamProvider((ref)=> ref.watch(authControllerProvider.notifier).authStateChange) ;
final getUserDataProvider = StreamProvider.family((ref, String uid) => ref.watch(authControllerProvider.notifier).getUserData(uid));
class Authcontroller extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;



  Authcontroller({
    required AuthRepository authRepository,
    required Ref ref,
  }) : _authRepository = authRepository , _ref = ref, super(false);


  Stream<User?> get authStateChange  => _authRepository.authStateChange; 
 

  void signinWithGoogle(BuildContext context) async {
    state = true;
    final user = await _authRepository.signInWithGoogle();
     state = false;
    user.fold(
        (failure) => Modals.failed(context, e: failure.message),
        (user) => _ref.read(userProvider.notifier).update((state)=> user ));
  }

  Stream<model.User> getUserData(String uid) {
   return _authRepository.getUserData(uid);
  }


}
