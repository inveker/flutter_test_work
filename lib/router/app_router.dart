import 'package:flutter/material.dart';
import 'package:flutter_test_work/screens/album_screen.dart';
import 'package:flutter_test_work/screens/albums_screen.dart';
import 'package:flutter_test_work/screens/not_found_screen.dart';
import 'package:flutter_test_work/screens/post_screen.dart';
import 'package:flutter_test_work/screens/posts_screen.dart';
import 'package:flutter_test_work/screens/user_screen.dart';
import 'package:flutter_test_work/screens/users_screen.dart';

class AppRouter {
  static const String initialRoute = UsersScreen.routeName;

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case UsersScreen.routeName:
        return _buildUsersScreen(settings);
      case UserScreen.routeName:
        return _buildUserScreen(settings);
      case PostsScreen.routeName:
        return _buildPostsScreen(settings);
      case PostScreen.routeName:
        return _buildPostScreen(settings);
      case AlbumsScreen.routeName:
        return _buildAlbumsScreen(settings);
      case AlbumScreen.routeName:
        return _buildAlbumScreen(settings);
    }
  }

  static Route<dynamic>? onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const NotFoundScreen(),
    );
  }

  static Route<dynamic> _buildUsersScreen(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const UsersScreen(),
    );
  }

  static Route<dynamic>? _buildUserScreen(RouteSettings settings) {
    final args = settings.arguments;
    assert(args is UserScreenArgs);
    if (args is UserScreenArgs) {
      return MaterialPageRoute(
        builder: (context) => const UsersScreen(),
      );
    }
  }

  static Route<dynamic>? _buildPostsScreen(RouteSettings settings) {
    final args = settings.arguments;
    assert(args is PostsScreenArgs);
    if (args is PostsScreenArgs) {
      return MaterialPageRoute(
        builder: (context) => const PostsScreen(),
      );
    }
  }

  static Route<dynamic>? _buildPostScreen(RouteSettings settings) {
    final args = settings.arguments;
    assert(args is PostScreenArgs);
    if (args is PostScreenArgs) {
      return MaterialPageRoute(
        builder: (context) => const PostScreen(),
      );
    }
  }

  static Route<dynamic>? _buildAlbumsScreen(RouteSettings settings) {
    final args = settings.arguments;
    assert(args is AlbumsScreenArgs);
    if (args is AlbumsScreenArgs) {
      return MaterialPageRoute(
        builder: (context) => const AlbumsScreen(),
      );
    }
  }

  static Route<dynamic>? _buildAlbumScreen(RouteSettings settings) {
    final args = settings.arguments;
    assert(args is AlbumScreenArgs);
    if (args is AlbumScreenArgs) {
      return MaterialPageRoute(
        builder: (context) => const AlbumScreen(),
      );
    }
  }
}