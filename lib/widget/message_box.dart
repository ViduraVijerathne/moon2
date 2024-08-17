import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:moon2/constant/app_font.dart';
import 'package:moon2/widget/my_button.dart';

Future<void> showMessageBox(BuildContext context,String title,String message,MessageboxType type)async{
  await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => MessageBox(title: title,message: message,type: type,),
  );
}

class MessageBox extends StatelessWidget {
  final String title;
  final MessageboxType type;
  final String message;
  const MessageBox({super.key, required this.title, required this.type, required this.message});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      child: BlurryContainer(
        child: Center(
          child: BlurryContainer(
            padding: EdgeInsets.all(10),
            color: Colors.white.withOpacity(0.5),
            elevation: 0,
            blur: 20,
            child:ListTile(
              leading: type == MessageboxType.success ? Icon(Ionicons.checkmark_done_sharp,size: 40,color: Colors.green,):
              type == MessageboxType.error ? Icon(Icons.error,size: 40,color: Colors.red,):
              Icon(Icons.info,size: 40,color: Colors.blue,),
              title: Text(title,style: appFont(fontSize: 25,fontWeight: FontWeight.w900),),
              subtitle: ListTile(
                title: Text(message,style: appFont(fontWeight: FontWeight.w700),),
                subtitle: SizedBox(
                  child: MyButton(title: "OK",callback: () {
                    Navigator.of(context).pop();
                  },),
                ),
              ),
            )
          ),
        ),
      ),
    );
  }
}

enum MessageboxType{
  success,
  error,
  info,
}