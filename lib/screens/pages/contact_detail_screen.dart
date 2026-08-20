import 'package:assignment9/db/db_handler.dart';
import 'package:assignment9/screens/pages/edit_contact_screen.dart';
import 'package:assignment9/screens/pages/home_screen.dart';
import 'package:assignment9/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:assignment9/model/contact_model.dart';

class ContactDetailScreen extends StatefulWidget {
  final ContactModel contact;
  const ContactDetailScreen({super.key, required this.contact});

  @override
  State<ContactDetailScreen> createState() => _ContactDetailScreenState();
}

class _ContactDetailScreenState extends State<ContactDetailScreen> {
  late ContactModel contact;
  @override
  void initState() {
    super.initState();
    contact = widget.contact;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBar(context), body: _bodyUi(context));
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      title: Text('ConatactDetail'),
      actions: [
        IconButton(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    EditContactScreen(contact: contact),
              ),
            );
            if (result != null && result is ContactModel) {
              setState(() {
               contact = result;
              });
            }
          },
          icon: Icon(Icons.edit_outlined),
        ),
        IconButton(
          onPressed: _deleteDialogShow,
          icon: Icon(Icons.delete_outlined),
        ),
      ],
    );
  }

  void _deleteDialogShow() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: Colors.red.shade200.withAlpha(50),
              child: Icon(
                Icons.delete,
                size: 36,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height * .02),
            Text(
              'Delete Contact',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height * .02),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(color: Colors.black),

                children: [
                  TextSpan(text: 'Are you sure you want to delete\n'),

                  TextSpan(
                    text: '${contact.name}?',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10),
                  side: BorderSide(color: Colors.black.withAlpha(50)),
                ),
                child: Text('Cancel'),
              ),
              MaterialButton(
                onPressed: () async {
                  await DbHandler.instance
                      .deleteContact(contact)
                      .then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'The ${contact.id} Contacts deleted Succesfully',
                            ),
                          ),
                        );
                      })
                      .onError((error, stacktrace) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'The ${contact.id} Can not ${error}',
                            ),
                          ),
                        );
                      });
                  if (mounted) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  }
                },
                color: Colors.red.withAlpha(255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10),
                  side: BorderSide(color: Colors.black.withAlpha(50)),
                ),
                child: Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bodyUi(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _headerSection(context),
          SizedBox(height: 20),
          _cardSection(context),
        ],
      ),
    );
  }

  Widget _headerSection(BuildContext context) {
    final data = contact;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: MediaQuery.sizeOf(context).height * .06),
        Center(
          child: CircleAvatar(
            backgroundColor: Utils.getAvatarColor(data.name, context),
            radius: 40,
            child: Text(
              Utils.getNameInitials(data.name),
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.sizeOf(context).height * .02),
        Text(
          data.name,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _cardSection(BuildContext context) {
    final data = contact;
    return Card(
      color: Colors.white,

      child: Container(
        height: MediaQuery.sizeOf(context).height * .28,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ListTile(
              title: Text(
                data.number,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Mobile', style: TextStyle(fontSize: 16)),
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(Icons.phone_outlined),
              ),
            ),

            ListTile(
              title: Text(
                data.email,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Email', style: TextStyle(fontSize: 16)),
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(Icons.email_outlined),
              ),
            ),

            ListTile(
              title: Text(
                data.address,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Address', style: TextStyle(fontSize: 16)),
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(Icons.location_on),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
