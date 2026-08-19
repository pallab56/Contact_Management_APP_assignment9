import 'package:assignment9/screens/widgets/contact_listile.dart';
import 'package:flutter/material.dart';

import 'package:assignment9/db/db_handler.dart';
import 'package:assignment9/model/contact_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final searchController = TextEditingController();

  final dbInstance = DbHandler.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Contacts'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
      ),
      drawer: _drawer(context),
      body: _bodyUi(context),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addscreen');
        },
        backgroundColor: Color(0XFF5555d9),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _bodyUi(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(children: [_searchUi(context), _showContactList(context)]),
    );
  }

  Widget _showContactList(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: dbInstance.getContacts(),
        builder: (context, AsyncSnapshot<List<ContactModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nothing to show'));
          }

          final query = searchController.text.toLowerCase().trim();

          final filteredContacts = query.isEmpty
              ? snapshot.data!
              : snapshot.data!
                    .where(
                      (contact) =>
                          contact.name.trim().toLowerCase().contains(query),
                    )
                    .toList();
          if (filteredContacts.isEmpty) {
            return Center(child: Text('Nothing Matched'));
          }
          return ListView.builder(
            itemCount: filteredContacts.length,
            itemBuilder: (context, index) {
              final data = filteredContacts[index];

              return ContactTile(contact: data);
            },
          );
        },
      ),
    );
  }

  Widget _searchUi(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(MediaQuery.sizeOf(context).height * .01),
      height: MediaQuery.sizeOf(context).height * .06,
      width: double.infinity,
      child: TextFormField(
        onTapOutside: (event) => FocusManager.instance.primaryFocus!.unfocus(),
        controller: searchController,
        onChanged: (value) {
          searchController.text = value;
          setState(() {
            
          });
        },
        decoration: InputDecoration(
          hintText: 'Search contacts...',
          suffixIcon: Icon(Icons.search_rounded),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.deepPurple.shade700, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.pink.shade300, width: 2),
          ),
        ),
      ),
    );
  }

  Widget _drawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height * .23,
            decoration: BoxDecoration(color: Color(0XFF5555d9)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Icon(Icons.groups, size: 42, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * .02),
                  Text(
                    'My Contacts',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Tracks your Friends easily",
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8),
          ListTile(
            selected: selectedIndex == 0,
            selectedTileColor: Colors.blueAccent[100]!.withAlpha(70),

            leading: Icon(Icons.people),
            title: Text('My Contacts'),
            onTap: () {
              setState(() {
                selectedIndex = 0;
              });
            },
          ),
          ListTile(
            leading: Icon(Icons.star_outlined),
            title: Text('Favourites'),
            selected: selectedIndex == 1,
            selectedTileColor: Colors.blueAccent[100]!.withAlpha(70),
            onTap: () {
              setState(() {
                selectedIndex = 1;
              });

              Navigator.pushNamed(context, '/favoutite');
            },
          ),
          ListTile(
            leading: Icon(Icons.diamond),
            title: Text('Add Contacts'),
            selected: selectedIndex == 2,
            selectedTileColor: Colors.blueAccent[100]!.withAlpha(70),
            onLongPress: () {
              Navigator.pop(context);
            },
            onTap: () {
              setState(() {
                selectedIndex = 2;
              });
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.error),
            title: Text('About App'),
            selected: selectedIndex == 3,
            selectedTileColor: Colors.blueAccent[100]!.withAlpha(70),
            onTap: () {
              setState(() {
                selectedIndex = 3;
              });
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            selected: selectedIndex == 4,
            selectedTileColor: Colors.blueAccent[100]!.withAlpha(70),
            onTap: () {
              setState(() {
                selectedIndex = 4;
              });
              Navigator.pushNamed(context, '/settings');
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            selected: selectedIndex == 5,
            selectedTileColor: Colors.blueAccent[100]!.withAlpha(70),
            onTap: () {
              setState(() {
                selectedIndex = 5;
                Navigator.pop(context);
              });
            },
          ),
        ],
      ),
    );
  }
}
