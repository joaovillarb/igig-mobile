import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

String _htmlRecuperarSenha(){
  return "<p style='font-size: 16;'>Olá nome! "
      "<br>"
      " Clique no botão abaixo para gerar sua senha do portal IGIG - Plantões médicos.</p>"
      "\n\n";
}

enviarEmail(String destinatario) async {
  String username = 'joaovillar09@gmail.com';
  String password = '2xxdossuxx3';

  final smtpServer = gmail(username, password);

  // Create our message.
  final message = Message()
    ..from = Address(username, 'IGIG - Plantões médicos')
    ..recipients.add(destinatario)
  // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
  // ..bccRecipients.add(Address('bccAddress@example.com'))
    ..subject = 'IGIG:Recuperar senha'
    // ..text = 'This is the plain text.\nThis is line 2 of the text part.'
    ..html = _htmlRecuperarSenha();

  try {
    final sendReport = await send(message, smtpServer);
    print('Mensagem enviada: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Mensagem não enviada.');
    for (var p in e.problems) {
      print('Problema: ${p.code}: ${p.msg}');
    }
  }
}
