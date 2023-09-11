# Reload ChatGPT

Kullanıcılar, chatbot ile metin göndererek iletişim kurabilirler.
Chatbot, kullanıcının dilini otomatik olarak algılar ve ona uygun bir şekilde yanıt verir.
Chatbot, kullanıcının ilgi alanlarına veya isteklerine göre farklı konularda sohbet edebilir.
Chatbot, kullanıcıya eğlenceli ve yaratıcı içerikler sunabilir, örneğin şiir, hikaye, şarkı, kod, ünlü taklidi vb.
Chatbot, kullanıcıya yazma, yeniden yazma, iyileştirme veya optimizasyon gibi konularda yardımcı olabilir.

## Başlarken

Projenin kurulumu ve çalıştırılması için gerekli adımlar şunlardır:

- Flutter SDK’nın indirilmesi ve kurulması.
- Projeyi GitHub’dan klonlamak veya indirmek. -> git clone https://github.com/axisting/Flutter-Case-ChatGPT-Client.git
- Projeyi bir IDE’de (örneğin Visual Studio Code) açmak ve gerekli bağımlılıkları yüklemek.
- Bir chatbot servisi sağlayıcısından (örneğin OpenAI) bir API anahtarı almak ve projenin lib/constants/constants.dart dosyasında belirtilen yere yapıştırmak. lib/constants/constants.dart dosyasında gerekli ekstra talimatlar bulunmaktadır.

- Bir Android veya iOS cihazda veya emülatörde projeyi çalıştırmak.

## İşlevsellik

- Provider yapısı projeye,  verileri tek bir kaynaktan sağlar ve tüm uygulamaya dağıtır. Bu sayede, verilerin tutarlılığını ve güncelliğini korur.
- Provider yapısı uygulamada,  verilerde değişiklik olduğunda ilgili widget’ları yeniden oluşturur. Bu sayede, uygulamanın performansını ve verimliliğini artırır.
- Provider yapısı ile okunurluk ve bakımı kolaylaştırılmıştır. 
- Hive kütüphanesi, verilerinizi yerel olarak depolamanızı sağlayan bir hızlı, hafif ve anahtar-değer tabanlı bir veritabanıdır. Bu sayede, uygulamanızın performansını ve verimliliğini artırabilirsiniz.
- Uygulamanız, Chatbot ile yaptığınız tüm sohbetleri hive kütüphanesinde saklar. Bu sayede, internet bağlantınız olmasa bile eski mesajlarınızı görebilir ve tekrar okuyabilirsiniz. Bu da, uygulamanızın kullanıcı deneyimini ve memnuniyetini yükseltir.


## Güvenlik 

- Bu proje, kullanıcıların chatbot ile güvenli bir şekilde iletişim kurmasını sağlamak için hive şifreleme ve http kütüphanesi gibi teknolojileri kullanmaktadır.
- Hive şifreleme, verilerinizi AES-256 algoritması ile şifreler, bu da en güvenli şifreleme algoritmalarından biridir. Bu sayede, verilerinizin yetkisiz erişimlere karşı korunmasını sağlar.
- Http kütüphanesi ise, internetten veri alışverişi yaparken HTTPS protokolünü kullanır, bu da verilerinizi şifreleyerek sunucu ile aranızda güvenli bir bağlantı kurar. Bu sayede, verilerinizin dinlenmesini veya değiştirilmesini önler.
- Bu proje, chatbot servisi sağlayıcısından aldığı API anahtarını da gizli tutar ve projenin lib/constants.dart dosyasında belirtilen yere yapıştırır. Bu sayede, chatbot servisine erişiminizi kontrol eder ve kötüye kullanılmasını engeller.

