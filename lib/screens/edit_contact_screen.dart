import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/contact/contact_bloc.dart';
import '../bloc/contact/contact_event.dart';
import '../bloc/contact/contact_state.dart';
import '../models/contact_model.dart';
import '../widgets/contact_form.dart';

class EditContactScreen extends StatelessWidget {
  final ContactModel contact;

  const EditContactScreen({
    super.key,
    required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Contact'),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocConsumer<ContactBloc, ContactState>(
        listener: (context, state) {
          if (state is ContactOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                behavior: SnackBarBehavior.floating,
              ),
            );
            Navigator.pop(context, true);
          } else if (state is ContactError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ContactForm(
              contact: contact,
              onSubmit: (updatedContact) {
                context.read<ContactBloc>().add(
                      UpdateContact(contact.id!, updatedContact),
                    );
              },
              isLoading: state is ContactLoading,
            ),
          );
        },
      ),
    );
  }
}
