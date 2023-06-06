import 'package:flutter/material.dart';

import '../../data/themes.dart';

class AddMinusButton extends StatefulWidget {
  final void Function()? onPressedMinus;
  final void Function()? onPressedMore;
  final int quantity;
  const AddMinusButton(
      {super.key,
      this.onPressedMinus,
      this.onPressedMore,
      required this.quantity});

  @override
  State<AddMinusButton> createState() => _AddMinusButtonState();
}

class _AddMinusButtonState extends State<AddMinusButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 66,
        height: 25,
        child: Stack(children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: GestureDetector(
                  onTap: widget.onPressedMinus,
                  child: SizedBox(
                      width: 25,
                      height: 25,
                      child: Stack(children: <Widget>[
                        Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: kGrey200,
                                  border: Border.all(
                                    color: kGrey400,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.elliptical(25, 25)),
                                ))),
                        const Positioned(
                            top: 6,
                            left: 6,
                            child: Icon(
                              Icons.remove,
                              size: 13,
                            ))
                      ])))),
          Positioned(
              top: 0,
              left: 29,
              child: Text(
                widget.quantity.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: kGrey800,
                    fontSize: 14,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1.7142857142857142),
              )),
          Positioned(
              top: 0,
              left: 41,
              child: GestureDetector(
                  onTap: widget.onPressedMore,
                  child: SizedBox(
                      width: 25,
                      height: 25,
                      child: Stack(children: <Widget>[
                        Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: kGrey200,
                                  border: Border.all(
                                    color: kGrey400,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.elliptical(25, 25)),
                                ))),
                        const Positioned(
                            top: 6,
                            left: 6,
                            child: Icon(
                              Icons.add,
                              size: 13,
                            )),
                      ])))),
        ]));
  }
}

/*   return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.grey.shade400,
              width: 1,
            ),
          ),
          child: IconButton(
            icon: const Icon(Icons.remove),
            onPressed: widget.onPressedMinus,
          ),
        ),
        const Text(
          ' 1 ',
          style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
        ),
        Center(
            child: Stack(children: [
          Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.grey.shade400,
                width: 1,
              ),
            ),
          ),
          
        ]))
      ],
    );
  */

