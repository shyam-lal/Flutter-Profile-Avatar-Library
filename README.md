# 🧑‍🎨 Profile Name Avatar

A flexible Flutter widget for displaying user profile images with graceful fallbacks.  
If the provided image fails to load, it will show a placeholder image (if provided), or fall back to a beautifully styled avatar with the user's name.

---

## ✨ Features

- ✅ Load profile images from both network and local assets
- 🖼 Fallback to placeholder image if the profile image fails
- 🔤 Fallback to name-based avatar (initials or up to 4 letters)
- 🎨 Auto-generated background color from name hash
- ⚙️ Customizable radius, text style, and background color
- ⚡ Built-in image caching with `cached_network_image`

---

## 📦 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  profile_name_avatar: ^0.0.4
```

## Usage

```dart
import 'package:profile_name_avatar/profile_name_avatar.dart';

ProfileImage(
  imageSource: "https://example.com/avatar.jpg",
  placeholder: "assets/images/placeholder.png",     // Fallback when imagesource fail
  fallbackName: "J D",                              // Used when image & placeholder fail
  radius: 100,                                      // Optional
  textStyle: TextStyle(                             // Optional
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
  backgroundColor: Colors.orange,                   // Optional
)
```

## Example

![Profile Avatar Screenshot](https://github.com/shyam-lal/Flutter-Profile-Avatar-Library/raw/main/example/lib-pf-ss.PNG)


#### If image view is not needed
```dart
import 'package:profile_name_avatar/profile_name_avatar.dart';
ProfileAvatar(
  name: 'S S',
  radius: 40,
)
```


## Example

![Profile Avatar Screenshot](https://github.com/shyam-lal/Flutter-Profile-Avatar-Library/raw/main/example/lib-ss.PNG)