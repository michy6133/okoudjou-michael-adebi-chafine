import 'dart:io';
import 'package:flutter/material.dart';
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
          final imageProvider = candidates[index].imageUrl != null
              ? FileImage(File(candidates[index].imageUrl!))
              : AssetImage('assets/images/default_image.png');

          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text('${candidates[index].firstName} ${candidates[index].lastName}'),
              subtitle: Text(candidates[index].bio),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  File(candidates[index].imageUrl!),
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/default_image.png',
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InfoCandidatesPage(candidate: candidates[index], imageFile: File(candidates[index].imageUrl!))),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddCandidatesPage()),
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
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.contacts), label: 'Contacts'),
          BottomNavigationBarItem(icon: Icon(Icons.ballot), label: 'Vote'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
