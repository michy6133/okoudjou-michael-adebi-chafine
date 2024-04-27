import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:okoudjoumichael_adebichafine/models/candidates.dart';

class AddCandidatesPage extends StatefulWidget {
  @override
  _AddCandidatesPageState createState() => _AddCandidatesPageState();
}

class _AddCandidatesPageState extends State<AddCandidatesPage> {
  final _formKey = GlobalKey<FormState>();
  Candidate candidate = Candidate(
    firstName: '',
    lastName: '',
    imageUrl: '',
    bio: '',
    politicalParty: '',
    birthDate: DateTime.now(),
  );

  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
        candidate.imageUrl = _imageFile!.path;
      });
    }
  }

  void _openGallery(BuildContext context) {
    _pickImage(ImageSource.gallery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Creation de candidat'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    _openGallery(context);
                  },
                  child: CircleAvatar(
                    radius: 100.0,
                    backgroundImage: _imageFile != null
                        ? FileImage(File(_imageFile!.path))
                        : null,
                    child: _imageFile == null
                        ? const Icon(Icons.camera)
                        : null,
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  initialValue: candidate.firstName,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Entrez le prénom du candidat',
                    labelText: 'Prénom',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer le prénom du candidat';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    candidate.firstName = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  initialValue: candidate.lastName,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Entrez le nom du candidat',
                    labelText: 'Nom',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer le nom du candidat';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    candidate.lastName = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  initialValue: candidate.politicalParty,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.flag),
                    hintText: 'Entrez le parti politique du candidat',
                    labelText: 'Parti politique',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer le parti politique du candidat';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    candidate.politicalParty = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  initialValue: candidate.bio,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.description),
                    hintText: 'Entrez la bio du candidat',
                    labelText: 'Bio',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer la bio du candidat';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    candidate.bio = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  initialValue: candidate.birthDate.toString().split(' ')[0],
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_month),
                    hintText: 'Entrez la date de naissance du candidat',
                    labelText: 'Date de naissance',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer la date de naissance du candidat';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    candidate.birthDate = DateTime.parse(value!);
                  },
                  readOnly: true,
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: candidate.birthDate,
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null && picked != candidate.birthDate) {
                      setState(() {
                        candidate.birthDate = picked;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  child: const Text('Sauvegarder'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState?.save();
                      Navigator.pop(context, candidate);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
