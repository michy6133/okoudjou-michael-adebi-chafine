import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:okoudjoumichael_adebichafine/models/candidates.dart';
import 'package:intl/intl.dart';

class AddCandidatesPage extends StatefulWidget {
  const AddCandidatesPage({super.key});

  @override
  _AddCandidatesPageState createState() => _AddCandidatesPageState();
}

class _AddCandidatesPageState extends State<AddCandidatesPage> {
  final _formKey = GlobalKey<FormState>();
  final _birthDateController = TextEditingController();
  Candidate candidate = Candidate(
      firstName: '',
      lastName: '',
      imageUrl: '',
      bio: '',
      politicalParty: '',
      birthDate: DateTime.now());

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

  void _updateBirthDateField(DateTime pickedDate) {
    final formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
    setState(() {
      candidate.birthDate = pickedDate;
      _birthDateController.text = formattedDate;
    });
  }

  Future<void> _showPicker(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Galerie'),
                  onTap: () {
                    _pickImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  }),
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Appareil photo'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
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
                    _showPicker(context);
                  },
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: _imageFile != null
                            ? FileImage(File(_imageFile!.path)) as ImageProvider
                            : const AssetImage('assets/images/default_image.png') as ImageProvider,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _imageFile == null
                        ? const Icon(Icons.camera)
                        : null,
                  ),
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
                    hintText: 'Entrez la description du candidat',
                    labelText: 'Description',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer la description du candidat';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    candidate.bio = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _birthDateController,
                  decoration: InputDecoration(
                    hintText: 'Entrez la date de naissance du candidat',
                    labelText: 'Date de naissance',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_month),
                      onPressed: () async {
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
                          // Mettre à jour le champ du formulaire avec la date choisie
                          _updateBirthDateField(picked);
                        }
                      },
                    ),
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
