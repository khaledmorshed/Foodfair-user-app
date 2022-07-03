import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodfair/global/global_instance_or_variable.dart';
import 'package:foodfair/widgets/simple_appbar.dart';

import '../models/address_model.dart';
import '../widgets/my_text_field.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class SaveAddressScreen extends StatefulWidget {
  static const String path = "/SaveAddressScreen";

  @override
  State<SaveAddressScreen> createState() => _SaveAddressScreenState();
}

class _SaveAddressScreenState extends State<SaveAddressScreen> {
  final _name = TextEditingController();

  final _phoneNumber = TextEditingController();

  final _flatNumber = TextEditingController();

  final _city = TextEditingController();

  final _state = TextEditingController();

  final _completeAddress = TextEditingController();

  final _locationController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  List<Placemark>? placemarks;

  Position? position;

  getUserLocationAddress() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();

    Position newPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

        

    position = newPosition;

    placemarks =
        await placemarkFromCoordinates(position!.latitude, position!.longitude);
    //placemarks = await GeocodingPlatform.instance.placemarkFromCoordinates(position!.latitude, position!.longitude,localeIdentifier: "en");

    Placemark pMark = placemarks![0];

    String fullAddress =
        '${pMark.subThoroughfare} ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality}, ${pMark.subAdministrativeArea}, ${pMark.administrativeArea} ${pMark.postalCode}, ${pMark.country}';

    _locationController.text = fullAddress;

    _flatNumber.text =
        '${pMark.subThoroughfare} ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality}';
    _city.text =
        '${pMark.subAdministrativeArea}, ${pMark.administrativeArea} ${pMark.postalCode}';
    _state.text = '${pMark.country}';
    _completeAddress.text = fullAddress;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppbar(title: "foodfair",),
      floatingActionButton: SizedBox(
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width * 0.30,
        child: FloatingActionButton.extended(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final addressModel = AddressModel(
                name: _name.text.trim(),
                state: _state.text.trim(),
                fullAddress: _completeAddress.text.trim(),
                phoneNumber: _phoneNumber.text.trim(),
                flatNumber: _flatNumber.text.trim(),
                city: _city.text.trim(),
                latitude: position!.latitude,
                longitude: position!.longitude,
              ).toJson();

              FirebaseFirestore.instance
                  .collection("users")
                  .doc(sPref!.getString("uid"))
                  .collection("userAddress")
                  .doc(DateTime.now().millisecondsSinceEpoch.toString())
                  .set(addressModel)
                  .then((value) {
                Fluttertoast.showToast(msg: "New Address has been saved.");
                setState(() {
                   _formKey.currentState!.reset();
                   Navigator.pop(context);
                });
               
              });
            }
          },
          label: const Text("Done"),
          icon: const Icon(
            Icons.check,
            color: Colors.white,
          ),
          backgroundColor: Colors.purple[300],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            //side: const BorderSide(color: Colors.red),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 6,
            ),
            const Align(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "Save New Address:",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.person_pin_circle,
                color: Colors.black,
                size: 35,
              ),
              title: Container(
                width: 250,
                child: TextField(
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  controller: _locationController,
                  decoration: const InputDecoration(
                    hintText: "What's your address?",
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            ElevatedButton.icon(
              label: const Text(
                "Get my Location",
                style: TextStyle(color: Colors.white),
              ),
              icon: const Icon(
                Icons.location_on,
                color: Colors.white,
              ),
              style: ButtonStyle(
                //backgroundColor: ColorManager.amber1,
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(color: Colors.purple),
                  ),
                ),
              ),
              onPressed: () {
                //getCurrentLocationWithAddress
                getUserLocationAddress();
              },
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  MyTextField(
                    hint: "Name",
                    controller: _name,
                  ),
                  MyTextField(
                    hint: 'Phone Number',
                    controller: _phoneNumber,
                  ),
                  MyTextField(
                    hint: 'City',
                    controller: _city,
                  ),
                  MyTextField(
                    hint: 'State / Country',
                    controller: _state,
                  ),
                  MyTextField(
                    hint: 'Address Line',
                    controller: _flatNumber,
                  ),
                  MyTextField(
                    hint: 'Complete Address',
                    controller: _completeAddress,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
