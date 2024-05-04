//TODO: We will add more  fields here as we go on.
//Ordonnaces , family , radios , analyses  etc...
class Patient {
  String? id;
  String? familyName;
  String? name;
  String? gender;
  int? birthDay;
  int? birthMonth;
  int? birthYear;
  String? birthPlace;
  String? profilePicUrl;
  String? bio;
  String? documentId;
  String? telephone;
  String? bloodType;
  double? weight;
  double? height;

  Patient({
    this.id,
    this.familyName,
    this.name,
    this.gender,
    this.birthDay,
    this.birthMonth,
    this.birthYear,
    this.birthPlace,
    this.profilePicUrl,
    this.bio,
    this.documentId,
    this.telephone,
    this.bloodType,
    this.height,
    this.weight,
  });

  void updatePatientInformation(
      {required String id,
      required String familyName,
      required String name,
      required String gender,
      required int birthDay,
      required int birthMonth,
      required int birthYear,
      required String birthPlace,
      String? profilePicUrl,
      String? bio,
      String? documentId,
      String? telephone,
      required String bloodType,
      required double weight,
      required double height}) {
    this.id = id;
    this.familyName = familyName;
    this.name = name;
    this.gender = gender;
    this.birthDay = birthDay;
    this.birthMonth = birthMonth;
    this.birthYear = birthYear;
    this.birthPlace = birthPlace;
    this.profilePicUrl = profilePicUrl;
    this.bio = bio;
    this.documentId = documentId;
    this.telephone = telephone;
    this.bloodType = bloodType;
    this.weight = weight;
    this.height = height;
  }
}
