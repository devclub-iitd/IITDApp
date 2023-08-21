import 'package:flutter/material.dart';
import 'package:iitd_app/features/events/components/eventscomponents.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  EventComponents eventComponents = EventComponents();
  int sel = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Events"),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 15),
                width: MediaQuery.of(context).size.width - 30,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(115, 74, 74, 74),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: const Column(
                  children: [
                    Text(
                      "DEVCLUB",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Chip(
                      label: Text("SUBSCRIBE"),
                      backgroundColor: Color.fromARGB(255, 33, 170, 125),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "CLUB EVENTS",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                    color: Colors.white),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                width: 60,
                height: 3,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(1.5)),
                    color: Colors.green),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          sel = 0;
                        });
                      },
                      child: Container(
                        height: 40,
                        width: 120,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(30),
                            ),
                            color: sel == 0
                                ? const Color.fromARGB(115, 74, 74, 74)
                                : Colors.white),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 25,
                            ),
                            Text(
                              "Upcoming",
                              style: TextStyle(
                                  color:
                                      sel == 0 ? Colors.white : Colors.black),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        sel = 1;
                        setState(() {});
                      },
                      child: Container(
                        height: 40,
                        width: 120,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(30),
                            ),
                            color: sel == 1
                                ? const Color.fromARGB(115, 74, 74, 74)
                                : Colors.white),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                width: 1,
                              ),
                              Text(
                                "Past",
                                style: TextStyle(
                                    color:
                                        sel == 1 ? Colors.white : Colors.black),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              eventComponents.eventslist(context)
            ],
          ),
        ),
      )),
    );
  }
}
