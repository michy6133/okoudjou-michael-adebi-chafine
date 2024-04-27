import 'dart:io';
import 'package:flutter/material.dart';
import 'package:okoudjoumichael_adebichafine/models/candidates.dart';

class InfoCandidatesPage extends StatelessWidget {
  final Candidate candidate;
  final File? imageFile;

  const InfoCandidatesPage({super.key, required this.candidate, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    final Object imageProvider = imageFile != null
        ? FileImage(File(imageFile!.path))
        : const AssetImage('assets/images/default_image.png');

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
                    const SizedBox(height: 16.0),
                    Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: imageProvider as ImageProvider<Object>,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
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
