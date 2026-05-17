import 'package:flutter/material.dart';
import '../models/contact_model.dart';
import '../screens/add_contact_screen.dart';
import '../screens/contact_detail_screen.dart';
import '../screens/contact_list_screen.dart';
import '../screens/edit_contact_screen.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const ContactListScreen(),
        );
      case '/add-contact':
        return MaterialPageRoute(
          builder: (_) => const AddContactScreen(),
        );
      case '/edit-contact':
        final contact = settings.arguments as ContactModel;
        return MaterialPageRoute(
          builder: (_) => EditContactScreen(contact: contact),
        );
      case '/contact-detail':
        final contact = settings.arguments as ContactModel;
        return MaterialPageRoute(
          builder: (_) => ContactDetailScreen(contact: contact),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
