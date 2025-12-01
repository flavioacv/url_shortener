# URL Shortener

A modern, clean, and efficient Flutter application for shortening URLs. This project demonstrates a robust architecture and a user-friendly interface.

## 🚀 Features

-   **Shorten URLs**: Easily shorten long URLs into manageable links.
-   **Validation**: Real-time validation to ensure URLs are correctly formatted.
-   **History**: Keep track of your recently shortened links.
-   **Copy to Clipboard**: Quickly copy shortened URLs with a single tap.
-   **Feedback System**: Clear success and error messages for better user experience.
-   **Responsive Design**: Optimized for various screen sizes.

## 🛠️ Tech Stack

-   **Flutter**: UI Toolkit for building natively compiled applications.
-   **Dart**: Programming language.
-   **Dio**: A powerful Http client for Dart.
-   **GetIt**: Simple Service Locator for Dart and Flutter.
-   **Lucide Icons**: Beautiful & consistent icons.
-   **Clean Architecture**: Based on [Clean Dart 2.0](https://github.com/Flutterando/Clean-Dart/tree/2.0), ensuring separation of concerns for better maintainability (UI, Interactor, Core).
-   **State Management**: Cubit (Bloc).

## 📂 Project Structure

The project follows the [Clean Dart 2.0](https://github.com/Flutterando/Clean-Dart/tree/2.0) architecture pattern:

```
lib/
├── app/
│   ├── core/           # Core utilities, themes, and shared components
│   └── modules/
│       └── home/       # Home module containing the main functionality
│           ├── interactor/ # Business logic (Controllers, States)
│           └── ui/         # UI components (Pages, Widgets)
└── main.dart           # Entry point
```

## 🏁 Getting Started

### Prerequisites

-   [Flutter SDK](https://flutter.dev/docs/get-started/install) installed (version used: 3.32.8).
-   An IDE (VS Code, Android Studio, etc.) with Flutter plugins.

### Installation

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/.../url_shortener.git
    cd url_shortener
    ```

2.  **Install dependencies:**

    ```bash
    flutter pub get
    ```

3.  **Run the application:**

    ```bash
    flutter run
    ```

## 🧪 Testing

To run the tests:

```bash
flutter test
```

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
