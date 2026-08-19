import 'package:assignment9/db/db_handler.dart';
import 'package:assignment9/model/contact_model.dart';
import 'package:assignment9/screens/widgets/custom_button.dart';
import 'package:assignment9/screens/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  DbHandler dbInstance = DbHandler.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Contact')),
      body: _bodyUi(context),
    );
  }

  Widget _bodyUi(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: CircleAvatar(
              radius: 40,
              child: Icon(
                Icons.camera_alt,
                size: 32,
                color: Colors.blueAccent.shade700,
              ),
            ),
          ),

          _addContactForm(context),
        ],
      ),
    );
  }

  Widget _addContactForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            label: 'Name',
            controller: nameController,
            icon: Icon(Icons.person_outline_outlined),
          ),
      
          CustomTextField(
            label: 'Phone Number',
            controller: phoneController,
            icon: Icon(Icons.call),
          ),
      
          CustomTextField(
            label: 'Email',
            controller: emailController,
            icon: Icon(Icons.mail_outline_outlined),
          ),
      
          CustomTextField(
            label: 'Address',
            controller: addressController,
            icon: Icon(Icons.location_on),
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
          CustomButton(
            title: 'Save Contact',
            ontap: () async {
              if(_formKey.currentState!.validate())
              {
                final id = await dbInstance.addContact(
                ContactModel(
                  name: nameController.text.trim(),
                  email: emailController.text.trim(),
                  number: phoneController.text.trim(),
                  address: addressController.text.trim(),
                ),
              );
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('$id added Successfully!')));
              }   
            },
          ),
        ],
      ),
    );
  }
}
