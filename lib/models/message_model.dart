class MessageModel {
  // ! Şimdilik kullanılmıyor
  // * Bu sınıf toplu mesaj ve geri dönüş için https://api.openai.com/v1/chat/completions API'si için yapılmıştır.
  final String role; // msg yerine role
  final String content; // chatIndex yerine content

  MessageModel({required this.role, required this.content});

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        role: json["role"], // msg yerine role
        content: json["content"], // chatIndex yerine content
      );

  Map<String, dynamic> toJson() => { // Bu metodu ekleyin
        "role": role,
        "content": content,
      };
}