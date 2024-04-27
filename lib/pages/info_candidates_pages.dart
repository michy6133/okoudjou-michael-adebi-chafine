import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:okoudjoumichael_adebichafine/models/candidates.dart';


class InfoCandidatesPage extends StatelessWidget {
  final Candidate candidate;

  const InfoCandidatesPage({super.key, required this.candidate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${candidate.firstName} ${candidate.lastName}'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Parti politique: ${candidate.politicalParty}'),
              const SizedBox(height: 16.0),
              Center(
                child: Column(
                  children: [
                    const Text('Candidat'),
                    CircleAvatar(
                      backgroundImage: candidate.image == null
                          ? null
                          : MemoryImage(candidate as Uint8List),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Text('Bio: ${candidate.bio}'),
              const SizedBox(height: 16.0),
              Text('Né le: ${candidate.birthDate.toString().split(' ')[0]}'),
            ],
          ),
        ),
      ),
    );
  }
}
