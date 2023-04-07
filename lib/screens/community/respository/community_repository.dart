




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:redit/constant/firebase_constant.dart';
import 'package:redit/failure.dart';
import 'package:redit/models/community.dart';
import 'package:redit/provider/firbase_provider.dart';
import 'package:redit/screens/community/community_screen.dart';
import 'package:redit/type_def.dart';




final CommunityRepositoryProvider = Provider((ref)=> CommunityRepository(firestore: ref.watch(firestoreProvider)));

class CommunityRepository {

  final FirebaseFirestore _firestore;
  CommunityRepository({required FirebaseFirestore firestore}) : _firestore = firestore;


  CollectionReference get _communties => _firestore.collection(FirebaseConstant.commentsCollection);

  FutureVoid createCommunity(Community community) async{
    try {
        var communityDoc = await _communties.doc(community.name).get();
        if(communityDoc.exists){
            throw 'Community already exist!';

        }

          return right( _communties.doc(community.name).set(community.toMap()));

    }on FirebaseException  catch (e) {

      return left(Failure(e.message.toString()));
    }catch(e){
      return left(Failure(e.toString()));
    }
  }


}