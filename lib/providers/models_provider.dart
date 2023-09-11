import 'package:chatgpt_reload_case/models/models_model.dart';
import 'package:chatgpt_reload_case/services/api_service.dart';
import 'package:flutter/cupertino.dart';

class ModelsProvider with ChangeNotifier {
  // * Model hakkında - Şuanda sabit bir model üzerinden ilerlerken opsiyonel olarak kullanıcıya seçtirebiliriz.
  // String currentModel = "text-davinci-003";
  // gpt-3.5-turbo-0301
  String currentModel = "gpt-3.5-turbo-0301"; 

  String get getCurrentModel {
    return currentModel;
  }

  void setCurrentModel(String newModel) {
    currentModel = newModel;
    notifyListeners();
  }

  List<ModelsModel> modelsList = [];

  List<ModelsModel> get getModelsList {
    return modelsList;
  }

  Future<List<ModelsModel>> getAllModels() async {
    modelsList = await ApiService.getModels();
    return modelsList;
  }
}
