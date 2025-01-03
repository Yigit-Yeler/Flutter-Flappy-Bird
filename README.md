# Flutter Flappy Bird

<img src="assets/sprites/yellowbird-upflap.png" width="100" alt="Flappy Bird">

Flutter kullanılarak geliştirilmiş klasik Flappy Bird oyununun bir klonu.

## 🎮 Özellikler

- Klasik Flappy Bird oynanışı
- Gerçekçi fizik motoru
- Puan sistemi
- Ses efektleri
- Pixel art grafikleri
- Yüksek skor takibi

## 📱 Ekran Görüntüleri

[Ekran görüntüleri buraya eklenecek]

## 🚀 Kurulum

1. Flutter'ı yükleyin (https://flutter.dev/docs/get-started/install)
2. Projeyi klonlayın:
```bash
git clone https://github.com/kullaniciadi/flappy_bird.git
```
3. Bağımlılıkları yükleyin:
```bash
cd flappy_bird
flutter pub get
```
4. Uygulamayı çalıştırın:
```bash
flutter run
```

## 🎯 Nasıl Oynanır

- Oyunu başlatmak için ekrana dokunun
- Kuşu zıplatmak için ekrana dokunun
- Borulardan kaçının
- Her geçilen boru için 1 puan kazanın
- Yere veya borulara çarpmamaya çalışın

## 🛠️ Teknik Detaylar

- Flutter 3.x
- Dart 3.x
- State management için Provider
- Asset yönetimi
- Collision detection sistemi

## 📦 Proje Yapısı

```
lib/
  ├── constants/       # Oyun sabitleri
  ├── models/         # Veri modelleri
  ├── screens/        # Oyun ekranları
  ├── widgets/        # Yeniden kullanılabilir widget'lar
  └── main.dart       # Ana uygulama dosyası
```

## 🤝 Katkıda Bulunma

1. Bu projeyi fork edin
2. Feature branch'i oluşturun (`git checkout -b feature/yeniOzellik`)
3. Değişikliklerinizi commit edin (`git commit -m 'Yeni özellik eklendi'`)
4. Branch'inizi push edin (`git push origin feature/yeniOzellik`)
5. Pull Request oluşturun

## 📝 Lisans

Bu proje MIT lisansı altında lisanslanmıştır - detaylar için [LICENSE](LICENSE) dosyasına bakın.

## 👏 Teşekkürler

- Orijinal Flappy Bird oyununun yaratıcısı Dong Nguyen'e
- Flutter ve Dart ekibine
- Tüm katkıda bulunanlara
