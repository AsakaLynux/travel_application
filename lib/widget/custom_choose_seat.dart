import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/seat_provider.dart';
import '../shared/theme.dart';

class CustomChooseSeat extends StatefulWidget {
  final int seatId;
  final String seat;

  const CustomChooseSeat({super.key, required this.seatId, required this.seat});

  @override
  State<CustomChooseSeat> createState() => _CustomChooseSeatState();
}

class _CustomChooseSeatState extends State<CustomChooseSeat> {
  bool selected = false;
  void selectSeat(String seatNumber) {
    setState(() {
      if (selected) {
        Provider.of<SeatProvider>(context, listen: false)
            .removeSeatNumber(seatNumber);
        selected = false;
      } else {
        Provider.of<SeatProvider>(context, listen: false)
            .addSeatNumber(seatNumber);
        selected = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget seatSelected() {
      return GestureDetector(
        onTap: () {
          selectSeat(widget.seat);
        },
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(defaultRadius),
            border: Border.all(
              color: kPrimaryColor,
              width: 2,
              style: BorderStyle.solid,
            ),
          ),
          child: Center(
            child: Text(
              "YOU",
              style: whiteTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
          ),
        ),
      );
    }

    Widget seatAvailable() {
      return GestureDetector(
        onTap: () {
          selectSeat(widget.seat);
        },
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: kAvailableColor,
            borderRadius: BorderRadius.circular(defaultRadius),
            border: Border.all(
              color: kPrimaryColor,
              width: 2,
              style: BorderStyle.solid,
            ),
          ),
        ),
      );
    }

    Widget seatUnavailable() {
      return Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: kUnavailableColor,
          borderRadius: BorderRadius.circular(defaultRadius),
          border: Border.all(
            color: kUnavailableColor,
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
      );
    }

    Widget seatEmpty() {
      return const SizedBox(
        width: 48,
        height: 48,
      );
    }

    switch (widget.seatId) {
      case 0:
        return seatUnavailable();
      case 1:
        return selected ? seatSelected() : seatAvailable();
      case 2:
        return seatEmpty();
      case 3:
        return seatSelected();
      default:
        return const SizedBox();
    }
  }
}
