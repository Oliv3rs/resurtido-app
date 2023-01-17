import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:resurtido_mobo/screens/sku_page.dart';
import 'package:http/http.dart';

class QrCode extends StatefulWidget {
  @override
  _ScanPage createState() => _ScanPage();

  
}

// ignore: use_key_in_widget_constructors
class _ScanPage extends State<QrCode>{
  final _barcodeScan = TextEditingController();
  String scanned="";

  _scan() async{
     await FlutterBarcodeScanner.scanBarcode(
      "#d900ff", "Cancelar", true, ScanMode.BARCODE)
      .then(
            (value) => setState(
                (){
                _barcodeScan.text = value;
                scanned = value;
                } 
            )
        );
  }


  _searchSKU(barcodeSKU) {
    print("llegue a search");
    String codigo = barcodeSKU.trim();
    codigo.replaceAll(' ',''); 
    if (codigo != "") {
     print(codigo);
    }

    
    

  }
  @override
  Widget build(BuildContext context){

    void getInfoSKU(String SKU) async {
     Map datos = {
                    'SKU' : SKU
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
                  builder: (context) => SkuPage(
                    data: scanned,
                    product: product
                    )
                  ),
                );

                }
      
      }catch(e){

      print(e.toString());

    }
    }
  
  return Scaffold(
    body: 
    Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(scanned),
        TextField(
        controller: _barcodeScan,
        readOnly: true,
        autofocus: true,
        textAlign: TextAlign.center,    
        onChanged: (String value) {
           _searchSKU(value);
        } ,

        decoration: const InputDecoration(
          hintText: 'SKU Escaneado',
        ),    
       ),
       _espacio(),
      ElevatedButton.icon(
        style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 244, 77, 65)),
        label: const Text("Escanear SKU"),
        icon: const Icon(Icons.qr_code),
        onPressed: () => {
          _scan()
         }
        
      ),    
      _espacio(),
      ElevatedButton.icon(
        style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 65, 118, 253)),
        label: const Text("Validar SKU"),
        icon: const Icon(Icons.app_registration_sharp),
        onPressed: (() => {

          if (scanned.isEmpty || scanned.trim().isEmpty || scanned == ""){
                MotionToast.error(
                      title:  const Text("Error"),
                      description:  const Text("Debes escanear el producto"),
                      layoutOrientation: ToastOrientation.ltr,
                      animationType: AnimationType.fromLeft, width: 300,
                      position: MotionToastPosition.top,
                      displaySideBar: true,
                    ).show(context)
              }else{
                 getInfoSKU(scanned)
              }
         
        }),
      ),  
    ],),
  )
  );
  }

Widget _espacio(){
    return const SizedBox(
      height: 10.0,
    );
  }
              
}