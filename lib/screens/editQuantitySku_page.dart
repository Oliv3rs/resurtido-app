import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'home_page.dart';

 // ignore: camel_case_types
 class editQuantitySku extends StatelessWidget {
  final  id;
  
  editQuantitySku({super.key, this.id});
  TextEditingController skuQuantity = TextEditingController();
 


  @override
  Widget build(BuildContext context) {
    updateSKUQuantity(idSKU,skuQuantity) async {
      print(idSKU);
      print(skuQuantity);
       Map datos = {
                    'ID' : idSKU
                 };
        var body = json.encode(datos);

    try{
          Response response = await post(
                  Uri.parse('http://192.168.10.120:3002/ResurtidoApp/getSKUinfo'),
                  headers: {"Content-Type": "application/json"},
                  body: body
                );
                if(response.statusCode == 200){
        
                  var res = response.body;
                  print(res);
                var dataSKU = [];
                dataSKU = json.decode(res);

                String product = dataSKU[0]['Nombre_producto'];
                  // ignore: use_build_context_synchronously
                Navigator.push(
                  context,
                MaterialPageRoute(
                  builder: (context) => Home(

                    )
                  ),
                );

                }
      
      }catch(e){

      print(e.toString());

    }

    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar cantidad SKU'),
        backgroundColor: const Color.fromARGB(255, 4, 51, 255),
      ),
      body: Container(
        padding: const EdgeInsets.all(12.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
           TextField(
            controller: skuQuantity,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color.fromARGB(255, 242, 40, 102),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
            decoration: const InputDecoration(
              labelText: "Actualizar número de piezas:"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
              
            ],
            
           ),
           _espacio(),
           _espacio(),
           MaterialButton(
            minWidth: 200.0,
            height: 60.0,
            color: Color.fromARGB(255, 4, 51, 255),
            child: const Text('Actualizar', style: TextStyle(color: Colors.white),),
            onPressed: (){
              var idSKU = id  ;
              var quantitySKU = skuQuantity.text.toString();
              if (quantitySKU.isEmpty || quantitySKU.trim().isEmpty || quantitySKU == ""){
                MotionToast.error(
                      title:  const Text("Error"),
                      description:  const Text("Debes llenar el campo"),
                      layoutOrientation: ToastOrientation.ltr,
                      animationType: AnimationType.fromLeft, width: 400,
                      position: MotionToastPosition.top,
                      displaySideBar: true,
                    ).show(context);
              }else{
                 updateSKUQuantity(idSKU,skuQuantity.text.toString());
              }
             
           })
        ],
        ),
      )
    );
  }
   Widget _espacio(){
    return const SizedBox(
      height: 10.0,
    );
  }
              
}