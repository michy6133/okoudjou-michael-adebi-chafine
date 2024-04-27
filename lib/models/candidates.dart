
import 'package:flutter/services.dart';

class Candidate {
  String _firstName;
  String _lastName;
  String _imageUrl;
  String _bio;
  String _politicalParty;
  DateTime _birthDate;

  Candidate({
    required String firstName,
    required String lastName,
    required String imageUrl,
    required String bio,
    required String politicalParty,
    required DateTime birthDate,
  })  : _firstName = firstName,
        _lastName = lastName,
        _imageUrl = imageUrl,
        _bio = bio,
        _politicalParty = politicalParty,
        _birthDate = birthDate;

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get imageUrl => _imageUrl;
  String get bio => _bio;
  String get politicalParty => _politicalParty;
  DateTime get birthDate => _birthDate;

  set firstName(String value) {
    _firstName = value;
  }

  set lastName(String value) {
    _lastName = value;
  }

  set imageUrl(String value) {
    _imageUrl = value;
  }

  set bio(String value) {
    _bio = value;
  }

  set politicalParty(String value) {
    _politicalParty = value;
  }

  set birthDate(DateTime value) {
    _birthDate = value;
  }

  Uint8List? _image;

  Uint8List? get image => _image;

  Future<void> loadImage() async {
    final data = await rootBundle.load(imageUrl);
    _image = data.buffer.asUint8List();
  }
}
