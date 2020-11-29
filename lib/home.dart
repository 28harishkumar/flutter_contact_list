import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contact_list/widgets/contact_list.dart';

import 'models/simplified_contact.dart';

class HomePage extends StatefulWidget {
  // Get contacts permission
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<dynamic> contactWidgetKey = GlobalKey();

  List<SimplifiedContact> selectedContacts = [];
  List<int> selectedContactIndices = [];

  void onContactSelect(List<SimplifiedContact> contacts, List<int> indices) {
    this.setState(() {
      selectedContacts = contacts;
      selectedContactIndices = indices;
    });
  }

  Future<void> onContactBtnPress(BuildContext context) async {
    showDialog(
      context: context,
      barrierColor: Colors.white,
      barrierDismissible: false,
      builder: (_) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          textTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: Text('Select Contact'),
          actions: [
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                contactWidgetKey.currentState.onDone(context);
              },
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              child: ContactList(
                key: contactWidgetKey,
                onDone: onContactSelect,
                selectedContactIndices: selectedContactIndices,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () {
                  onContactBtnPress(context);
                },
                child: Text('Select Contacts'),
              ),
            ),
            Container(
              child: Flexible(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: selectedContacts?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    SimplifiedContact contact =
                        selectedContacts?.elementAt(index);

                    return Column(
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 18,
                          ),
                          title: Text(contact.name),
                          subtitle: Text(contact.phone),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
