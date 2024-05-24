import 'package:flutter/foundation.dart';

class ModeProvider with ChangeNotifier {
  bool _modeAdmin = false;
  bool _modeMedcin = false;
  bool _modePharmacie = false;

  bool get modeAdmin => _modeAdmin;
  bool get modeMedcin => _modeMedcin;
  bool get modePharmacie => _modePharmacie;

  void toggleAdmin() {
    _modeAdmin = !_modeAdmin;
    notifyListeners();
  }

  void toggleMedcin() {
    _modeMedcin = !_modeMedcin;
    notifyListeners();
  }

  void togglePharmacie() {
    _modePharmacie = !_modePharmacie;
    notifyListeners();
  }

  void offAdmin() {
    _modeAdmin = false;
    notifyListeners();
  }

  void offMedcin() {
    _modeMedcin = false;
    notifyListeners();
  }

  void offPharmacien() {
    _modePharmacie = false;
    notifyListeners();
  }

  // Method to turn off all modes
  void turnOffAllModes() {
    offAdmin();
    offMedcin();
    offPharmacien();
  }
}
