import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../session/singleton.dart';
import '../widgets/dialog.dart';
import 'package:flutter/services.dart';
import '../api/CheckoutAPI.dart';
import 'package:email_validator/email_validator.dart';
import 'package:intl/intl.dart';
class CheckoutState extends StatefulWidget {
  int total = 0;
  CheckoutState(int total){
    this.total = total;
  }

  @override
  Checkout createState() => Checkout(total);
}
class Shipper{
  String shipperid;
  String company_name;
  Shipper(String id, String name){
    this.shipperid = id;
    this.company_name = name;
  }
}
class Checkout extends State<CheckoutState> {
  final formatCurrency = new NumberFormat.simpleCurrency(locale: "ID",name: "Rp ");
  List<Shipper> Shippers = List<Shipper>();
  final name = TextEditingController();
  final emailField = TextEditingController();
  final receiverAddress = TextEditingController();
  final description = TextEditingController();
  final zipcode = TextEditingController();
  final city = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String selectedindex;
  Shipper selectedshipper;
  Dialogs d = new Dialogs();
  CheckoutAPI api = CheckoutAPI(session.getuID);
  int total = 0;
  Checkout(int total){
    this.total=  total;
    this.name.text =(session.getUsername??null);
    this.emailField.text = (session.getEmail??null);
    this.receiverAddress.text = (session.getAddress??null);
    this.city.text = (session.getCity??null);
    this.zipcode.text = (session.getPostcode??null);
    loadshippers();

  }
  loadshippers()
  {
    api.getShippers().then((value){
      var data = value['data'] as List;
      for(int i=0; i<data.length;i++)
        {
          setState((){
            Shippers.add(new Shipper(data[i]['Shipper_ID'], data[i]['Company_name']));

          });
        }
      selectedshipper =Shippers[0];
    });


  }
  int radiovalue = 0;
  onChangeradio(int value){
    setState(() {
      print(value);
      radiovalue= value;
    });
  }
  emailValidator(String value) {
    String email = value;
    final bool isValid = EmailValidator.validate(email);
    if (isValid) {
      return null;
    } else {
      return 'Enter a valid email';
    }
  }
  Widget build(context) {
    return Scaffold(
      body: buildList(context),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Checkout'),
      ),
    );
  }
  Widget buildList(BuildContext context) {
    return ScopedModel<UserModel>(
      model: session,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(padding: EdgeInsets.only(top:5.0),child:Text("Total\n"+formatCurrency.format(total).toString(),textScaleFactor: 1.2,textAlign: TextAlign.center,)),
              TextFormField(
                decoration: InputDecoration(hintText: 'Email'),
                controller: emailField,
                validator: (val) => emailValidator(val),
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Receiver name'),
                controller: name,
                validator: (val) => emptyvalidator(val),
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Shipment Address'),

                controller: receiverAddress,
                validator: (val) => emptyvalidator(val),
              ),

              TextFormField(
                decoration: InputDecoration(hintText: 'City'),

                controller: city,
                validator: (val) => emptyvalidator(val),
              ),
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                  hintText: 'zipcode',
                ),
                inputFormatters:[WhitelistingTextInputFormatter.digitsOnly],
                controller: zipcode,
                validator: (val) => emptyvalidator(val),
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Description'),
                obscureText: false,
                controller: description,
                 validator: (val) => emptyvalidator(val),
              ),
              Row(
                children: <Widget>[
                  Text("Select Shipper :"),
                  SizedBox(width: 10.0,),
                  Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: Colors.white,
                    ),
                    child: DropdownButton<Shipper>(
                        hint: Text('Select One'),
                        value: selectedshipper,
                        items: Shippers.map((value) {
                          return DropdownMenuItem<Shipper>(

                            value: value,
                            child: Text(value.company_name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedshipper = value;
                          });

                        }),
                  ),

                ],
              ),



              SizedBox(
                height: 20.0,
              ),
              Center(
                child: Buttonregister(context),
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget Buttonregister (BuildContext context){
    return
      ButtonTheme(
        minWidth: 120.0,
        height: 45.0,
        child: RaisedButton(
          color: Colors.black,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0)),
          elevation: 5.0,
          child: Text(
            'Checkout',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: (){

            submitCheckout(context);
          },
        ),
      );
  }
  emptyvalidator(String val){
    if(val.length<1)
      {
        return "Field required";
      }
  }
  void submitCheckout(BuildContext context) {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      api.sendCheckout(session.getuID, selectedshipper.shipperid, this.total.toString(), name.text, receiverAddress.text, emailField.text, description.text, zipcode.text, city.text).then((value){

        if(value['exit']==false)
        {
          Navigator.of(context).pop();
          d.information(context, "info","Order made, Please check your transaction menu");
        }

      }).catchError((error){

      });
      //register(usernameField.text, passwordField.text, emailField.text);
    }
  }

}


