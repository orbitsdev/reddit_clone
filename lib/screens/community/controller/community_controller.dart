

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redit/constant/constants.dart';
import 'package:redit/dialogs/modals.dart';
import 'package:redit/models/community.dart';
import 'package:redit/screens/auth/controller/authcontroller.dart';
import 'package:redit/screens/community/respository/community_repository.dart';

class CommunityController {

  final CommunityRepository _communityRepository;
  final Ref _ref;

  CommunityController({required CommunityRepository communityRepository, required Ref ref}) : _communityRepository = communityRepository, _ref = ref;

  void createCommunity(BuildContext context, String name) async{

    final uid = _ref.read(userProvider)?.uid ?? '';
    Community new_community = Community(
      id: name, 
      name: name, 
      banner: Constants.bannerDefault, 
      community_profile_url: Constants.avatarDefault,
      members: [uid],
      mods: [uid]
      );

   final res = await _communityRepository.createCommunity(new_community);
   res.fold((l) => Modals.failed(context, e: l.message) , (r) => null);
   
  }
}