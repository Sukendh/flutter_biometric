# 🔐 Flutter Biometric + PIN Authentication App

A Flutter app that combines biometric authentication (Fingerprint / Face ID) using [`local_auth`](https://pub.dev/packages/local_auth) and custom PIN entry UI using [`pinput`](https://pub.dev/packages/pinput). Built for security and ease of use with a clean and scalable architecture.

---

## 🚀 Features

- ✅ Biometric authentication (Fingerprint / Face ID)
- 🔢 PIN authentication using a beautiful custom UI (`pinput`)
- 🔁 Fallback from biometrics to PIN
- 📱 Works on both Android and iOS

---

## 📸 Screenshots

| Biometric Prompt | PIN Input |
|------------------|-----------|
| ![biometric](screenshots/biometric.png) | ![pin](screenshots/pin.png) |

---

## 🧰 Tech Stack

- Flutter 3.x
- Dart
- `local_auth` – Biometric authentication
- `pinput` – Elegant PIN input

---

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  local_auth: ^2.1.4
  pinput: ^3.0.1
