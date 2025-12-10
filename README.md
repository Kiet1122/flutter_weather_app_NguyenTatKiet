# 🌤️ Weather App - Ứng Dụng Thời Tiết Flutter

Một ứng dụng thời tiết đẹp mắt, đầy đủ tính năng được xây dựng bằng Flutter cung cấp thông tin thời tiết thời gian thực, dự báo và hỗ trợ đa ngôn ngữ.

## 📱 Tính Năng

### 🌟 Tính Năng Chính
- **Hiển thị thời tiết hiện tại**
  - Nhiệt độ với cảm giác thực tế
  - Điều kiện thời tiết với biểu tượng
  - Tên thành phố và quốc gia
  - Ngày và giờ hiện tại
  - Mô tả thời tiết

- **Chi tiết thời tiết**
  - Độ ẩm (%)
  - Tốc độ gió (m/s, km/h, mph)
  - Áp suất (hPa)
  - Tầm nhìn (km)
  - Mặt trời mọc/lặn
  - Chỉ số UV (nếu có)

- **Dự báo thời tiết**
  - Dự báo theo giờ (24 giờ tiếp theo)
  - Dự báo hàng ngày (5-7 ngày)
  - Nhiệt độ tối thiểu/tối đa
  - Xác suất mưa

- **Tìm kiếm thành phố**
  - Tìm kiếm theo tên thành phố
  - Lịch sử tìm kiếm
  - Thành phố yêu thích (lưu tối đa 5 thành phố)

- **Dịch vụ định vị**
  - Tự động phát hiện vị trí
  - Chọn vị trí thủ công
  - Xử lý quyền truy cập vị trí

- **Hỗ trợ ngoại tuyến**
  - Lưu cache dữ liệu cuối cùng
  - Hiển thị dữ liệu đã cache khi offline
  - Chỉ báo khi đang dùng dữ liệu cache

- **Cài đặt**
  - Đơn vị nhiệt độ (Celsius/Fahrenheit)
  - Đơn vị tốc độ gió (km/h, m/s, mph)
  - Định dạng thời gian (12/24 giờ)
  - Ngôn ngữ (Anh/Việt/Tây Ban Nha)

### 🎨 Thiết kế UI/UX
- **Giao diện động** thay đổi theo điều kiện thời tiết
- **Gradient nền** khác nhau cho từng loại thời tiết
- **Hiệu ứng loading shimmer**
- **Pull-to-refresh** để cập nhật dữ liệu
- **Responsive design** cho nhiều kích thước màn hình

## 🏗️ Kiến Trúc Dự Án

```
lib/
│   main.dart
│   
├───config
│       api_config.dart
│       
├───models
│       forecast_model.dart      
│       hourly_weather_model.dart
│       location_model.dart      
│       weather_model.dart       
│
├───providers
│       location_provider.dart
│       settings_provider.dart
│       weather_provider.dart
│       
├───screens
│       forecast_screen.dart
│       home_screen.dart
│       search_screen.dart
│       settings_screen.dart
│       
├───services
│       connectivity_service.dart
│       language_service.dart
│       location_service.dart
│       storage_service.dart
│       weather_service.dart
│       
├───utils
│       constants.dart
│       date_formatter.dart
│       weather_icons.dart
│       
└───widgets
        current_weather_card.dart
        daily_forecast_card.dart
        error_widget.dart
        hourly_forecast_list.dart
        loading_shimmer.dart
        weather_detail_item.dart
```

## 🚀 Cài Đặt

### Yêu Cầu Hệ Thống
- Flutter SDK >= 3.0.0
- Dart >= 2.19.0
- Android Studio/VSCode với Flutter extension

### Bước Cài Đặt

1. **Clone repository**
```bash
git clone https://github.com/Kiet1122/flutter_weather_app_NguyenTatKiet.git
cd weatherapp
```

2. **Cài đặt dependencies**
```bash
flutter pub get
```

3. **Cấu hình API Key**
   - Tạo file `.env` từ `.env.example`
   - Thêm API key của bạn:
```env
OPENWEATHER_API_KEY=your_api_key_here
```

4. **Chạy ứng dụng**
```bash
# Chạy trên Android
flutter run
```

## 🔑 Lấy API Key

1. Truy cập [OpenWeatherMap](https://openweathermap.org/api)
2. Đăng ký tài khoản miễn phí
3. Vào trang API Keys
4. Copy API Key và thêm vào file `.env`

## 📊 Kiểm Thử

### Chạy Unit Tests
```bash
# Chạy tất cả tests
flutter test

# Chạy tests theo nhóm
flutter test test/models/
flutter test test/providers/
flutter test test/services/
flutter test test/utils/
flutter test test/widgets/
```

### Kiểm Thử Thủ Công
1. **Điều kiện mạng**
   - Mạng ổn định
   - Mạng chậm
   - Chế độ offline

2. **Quyền định vị**
   - Cho phép định vị
   - Từ chối định vị
   - Từ chối vĩnh viễn

3. **Tìm kiếm**
   - Tên thành phố hợp lệ
   - Tên thành phố không tồn tại
   - Tìm kiếm trống

## 🛠️ Công Nghệ Sử Dụng

### Dependencies
- **http**: HTTP requests
- **provider**: State management
- **geolocator**: Location services
- **geocoding**: Geocoding services
- **shared_preferences**: Local storage
- **cached_network_image**: Image caching
- **intl**: Date formatting
- **connectivity_plus**: Network connectivity
- **shimmer**: Loading effects
- **flutter_dotenv**: Environment variables

### Dev Dependencies
- **flutter_test**: Unit testing
- **mockito**: Mocking for tests
- **flutter_lints**: Code linting

## 📱 Màn Hình Ứng Dụng

### 🏠 Màn Hình Chính
- Hiển thị thời tiết hiện tại
- Dự báo theo giờ (24h)
- Dự báo hàng ngày (5 ngày)
- Chi tiết thời tiết

| ![Home Screen](https://res.cloudinary.com/dmnkakpnb/image/upload/v1765389759/home_chejo6.png) | ![Home Screen](https://res.cloudinary.com/dmnkakpnb/image/upload/v1765389759/home-1_a0thvg.png) |

### 🔍 Màn Hình Tìm Kiếm
- Tìm kiếm thành phố
- Lịch sử tìm kiếm
- Thành phố yêu thích

![Search Screen](https://res.cloudinary.com/dmnkakpnb/image/upload/v1765389940/search_vron4w.png)

### ⚙️ Màn Hình Cài Đặt
- Đơn vị nhiệt độ
- Đơn vị tốc độ gió
- Định dạng thời gian
- Ngôn ngữ

![Search Screen](https://res.cloudinary.com/dmnkakpnb/image/upload/v1765389759/setting_injevj.png)

## 🌈 Chủ Đề & Màu Sắc

### Gradient theo Thời Tiết
- **Trời nắng**: Vàng (#FDB813) → Xanh trời (#87CEEB)
- **Mưa**: Xám đậm (#4A5568) → Xám nhạt (#718096)
- **Mây**: Xám trung bình (#A0AEC0) → Xám sáng (#CBD5E0)
- **Đêm**: Xanh đêm (#2D3748) → Đen (#1A202C)

### Biểu Tượng Thời Tiết
- Sử dụng biểu tượng từ OpenWeatherMap API
- Fallback với Material Icons

## 🔄 Xử Lý Lỗi

### Các Trường Hợp Lỗi
1. **Lỗi mạng**: Hiển thị thông báo và nút thử lại
2. **API error**: Hiển thị thông báo lỗi cụ thể
3. **Không có dữ liệu**: Hiển thị trạng thái trống
4. **Quyền bị từ chối**: Hướng dẫn bật quyền

### Offline Support
- Lưu cache dữ liệu 30 phút
- Hiển thị chỉ báo "Offline Mode"
- Pull-to-refresh để cập nhật

## 📈 Tính Năng Nâng Cao (Bonus)

### ✅ Đã Triển Khai
- [x] Hỗ trợ đa ngôn ngữ
- [x] Chuyển đổi đơn vị
- [x] Offline caching
- [x] Search history & favorites
- [x] Dynamic weather backgrounds

### 🔜 Có Thể Phát Triển Thêm
- [ ] Weather alerts
- [ ] Weather maps
- [ ] Air quality index
- [ ] Home screen widgets
- [ ] Weather animations
- [ ] Multiple API fallback

## 🧪 Kiểm Thử

### Unit Tests
- **Models**: WeatherModel, ForecastModel, LocationModel
- **Providers**: SettingsProvider, WeatherProvider
- **Services**: StorageService, WeatherService
- **Utils**: DateFormatter, WeatherIcons
- **Widgets**: CurrentWeatherCard

![Search Screen](https://res.cloudinary.com/dmnkakpnb/image/upload/v1765389759/test_ru9pjw.png)

# **🎬 Video Demo**

[**👉 Xem Video Demo tại đây 👈**](https://res.cloudinary.com/dmnkakpnb/video/upload/v1765391113/demo-weather_kigfjx.mp4)
