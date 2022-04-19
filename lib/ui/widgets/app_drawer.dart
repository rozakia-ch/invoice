import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _drawerHeader(),
          _drawerItem(
            icon: Icons.home,
            text: 'Beranda',
            onTap: () => Navigator.pushReplacementNamed(context, "/"),
          ),
          _drawerItem(
            icon: Icons.group,
            text: 'Harga',
            onTap: () => Navigator.pushReplacementNamed(context, "/price-page"),
          ),
          _drawerItem(
            icon: Icons.taxi_alert,
            text: 'PPN',
            onTap: () => Navigator.pushReplacementNamed(context, "/tax-page"),
          ),
          _drawerItem(
            icon: Icons.access_time,
            text: 'Note',
            onTap: () => Navigator.pushReplacementNamed(context, "/note-page"),
          ),
        ],
      ),
    );
  }

  Widget _drawerHeader() {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/images/drawer_header_background.png'),
        ),
      ),
      child: Stack(
        children: const [
          Positioned(
            bottom: 12.0,
            left: 16.0,
            child: Text(
              "Invoice App",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawerItem({
    required IconData icon,
    required String text,
    required GestureTapCallback onTap,
  }) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}