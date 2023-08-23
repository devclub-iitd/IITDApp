import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iitd_app/features/events/components/eventscomponents.dart';
import 'package:intl/intl.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  bool isSwitched = false;
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<DateTime> selectDateTime(BuildContext context, int i) async {
    DateTime combinedDateTime = DateTime(selectedStartDate.year, selectedStartDate.month,
        selectedStartDate.day, selectedTime.hour, selectedTime.minute);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedStartDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedStartDate) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime,
      );

      if (pickedTime != null) {
       if(i==0){
         setState(() {
          selectedStartDate = picked;
          selectedTime = pickedTime;
          combinedDateTime = DateTime(selectedStartDate.year, selectedStartDate.month,
              selectedStartDate.day, selectedTime.hour, selectedTime.minute);
        });
       }else{
          setState(() {
          selectedEndDate = picked;
          selectedTime = pickedTime;
          combinedDateTime = DateTime(selectedEndDate.year, selectedEndDate.month,
              selectedEndDate.day, selectedTime.hour, selectedTime.minute);
        });
       }
      }
    }
    if (i == 1) {
      setState(() {
        selectedEndDate = combinedDateTime;
      });
    } else {
      setState(() {
        selectedStartDate = combinedDateTime;
      });
    }

    return combinedDateTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: submitForm(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Form(
                  child: Column(
                children: [
                  const Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          "Event Name",
                          style: TextStyle(fontSize: 20),
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          color: Colors.grey.withOpacity(0.2)),
                      child: TextFormField(
                        decoration: textInputdec.copyWith(
                          hintText: "summer of code ",
                          hintStyle:
                              TextStyle(color: Colors.black.withOpacity(0.5)),
                          border: InputBorder.none,
                        ),
                        onChanged: (val) {
                          setState(() {});
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "required field";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Stars At",
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    color: Colors.grey.withOpacity(0.2)),
                                child: TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  initialValue: DateFormat('MM/dd/yyyy hh:mm a')
                                      .format(selectedStartDate),
                                  decoration: textInputdec.copyWith(
                                      hintText: "23-08-2023",
                                      hintStyle: TextStyle(
                                          color: Colors.black.withOpacity(0.5)),
                                      border: InputBorder.none,
                                      suffixIcon: InkWell(
                                          onTap: () {
                                            setState(() {
                                              ;
                                            });
                                          },
                                          child:
                                              Icon(Icons.calendar_view_month))),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "required field";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Ends At",
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    color: Colors.grey.withOpacity(0.2)),
                                child: TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  initialValue: DateFormat('MM/dd/yyyy hh:mm a')
                                      .format(selectedEndDate),
                                  decoration: textInputdec.copyWith(
                                    hintText: "23-08-2023",
                                    suffixIcon: InkWell(
                                        onTap: () {
                                          selectDateTime(context,1);
                                        },
                                        child: Icon(Icons.calendar_view_month)),
                                    hintStyle: TextStyle(
                                        color: Colors.black.withOpacity(0.5)),
                                    border: InputBorder.none,
                                  ),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "required field";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            const Text(
                              "Image ",
                              style: TextStyle(fontSize: 20),
                            ),
                            Expanded(child: Container()),
                            InkWell(
                                onTap: () {
                                  showModalBottomSheet<void>(
                                      context: context,
                                      isScrollControlled: true,
                                      isDismissible: true,
                                      enableDrag: true,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20))),
                                      builder: (BuildContext context) {
                                        return Container(
                                          height: 180,
                                          child: Column(children: [
                                            const Text(
                                              "Choose an option ):",
                                              style: TextStyle(
                                                  color: Color(0xff2E4237),
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 25,
                                                            top: 20,
                                                            bottom: 10,
                                                            right: 20),
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 5),
                                                    height: 120,
                                                    width: 120,
                                                    decoration:
                                                        const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20)),
                                                      color: Color(0xff488381),
                                                    ),
                                                    child:
                                                        const Stack(children: [
                                                      Center(
                                                          child: Icon(
                                                        Icons.browse_gallery,
                                                        size: 50,
                                                        color: Colors.white,
                                                      )),
                                                      Align(
                                                          alignment: Alignment
                                                              .bottomCenter,
                                                          child: Text(
                                                            "Gallery",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ))
                                                    ]),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 15,
                                                            top: 20,
                                                            bottom: 10,
                                                            right: 20),
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 5),
                                                    height: 120,
                                                    width: 120,
                                                    decoration:
                                                        const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20)),
                                                      color: Color(0xff488381),
                                                    ),
                                                    child:
                                                        const Stack(children: [
                                                      Center(
                                                          child: Icon(
                                                        Icons.camera,
                                                        size: 50,
                                                        color: Colors.white,
                                                      )),
                                                      Align(
                                                          alignment: Alignment
                                                              .bottomCenter,
                                                          child: Text(
                                                            "Camera",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ))
                                                    ]),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ]),
                                        );
                                      });
                                },
                                child: const Icon(
                                  Icons.add,
                                  size: 30,
                                  color: Colors.blue,
                                ))
                          ],
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            color: Colors.grey.withOpacity(0.2)),
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: textInputdec.copyWith(
                            hintText:
                                "enter image address Or upload image manually",
                            hintStyle:
                                TextStyle(color: Colors.black.withOpacity(0.5)),
                            border: InputBorder.none,
                          ),
                          onChanged: (val) {
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ),
                 
                  const SizedBox(
                    height: 10,
                  ),
                  
                  const SizedBox(
                    height: 15,
                  ),
                  const Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          "About",
                          style: TextStyle(fontSize: 20),
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          color: Colors.grey.withOpacity(0.2)),
                      child: Center(
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: textInputdec.copyWith(
                            hintText: "summer of code ",
                            hintStyle:
                                TextStyle(color: Colors.black.withOpacity(0.5)),
                            border: InputBorder.none,
                          ),
                          onChanged: (val) {
                            setState(() {});
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "required field";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  
                ],
              ))
            ],
          ),
        ),
      )),
    );
  }
   Widget submitForm(){
   return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
      child: GestureDetector(
        onTap: (){
          
        },
        child: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          decoration: const BoxDecoration(
              gradient:LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black,Colors.black45],),
              borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          child:  Center(
            child: Text("Add Product",style: const TextStyle(color:Colors.white,fontSize: 22,fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
