import 'package:flutter/material.dart';
import 'package:foodfair/screens/user_home_screen.dart';
import 'package:foodfair/models/address_model.dart';
import '../global/color_manager.dart';

class ShipmentAddressWidget extends StatelessWidget {
  final AddressModel? addressModel;

  ShipmentAddressWidget({this.addressModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('Shipping Details:',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(
          height: 6.0,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 5),
          width: MediaQuery.of(context).size.width,
          //color: Colors.red,
          child: Table(
            //defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            //defaultColumnWidth: FixedColumnWidth(200),

            //it takes size depeneds on text length
            defaultColumnWidth: IntrinsicColumnWidth(),

            // columnWidths: {
            //   0: FixedColumnWidth(150.0), // fixed to 100 width
            //   1: FlexColumnWidth(),
            //   2: FixedColumnWidth(150.0), //fixed to 100 width
            // },
            children: [
              TableRow(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Name",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(addressModel!.name!),
                  ),
                ],
              ),
              TableRow(
                decoration: const BoxDecoration(
                    //color: Colors.green,
                    ),
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Phone Number",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(addressModel!.phoneNumber!),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            addressModel!.fullAddress!,
            textAlign: TextAlign.justify,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: ElevatedButton(
            child: const Text(
              "Go back",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.purple[300],
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: ColorManager.depOrange1),
              ),
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => UserHomeScreen()));
            },
          ),
        ),
      ],
    );
  }
}
