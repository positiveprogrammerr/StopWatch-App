import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class HomeApp extends StatefulWidget {
  const HomeApp({super.key});

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  int seconds = 0 , minutes = 0, hours = 0;
  String digitSeconds = '00', digitMinutes = '00', digitHours = '00';
  Timer? timer;
  bool started  = false;
  List laps = [];


  void stop(){
    timer!.cancel();
    setState(() {
      started = false;
    });
  } 


  void reset(){
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;

      digitSeconds = '00';
      digitMinutes = '00';
      digitHours = '00';
      laps.clear();
      started = false;
    });
  }

  void addLaps(){
    String lap = '$digitHours:$digitMinutes:$digitSeconds';
    setState(() {
      laps.add(lap);
    });
  }

  void start(){
    started = true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int localSeconds = seconds + 1;
      int localMinutes = minutes;
      int localHours = hours;

      if(localSeconds > 59){
        if(localMinutes > 59){
          localHours++;
          localMinutes = 0;
        }else{
          localMinutes++;
          localSeconds=0;
        }
      }
      setState(() {
        seconds = localSeconds;
        minutes = localMinutes;
        hours = localHours;
        digitSeconds = (seconds>=10)?'$seconds':'0$seconds';
        digitHours = (hours>=10)?'$hours':'0$hours';
        digitMinutes = (minutes>=10)?'$minutes':'0$minutes';
      });
     });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C2757),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text('StopWatch App',style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontFamily: GoogleFonts.oxygen().fontFamily,
                ),),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text('$digitHours:$digitMinutes:$digitSeconds',style: TextStyle(
                  color: Colors.white,
                  fontSize: 33,
                  fontWeight: FontWeight.w600,
                  fontFamily: GoogleFonts.oxygen().fontFamily,
                ),),
              ),
              Container(
                height: 400,
                decoration: BoxDecoration(
                  color: const Color(0xFF323F68),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.normal),
                  itemCount: laps.length,
                  itemBuilder: (context, index) {
                 return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Lap ${index+1}',style: TextStyle(
                           color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: GoogleFonts.oxygen().fontFamily,
                        ),),
                         Text('${laps[index]}',style: TextStyle(
                           color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: GoogleFonts.oxygen().fontFamily,
                        ),),
                      ],
                    ),
                  );
                },),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: (){
                        (!started)?start():stop();
                      },
                      shape: const StadiumBorder(
                        side: BorderSide(color: Colors.blue)
                        ),
                        child:  Text(
                          (!started)?'Start':'Pause',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: (){
                        addLaps();
                      }, 
                      icon: const Icon(Icons.flag,color: Colors.white,)),
                      const SizedBox(width: 8),
                   Expanded(
                    child: RawMaterialButton(
                      onPressed: (){
                        reset();
                      },
                      fillColor: Colors.blue,
                      shape: const StadiumBorder(
                        side: BorderSide(color: Colors.blue)
                        ),
                        child: const Text(
                          'Reset',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    ),
                ],
              )
            ],
          ), 
        )),
    );
  }
}