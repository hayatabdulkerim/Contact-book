import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/contact/contact_bloc.dart';
import '../bloc/contact/contact_event.dart';
import '../bloc/contact/contact_state.dart';
import '../widgets/contact_form.dart';

class AddContactScreen extends StatelessWidget {
  const AddContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Contact'),
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
              onSubmit: (contact) {
                context.read<ContactBloc>().add(AddContact(contact));
              },
              isLoading: state is ContactLoading,
            ),
          );
        },
      ),
    );
  }
}
