import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:redit/constant/constants.dart';
import 'package:redit/constant/firebase_constant.dart';
import 'package:redit/failure.dart';
import 'package:redit/provider/firbase_provider.dart';
import 'package:redit/models/user.dart' as model;
import 'package:redit/type_def.dart';



final authRepositoryProvider = Provider((ref) => AuthRepository(
    firestore: ref.read(firestoreProvider),
    auth: ref.read(authProvider),
    googleSignIn: ref.read(googleSignInProvider)));

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn? _googleSignIn;

  AuthRepository(
      {required FirebaseFirestore firestore,
      required FirebaseAuth auth,
      required GoogleSignIn googleSignIn})
      : _firestore = firestore,
        _auth = auth,
        _googleSignIn = googleSignIn;

  CollectionReference get _users => _firestore.collection(FirebaseConstant.usersCollection);

  Stream<User?> get authStateChange  => _auth.authStateChanges(); 

  FutureEither<model.User> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      model.User user;

        

      if (userCredential.additionalUserInfo!.isNewUser) {
         user = model.User(
          uid: userCredential.user!.uid,
          name: userCredential.user!.displayName ?? 'No Name',
          profile_url: userCredential.user!.photoURL ?? 'user.png',
          banner: Constants.bannerDefault,
          is_authenticated: true,
          karma: 0,
          awards: []);

          await _users.doc(userCredential.user!.uid).set(user.toMap());
      }else{
          user = await getUserData(userCredential.user!.uid).first;
      }

      return right(user);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e as String));
    }
  }

  Stream<model.User> getUserData(String uid) {
    return  _users.doc(uid).snapshots().map((event) => model.User.fromMap(event.data() as Map<String, dynamic>));
  }
}
