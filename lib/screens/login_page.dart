import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:resurtido_mobo/screens/tab_pages.dart';
import 'package:http/http.dart';


class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);
  @override
  State<MyStatefulWidget> createState() => _LoginPage();
  
}

class _LoginPage extends State<MyStatefulWidget>{
   TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

    login(String email , password) async {
     Map datos = {
                    'usuario' : email,
                    'password' : password
                 };
                  var body = json.encode(datos);

    try{
          Response response = await post(
                  Uri.parse('http://mobonet.mx/API2/APIMOBO.php?F=R_LoginUsuario'),
                  headers: {"Content-Type": "application/json"},
                  body: body
                );

      if(response.statusCode == 200){
        
        var res = response.body;
        Map<String, dynamic> temp = json.decode(res);

        if ( temp['code']== 401){
          print('login fallido');
           // ignore: use_build_context_synchronously
           _buildAlertDialog(context);

        }else{
            var datos =  temp['data'];
  
            print(datos['nombre_completo']);
            String nombre = datos['nombre_completo'];
            print('logueado');


            // ignore: use_build_context_synchronously
            Navigator.push(context,
            MaterialPageRoute(
              builder: (BuildContext context) => 
               TabBarPrincipal(
                  data: nombre
              )
            )
          );
        }
      }else {
        print('API Request Fallido');
      }
    }catch(e){
      print(e.toString());
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Colors.black,
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            
            children: [
            // ignore: prefer_const_constructors
                _titulo(),
                _espacio(),
                _textFieldEmail(),
                _espacio(),
                _textFieldPass(),
                _espacio(),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Acceder'),
                  onPressed: () {
                    login(emailController.text.toString(), passwordController.text.toString());
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TabBarPrincipal()),
                    );*/
                  },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black
                ),
                )
            ),
      
        ], //body
        ),
        ),
      ),
    );
  }
  

  Widget _titulo (){
    return const Text(
      "MOBO",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black,
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _espacio(){
    return const SizedBox(
      height: 10.0,
    );
  }
              
  Widget _textFieldEmail () {
    return  TextField(
      autofocus: true,
      decoration: const InputDecoration(
        labelText: 'Usuario',
        border: OutlineInputBorder(

        ),
        hintText: 'Usuario',
        icon: Icon(Icons.person)
      ),
      keyboardType: TextInputType.emailAddress,
      textAlign: TextAlign.center ,
      style: const TextStyle(
        color: Colors.black
      ),
      controller: emailController,
    );
  }

  Widget _textFieldPass( ) {
    return  TextField(
      
      controller: passwordController,
      decoration: const InputDecoration(
        labelText: 'Contraseña',      
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black)
        ),
        hintText: 'Contraseña',
        icon: Icon(Icons.enhanced_encryption),
      ),
      textAlign: TextAlign.center,
      obscureText: true,
    style: const TextStyle(
      color: Colors.black
    ),
    
    );
  }

 Future _buildAlertDialog(BuildContext context){
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return  AlertDialog(
        title: const Text('Error'),
        content: const Text('Usuario o password incorrectos'),
        actions: <Widget>[
        TextButton(
          child: const Text('Ok'),
        onPressed: (){
          Navigator.of(context).pop(); 
        }, 
      ),
    ],
  );
    },
  );
 }
  
  
}


