# DummyProject - iOS E-Commerce App

Modern bir iOS uygulaması örneği. Bu proje, MVVM (Model-View-ViewModel) mimarisi kullanılarak geliştirilmiş bir e-ticaret ürün listeleme ve detay gösterim uygulamasıdır.

## 📱 Özellikler

- ✅ Ürün listesi görüntüleme (Collection View)
- ✅ Ürün detay sayfası
- ✅ Resim galerisi (Carousel/Slider)
- ✅ Genişletilebilir (Expandable) içerik bölümleri
- ✅ Yıldız derecelendirme gösterimi
- ✅ Custom popup/alert sistemi
- ✅ Asenkron network işlemleri (async/await)
- ✅ Custom image loader
- ✅ MVVM mimari yapısı
- ✅ UIKit + XIB tabanlı arayüz

## 🏗 Mimari

Proje **MVVM (Model-View-ViewModel)** mimarisi kullanılarak geliştirilmiştir.

### Katman Yapısı

```
DummyProject/
├── Application/          # App lifecycle yönetimi
├── Model/               # Data modelleri
├── View/                # Storyboard ve görsel bileşenler
├── Controller/          # View Controller'lar
├── ViewModel/           # İş mantığı ve data binding
├── Components/          # Yeniden kullanılabilir UI bileşenleri
├── Manager/            # Servis ve yardımcı sınıflar
├── Helper/             # Sabitler ve yardımcı araçlar
├── Extension/          # Swift extension'ları
└── Resources/          # Asset'ler ve medya dosyaları
```

### MVVM Implementasyonu

#### ✅ View
- Sadece UI güncellemelerinden sorumlu
- ViewModel'dan veri alır
- Kullanıcı etkileşimlerini ViewModel'a iletir

#### ✅ ViewModel
- İş mantığını içerir
- View için veri hazırlar
- Network çağrıları yapar
- State yönetimini sağlar

#### ✅ Model
- Veri yapılarını tanımlar
- API response'larını temsil eder

## 📦 Proje Bileşenleri

### Models
- **Product**: Ürün veri modeli
- **ProductsResponse**: API response wrapper
- **Popup**: Popup konfigürasyon modeli
- **ProductsViewState**: View state enum
- **StockStatus**: Stok durumu enum
- **NetworkError**: Hata tipleri

### ViewModels
- **ProductViewModel**: Ürün listesi mantığı
- **ProductCellViewModel**: Ürün hücresi veri adaptörü
- **ProductDetailViewModel**: Ürün detay mantığı
- **ImageCarouselViewModel**: Resim carousel mantığı
- **ExpandableSectionViewModel**: Genişletilebilir bölüm mantığı
- **PopupViewModel**: Popup mantığı
- **StarRatingViewModel**: Yıldız derecelendirme mantığı

### Views/Controllers
- **ViewController**: Ana ürün listesi ekranı
- **ProductDetailViewController**: Ürün detay ekranı
- **PopupViewController**: Custom alert ekranı
- **ProductCollectionViewCell**: Ürün hücresi
- **ImageCarouselCell**: Resim carousel hücresi
- **ExpandableCell**: Genişletilebilir içerik hücresi

### Managers
- **NetworkManager**: API isteklerini yöneten singleton servis
- **ImageLoader**: Asenkron resim yükleme ve cache yönetimi

### Components
- **StarRatingView**: Custom yıldız derecelendirme bileşeni

## 🌐 API

Proje [DummyJSON](https://dummyjson.com) API'sini kullanmaktadır.

**Base URL**: `https://dummyjson.com`

**Endpoint**: `/products`

## 🔧 Teknik Detaylar

### Kullanılan Teknolojiler
- **Language**: Swift
- **UI Framework**: UIKit
- **Layout**: XIB + Programmatic
- **Networking**: URLSession with async/await
- **Image Loading**: Custom async image loader
- **Architecture**: MVVM
- **Minimum iOS Version**: iOS 13.0+

### Network Katmanı
```swift
// Generic async/await network request
func request<T: Decodable>(
    urlString: String,
    responseType: T.Type
) async throws -> T
```

### State Management
```swift
enum ProductsViewState {
    case idle
    case loading
    case loaded([Product])
    case error(String)
}
```

### Delegate Pattern
```swift
protocol ProductViewModelDelegate: AnyObject {
    func didUpdate(state: ProductsViewState)
}
```

## 🚀 Kurulum ve Çalıştırma

1. Projeyi klonlayın veya indirin
```bash
git clone [repository-url]
cd DummyProject
```

2. Xcode ile açın
```bash
open DummyProject.xcodeproj
```

3. Simulator veya gerçek cihaz seçin

4. Build edin ve çalıştırın (⌘ + R)
