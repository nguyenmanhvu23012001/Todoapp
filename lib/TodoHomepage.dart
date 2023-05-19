import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'model/items.dart';
import 'model_bottom.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<DataItems> items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items.add(DataItems(id: "1", name: "Chơi game"));
    items.add(DataItems(id: "2", name: "Nghe nhạc"));
    items.add(DataItems(id: "3", name: "Chơi tennis"));
    items.add(DataItems(id: "4", name: "Học"));
    items.add(DataItems(id: "5", name: "Đạp xe"));
    items.add(DataItems(id: "6", name: "Chơi thể thao"));
    items.add(DataItems(id: "7", name: "Xem phim"));
    items.add(DataItems(id: "8", name: "Đọc báo"));
  }



  void _handleDeleteTask(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(

          content: Text('Do you want to delete this item?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại
                setState(() {
                  items.removeWhere((item) => item.id == id);
                });
                Fluttertoast.showToast(
                  msg: 'Deleted',
                  backgroundColor: Colors.grey,
                  textColor: Colors.white,
                );
              },
              child: Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }//Xóa

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Todo App'),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Xử lý khi nhấn nút menu
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
              children: items.map((item) => _BuildCenter(
                index : items.indexOf(item),
                item: item,
                handleDeleteTask:_handleDeleteTask ,)).toList()),
        ),
        floatingActionButton: _buildfloatButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  Widget _buildfloatButton() {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            isScrollControlled: true, //Quay ngang màn vẫn đẹp
            context: context,
            builder: (context) => ModalBottom(
                  functionCallBack: (DataItems newItem) {
                    setState(() {
                      items.add(newItem); //insert
                    });
                  },
                ));
      },
      child: Icon(Icons.add),
    );
  }
}

class _BuildCenter extends StatelessWidget {
  var index;
  var item;
  final Function handleDeleteTask;//khai báo biến
  _BuildCenter({
    super.key,
    required this.item, required this.handleDeleteTask,required this.index//Constructor.
  });



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: EdgeInsets.only(bottom: 24),
      color: (index %2==0)
      ? Color.fromARGB(255, 128, 128, 128) // Tạo màu đỏ (#FF0000)
      :  Color.fromARGB(255, 216, 216, 216),
      // Tạo màu xanh lá cây (#00FF00)
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            item.name,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: () {
             handleDeleteTask(item.id);//Xóa
            },
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
class _buildCenter extends StatelessWidget {
  _buildCenter({
    Key? key,
    required this.item,
    required this.handleDeleteTask,
  }) : super(key: key);

  final DataItems item;
  final Function(String) handleDeleteTask;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: EdgeInsets.only(bottom: 24),
      color: Colors.grey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Vu',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
