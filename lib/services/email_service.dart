import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailService {
  final String username = 'g0548457103@gmail.com';
  final String password = 'mjdr ibfp rojk icbz';

  Future<void> sendEmail(String email, String subject, String text) async {
    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'Coffee Shop')
      ..recipients.add(email)
      ..subject = subject
      ..text = text;

    try{
      await send(message, smtpServer);
    } on MailerException catch(e){
      for(var p in e.problems){
        print("Problem: ${p.code}: ${p.msg}");
      }
    }
  }

  Future<void> sendVerificationEmail(String email, String code) async{
    await sendEmail(email, "Verification Code", "Your Verification Code is $code");
  }

  Future<void> sendOrderEmail(String email, String orderDetails, String total) async {
    await sendEmail(email, 'Your Order Details', 'Order Details:\n$orderDetails\n\nTotal: \$$total');
  }

}