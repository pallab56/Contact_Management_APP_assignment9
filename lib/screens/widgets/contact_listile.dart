import 'package:assignment9/db/db_handler.dart';
import 'package:assignment9/model/contact_model.dart';
import 'package:flutter/material.dart';

class ContactTile extends StatefulWidget {
  final ContactModel contact;
  const ContactTile({super.key, required this.contact});

  @override
  State<ContactTile> createState() => _ContactTileState();
}

class _ContactTileState extends State<ContactTile> {
  late int _isFavourite;
  @override
  void initState() {
    super.initState();
    _isFavourite = widget.contact.isFavorite;
  }

  Color _getAvatarColor(String name) {
    final colors = [
      Colors.purple,
      Colors.teal,
      Colors.orange,
      Colors.pink,
      Colors.green,
      Colors.indigo,
    ];

    final index = name.hashCode % colors.length;

    return colors[index.abs()];
  }

  String _getNameInitials(String name) {
    final parts = name.trim().split(' ');

    if (parts.length == 1) {
      return parts[0][0].toUpperCase();
    }

    final first = parts.first[0];
    final second = parts[1][0];
    return (first + second).toUpperCase();
  }

  Future<void> _toggleFavourite() async {
    final newValue = _isFavourite == 0 ? 1 : 0;
    setState(() {
      _isFavourite = newValue;
    });
    final updateContact = widget.contact.copyWith(isFavorite: newValue);
    await DbHandler.instance.updateFavorite(updateContact);
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.contact;
    return ListTile(
      title: Text(data.name),
      subtitle: Text(data.number),
      leading: CircleAvatar(
        backgroundColor: _getAvatarColor(data.name),
        child: Text(
          _getNameInitials(data.name),
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: _toggleFavourite,
            icon: _isFavourite == 1
                ? Icon(Icons.star, color: Colors.amber)
                : Icon(Icons.star_border_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.navigate_next_outlined),
          ),
        ],
      ),
    );
  }
}
