import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redit/theme/pallete.dart';
import 'package:redit/widgets/v_space.dart';

class CommunityScreen extends ConsumerStatefulWidget {
  const CommunityScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends ConsumerState<CommunityScreen> {
  final TextEditingController _nameController = TextEditingController();
  
  FocusNode _focusnode = FocusNode();

  @override
  void dispose() {
    _focusnode.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create a community'),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Community name',
                    style: TextStyle(fontSize: 16),
                  )),
              const VSpace(10),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(18),
                  filled: true,
                  fillColor: Pallete.greyColor,
                  border: InputBorder.none,
                  hintText: 'r/Community Name',
                ),
                maxLength: 21,
              ),
              const VSpace(30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.blue),
                onPressed: () {
                  print(_nameController.text);
                },
                child: const Text(
                  'Create community',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
            ],
          ),
        ));
  }
}
