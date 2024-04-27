import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:okoudjoumichael_adebichafine/models/candidates.dart';
import 'package:okoudjoumichael_adebichafine/pages/info_candidates_pages.dart';

import 'add_candidates_pages.dart';

class CandidatesPage extends StatefulWidget {
  const CandidatesPage({super.key});

  @override
  _CandidatesPageState createState() => _CandidatesPageState();
}

class _CandidatesPageState extends State<CandidatesPage> {
  List<Candidate> candidates = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Elections'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: candidates.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${candidates[index].firstName} ${candidates[index].lastName}'),
            subtitle: Text(candidates[index].bio),
            leading: CircleAvatar(
              backgroundImage: MemoryImage(candidates[index].image as Uint8List),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InfoCandidatesPage(candidate: candidates[index])),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddCandidatesPage()),
          ).then((value) {
            if (value != null) {
              setState(() {
                candidates.add(value);
              });
            }
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.contacts), label: 'Contacts'),
          BottomNavigationBarItem(icon: Icon(Icons.ballot), label: 'Vote'),
          const BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
