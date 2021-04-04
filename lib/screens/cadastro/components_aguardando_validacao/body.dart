import 'package:flutter/material.dart';
import 'package:igig/components/default_button.dart';
import 'package:igig/screens/login/login_screen.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 22, left: 22, right: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Cadastro finalizado com sucesso!",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    )
                ),
                Text(
                  "Tenha um bom dia!",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                SizedBox(height:10),
                Text(
                  "Seu acesso será liberado nas próximas 72 horas!",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 20,),
                Center(
                  child: Icon(
                    Icons.check_circle,
                    color: Color(0xFF00afd8),
                    size: 180.0,
                  ),
                ),
                SizedBox(height: 20),
                DefaultButton(
                  text: "Continuar",
                  press: (){
                    Navigator.pushReplacement(context,
                      MaterialPageRoute(
                        builder: (context)=> Login(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
