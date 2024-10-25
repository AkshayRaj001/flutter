import 'package:ecommerce/controller/checkout_provider.dart';
import 'package:ecommerce/pages/order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressBottomSheet extends StatefulWidget {
  @override
  _AddressBottomSheetState createState() => _AddressBottomSheetState();
}

class _AddressBottomSheetState extends State<AddressBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }

  void _submitAddress() async {
    if (_formKey.currentState!.validate()) {
      String address = _addressController.text;
      String latitude = _latitudeController.text;
      String longitude = _longitudeController.text;

      final checkOut = Provider.of<CheckoutProvider>(context, listen: false);
      await Provider.of<CheckoutProvider>(context, listen: false)
          .addCart(address: address);

      if (checkOut.message == 'Purchase completed successfully') {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Order()));
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(checkOut.message ?? 'somthing went wrong')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(checkOut.error ?? 'error')));
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _latitudeController,
                decoration: InputDecoration(
                  labelText: 'Latitude',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter latitude';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _longitudeController,
                decoration: InputDecoration(
                  labelText: 'Longitude',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter longitude';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitAddress,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
