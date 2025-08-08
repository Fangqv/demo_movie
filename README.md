# Movie App

A Flutter application that allows users to explore movies and their cast using data from The Movie DB API.

## Features

- **Movie Browse**: Display trending and popular movies
- **Search Functionality**: Search for movies by title
- **Movie Details**: Show detailed information about selected movies including title, overview, release year, runtime, and cast
- **Actor/Actress Details**: Provide details for specific actors or actresses including their name, biography, birth date, and associated movies
- **State Management**: Uses GetX for state management, dependency injection, and routing
- **Modern UI**: Beautiful and modern UI with custom animations and splash screen

## Screenshots

[Add screenshots here when available]

## Getting Started

### Prerequisites

- Flutter SDK (3.8.0 or higher)
- Dart SDK
- Android Studio / VS Code
- The Movie DB API key

### Installation

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd demo_movie
   ```

2. **Get dependencies**

   ```bash
   flutter pub get
   ```

3. **Get your API key**

   - Go to [The Movie DB](https://www.themoviedb.org/)
   - Create an account and request an API key
   - Copy your API key

4. **Configure API key**

   - Open `lib/app/services/api_service.dart`
   - Replace `YOUR_API_KEY` with your actual API key:

   ```dart
   static const String _apiKey = 'your_actual_api_key_here';
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── app/
│   ├── controllers/          # GetX controllers
│   │   ├── splash_controller.dart
│   │   ├── home_controller.dart
│   │   ├── movie_details_controller.dart
│   │   ├── actor_details_controller.dart
│   │   └── search_controller.dart
│   ├── models/              # Data models
│   │   ├── movie.dart
│   │   ├── actor.dart
│   │   └── movie_details.dart
│   ├── services/            # API services
│   │   └── api_service.dart
│   ├── theme/               # App theme
│   │   └── app_theme.dart
│   ├── views/               # UI screens
│   │   ├── splash/
│   │   ├── home/
│   │   ├── movie_details/
│   │   ├── actor_details/
│   │   └── search/
│   ├── widgets/             # Reusable widgets
│   │   ├── movie_card.dart
│   │   ├── actor_card.dart
│   │   └── loading_shimmer.dart
│   └── routes/              # App routing
│       ├── app_routes.dart
│       └── app_pages.dart
└── main.dart               # App entry point
```

## Dependencies

- **get**: State management, dependency injection, and routing
- **http**: HTTP requests for API calls
- **cached_network_image**: Image caching and loading
- **shimmer**: Loading animations
- **json_annotation**: JSON serialization
- **equatable**: Value equality

## API Endpoints Used

- `GET /trending/movie/week` - Get trending movies
- `GET /movie/popular` - Get popular movies
- `GET /search/movie` - Search movies
- `GET /movie/{id}` - Get movie details
- `GET /person/{id}` - Get actor details
- `GET /person/{id}/movie_credits` - Get actor's movies

## Architecture

The app follows a clean architecture pattern with:

- **Controllers**: Handle business logic and state management using GetX
- **Models**: Data classes with JSON serialization
- **Services**: API communication layer
- **Views**: UI components and screens
- **Widgets**: Reusable UI components

## State Management

The app uses GetX for:

- **State Management**: Reactive state management with `Obx` and `GetBuilder`
- **Dependency Injection**: Automatic dependency injection with `Get.put()` and `Get.find()`
- **Routing**: Navigation with `Get.toNamed`, `Get.off()`, etc.

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- [The Movie DB](https://www.themoviedb.org/) for providing the API
- [Flutter](https://flutter.dev/) for the amazing framework
- [GetX](https://pub.dev/packages/get) for state management
