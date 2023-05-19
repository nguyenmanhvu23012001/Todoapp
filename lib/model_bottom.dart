import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/model/items.dart';

class ModalBottom extends StatelessWidget {
    final functionCallBack;
    ModalBottom({
    super.key, this.functionCallBack,
  });

TextEditingController controller = TextEditingController();
    void _hand(BuildContext context){
      final newItem = DataItems(id: DateTime.now().toString(), name: controller.text);
      final name=controller.text;
      if(name.isEmpty){
        return;//Nếu không nhập nội dung ô Text sẽ không hiện thị
      }
      functionCallBack(newItem);
      Navigator.pop(context);
//INsert
}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,// cho code phù hợp với man hinh
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            TextField(
              controller:controller,
              decoration:
              InputDecoration(
                border: OutlineInputBorder(),
                labelText: ('Your task'),
              ),
            ),
            SizedBox(height: 20,),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed:()=>
                    _hand(context),
                child: Text('Add task'),
              ),
            )

          ],
        ),
      ),
    );
  }
}
