// import 'package:doctor_appointment_app/providers/dio_provider.dart';
// import 'package:doctor_appointment_app/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:oxyshine/config.dart';
import 'package:oxyshine/widgets/appointment_card.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';

class Appointment extends StatefulWidget {
  const Appointment({Key? key}) : super(key: key);

  @override
  State<Appointment> createState() => _AppointmentPageState();
}

enum FilterStatus { upcoming, completed, canceled }

class _AppointmentPageState extends State<Appointment> {
  FilterStatus status = FilterStatus.upcoming;
  Alignment _alignment = Alignment.centerLeft;
  List<dynamic> schedules = [
    {
      'doctor_name': "Sanjeev Sharma",
      'doctor_profile': "assets/doctor_1.jpg",
      'category': "Physiotherapist",
      'status': FilterStatus.upcoming,
      'date': "20-12-2023",
      'day': "Saturday",
      'time': "12:20 PM",
    },
    {
      'doctor_name': "Sanjeev Sharma",
      'doctor_profile': "assets/doctor_1.jpg",
      'category': "Physiotherapist",
      'status': FilterStatus.canceled,
      'date': "20-02-2024",
      'day': "Monday",
      'time': "12:20 PM",
    },
    {
      'doctor_name': "Dr. D. Shankar",
      'doctor_profile': "assets/doctor_2.jpg",
      'category': "Eye Nose Throat Specialist",
      'status': FilterStatus.canceled,
      'date': "02-02-2024",
      'day': "Monday",
      'time': "11:20 AM",
    },
    {
      'doctor_name': "Dr. D. Shankar",
      'doctor_profile': "assets/doctor_2.jpg",
      'category': "Eye Nose Throat Specialist",
      'status': FilterStatus.completed,
      'date': "20-01-2024",
      'day': "Saturday",
      'time': "12:20 PM",
    },
    {
      'doctor_name': "Sanjeev Sharma",
      'doctor_profile': "assets/doctor_1.jpg",
      'category': "Physiotherapist",
      'status': FilterStatus.upcoming,
      'date': "20-02-2024",
      'day': "Monday",
      'time': "11:00 AM",
    },
    {
      'doctor_name': "Sanjeev Sharma",
      'doctor_profile': "assets/doctor_1.jpg",
      'category': "Physiotherapist",
      'status': FilterStatus.canceled,
      'date': "10-01-2024",
      'day': "Tuesday",
      'time': "10:20 AM",
    },
    {
      'doctor_name': "Dr. D. Shankar",
      'doctor_profile': "assets/doctor_2.jpg",
      'category': "Eye Nose Throat Specialist",
      'status': FilterStatus.completed,
      'date': "20-01-2024",
      'day': "Wednesday",
      'time': "12:20 PM",
    },
    {
      'doctor_name': "Dr. D. Shankar",
      'doctor_profile': "assets/doctor_2.jpg",
      'category': "Eye Nose Throat Specialist",
      'status': FilterStatus.upcoming,
      'date': "20-02-2024",
      'day': "Monday",
      'time': "10:00 AM",
    },
  ];

  //get appointments details
  // Future<void> getAppointments() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString('token') ?? '';
  //   final appointment = await DioProvider().getAppointments(token);
  //   if (appointment != 'Error') {
  //     setState(() {
  //       schedules = json.decode(appointment);
  //     });
  //   }
  // }

  @override
  void initState() {
    // getAppointments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> filteredSchedules = schedules.where((var schedule) {
      switch (schedule['status']) {
        case 'upcoming':
          schedule['status'] = FilterStatus.upcoming;
          break;
        case 'completed':
          schedule['status'] = FilterStatus.completed;
          break;
        case 'canceled':
          schedule['status'] = FilterStatus.canceled;
          break;
      }
      return schedule['status'] == status;
    }).toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Appointment Schedule',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Config.spaceSmall,
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //this is the filter tabs
                      for (FilterStatus filterStatus in FilterStatus.values)
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (filterStatus == FilterStatus.upcoming) {
                                  status = FilterStatus.upcoming;
                                  _alignment = Alignment.centerLeft;
                                } else if (filterStatus ==
                                    FilterStatus.completed) {
                                  status = FilterStatus.completed;
                                  _alignment = Alignment.center;
                                } else if (filterStatus ==
                                    FilterStatus.canceled) {
                                  status = FilterStatus.canceled;
                                  _alignment = Alignment.centerRight;
                                }
                              });
                            },
                            child: Center(
                              child: Text(filterStatus.name),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                AnimatedAlign(
                  alignment: _alignment,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Config.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        status.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Config.spaceSmall,
            Expanded(
              child: ListView.builder(
                itemCount: filteredSchedules.length,
                itemBuilder: ((context, index) {
                  var schedule = filteredSchedules[index];
                  // bool isLastElement = filteredSchedules.length + 1 == index;
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: AppointmentCard(
                      profile: schedule['doctor_profile'],
                      name: schedule['doctor_name'],
                      category: schedule['category'],
                      date: schedule['date'],
                      day: schedule['day'],
                      time: schedule['time'],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class ScheduleCard extends StatelessWidget {
//   const ScheduleCard(
//       {Key? key, required this.date, required this.day, required this.time})
//       : super(key: key);
//   final String date;
//   final String day;
//   final String time;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.grey.shade200,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       width: double.infinity,
//       padding: const EdgeInsets.all(20),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           const Icon(
//             Icons.calendar_today,
//             color: Config.primaryColor,
//             size: 15,
//           ),
//           const SizedBox(
//             width: 5,
//           ),
//           Text(
//             '$day, $date',
//             style: const TextStyle(
//               color: Config.primaryColor,
//             ),
//           ),
//           const SizedBox(
//             width: 20,
//           ),
//           const Icon(
//             Icons.access_alarm,
//             color: Config.primaryColor,
//             size: 17,
//           ),
//           const SizedBox(
//             width: 5,
//           ),
//           Flexible(
//               child: Text(
//             time,
//             style: const TextStyle(
//               color: Config.primaryColor,
//             ),
//           ))
//         ],
//       ),
//     );
//   }
// }



// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:oxyshine/widgets/appointment_card.dart';

// class Appointment extends StatefulWidget {
//   const Appointment({super.key});

//   @override
//   State<Appointment> createState() => _AppointmentState();
// }

// class _AppointmentState extends State<Appointment> {
//   int activeIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       padding: const EdgeInsets.all(5),
//       children: [
//         const SizedBox(
//           height: 10,
//         ),
//         CupertinoSlidingSegmentedControl(
//           groupValue: activeIndex,
//           padding: EdgeInsets.all(10),
//           children: const {
//             0: Text("Upcoming"),
//             1: Text("Completed"),
//             2: Text("Results"),
//           },
//           onValueChanged: (value) {
//             setState(() {
//               activeIndex = value!;
//             });
//           },
//         ),
//         SizedBox(
//           height: 20,
//         ),
// AppointmentCard(),
//       ],
//     );
//   }
// }