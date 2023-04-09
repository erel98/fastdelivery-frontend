import 'package:fastdelivery/Controllers/Providers/availability_provider.dart';
import 'package:fastdelivery/Models/availability.dart';
import 'package:fastdelivery/global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AvailabilityWidget extends StatefulWidget {
  @override
  State<AvailabilityWidget> createState() => _AvailabilityWidgetState();
}

class _AvailabilityWidgetState extends State<AvailabilityWidget> {
  bool isToday(int day) {
    var now = DateTime.now();
    if (now.weekday - 1 == day) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    final availabilityProvider =
        Provider.of<AvailabilityProvider>(context, listen: false);
    availabilityProvider.getAvailabilities(context);
  }

  @override
  Widget build(BuildContext context) {
    final availabilityData = Provider.of<AvailabilityProvider>(context);
    final av = availabilityData.availabilities;
    av.sort((a, b) {
      int comp = a.dayOfWeek.compareTo(b.dayOfWeek);
      if (comp == 0) {
        return a.fromTime.compareTo(b.fromTime);
      }
      return comp;
    });
    return av.isEmpty
        ? const Center(child: Text('You don\'t have any availabilities'))
        : ListView.separated(
            itemBuilder: ((BuildContext context, index) {
              return Container(
                color: isToday(av[index].dayOfWeek)
                    ? Colors.greenAccent
                    : Colors.white,
                child: ListTile(
                  title: Text(Global.getWeekDay(av[index].dayOfWeek)),
                  trailing: Text('${av[index].fromTime} - ${av[index].toTime}'),
                ),
              );
            }),
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                color: Colors.black,
              );
            },
            itemCount: av.length);
  }
}
