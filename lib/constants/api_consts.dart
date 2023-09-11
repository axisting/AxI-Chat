// ignore: duplicate_ignore
// ignore: non_constant_identifier_names
// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter_dotenv/flutter_dotenv.dart';

const String BASE_URL = "https://api.openai.com/v1";

// * ChatGPT API sitesine git ve bir API Key al
// * Sonrasında .env uzantılı dosyayı oluştur
// * OPENAI_API = senin_api_key'in şeklinde değişkenini oluştur.
final String API_KEY = dotenv.get('OPENAI_API');

// ? var key = Hive.generateSecureKey(); ile bir Liste oluştur.
// ? Ve bunu .env uzantılı dosya içinde HIVE_KEY=56,64... şeklinde ekle
// ! flutter_secure_storage Sonraki güvenlik aşaması bu
final List<int> HIVE_KEY = [
  150,
  9,
  143,
  227,
  69,
  97,
  21,
  10,
  116,
  25,
  246,
  62,
  223,
  245,
  81,
  224,
  127,
  168,
  34,
  18,
  191,
  1,
  60,
  122,
  196,
  243,
  4,
  60,
  141,
  58,
  42,
  100
];
