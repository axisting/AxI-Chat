// ignore_for_file: non_constant_identifier_names

import 'package:chatgpt_reload_case/constants/api_consts.dart';
import 'package:chatgpt_reload_case/models/chat_group_model.dart';
import 'package:hive/hive.dart';

abstract class BaseChatGroupRepository {
  Future<void> addChatGroup({required ChatGroupModel chatGroup});
  Future<void> deleteChatGroup({required String id});
  Future<void> updateChatGroup({required ChatGroupModel chatGroup});
  ChatGroupModel? getChatGroup({required String id});
  List<ChatGroupModel> getAllChatGroups();

  //Stream<List<CustomerModel>> streamAllCustomerFromCompany({String companyID});
}

class ChatGroupRepository extends BaseChatGroupRepository {
  late Box<ChatGroupModel> _box; // * ChatGroupModel tipinde bir kutu tanımlıyoruz
  ChatGroupModelAdapter() async {
    await openBox();
  }

  Future<void> openBox() async {
    // Kutuyu açmak için bir metod
    _box = await Hive.openBox<ChatGroupModel>(
        'chatGroupBox',encryptionCipher: HiveAesCipher(HIVE_KEY)); 
  }

  Future<void> closeBox() async {
    // * Kutuyu kapatmak için bir metod
    await openBox();
    await _box.close();
  }

  @override
  Future<void> addChatGroup({required ChatGroupModel chatGroup}) async {
    // * Kutuya yeni bir chatgroup modeli eklemek için bir metod
    await openBox();
    await _box.put(chatGroup.id, chatGroup); 
  }

  @override
  Future<void> deleteChatGroup({required String id}) async {
    // * Kutudan bir chatgroup modeli silmek için bir metod
    await openBox();
    await _box.delete(id); //  * ID'ye göre silme işlemi
  }

  @override
  Future<void> updateChatGroup({required ChatGroupModel chatGroup}) async {
    await openBox();
    // * Kutuda var olan bir chatgroup modelini güncellemek için bir metod
    await _box.put(chatGroup.id, chatGroup); 
  }

  @override
  ChatGroupModel? getChatGroup({required String id}) {
    // * Kutudan belirli bir ID'ye sahip bir chatgroup modeli getirmek için bir metodz
    openBox();
    return _box.get(id); 
  }

  @override
  List<ChatGroupModel> getAllChatGroups() {
    // * Kutudaki tüm chatgroup modellerini getirmek için bir metod
    openBox();
    return _box.values.toList(); // Değerleri liste olarak döndürür
  }
}
