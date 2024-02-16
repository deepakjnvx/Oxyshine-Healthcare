import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import 'package:oxyshine/pages/appointment.dart';
import 'package:oxyshine/pages/chat.dart';
import 'package:oxyshine/pages/notification_screen.dart';
import 'package:oxyshine/pages/profile.dart';
import 'package:oxyshine/widgets/health_needs.dart';
import 'package:oxyshine/widgets/nearby_doctors.dart';
import 'package:oxyshine/widgets/upcoming_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var value = 1;

  void navigation(int val) {
    setState(() {
      value = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView(
      padding: const EdgeInsets.all(14),
      children: [
        const UpcomingCard(),
        const SizedBox(height: 20),
        Text(
          "Health Needs",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 15),
        const HealthNeeds(),
        const SizedBox(height: 25),
        Text(
          "Nearby Doctors",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 15),
        const NearbyDoctors(),
      ],
    );
    if (value == 1) {
      content = const Appointment();
    } else if (value == 2) {
      content = const Chat();
    } else if (value == 3) {
      content = const Profile();
    }
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Oxyshine Healthcare"),
            Text(
              "How are you feeling today?",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const NotificationScreen()));
            },
            icon: const Icon(Ionicons.notifications_outline),
          ),
          IconButton(
            onPressed: () {
              //   Navigator.of(context).push(MaterialPageRoute(
              //       builder: (context) => const DoctorDetails()));
            },
            icon: const Icon(Ionicons.search_outline),
          ),
        ],
      ),
      body: content,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: value,
        onTap: (val) {
          navigation(val);
        },
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Ionicons.home_outline),
            activeIcon: Icon(Ionicons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.calendar_outline),
            activeIcon: Icon(Ionicons.calendar),
            label: "Appointment",
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.chatbubble_ellipses_outline),
            label: "Chat",
            activeIcon: Icon(Ionicons.chatbubble_ellipses),
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.person_outline),
            activeIcon: Icon(Ionicons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
