import 'package:flutter/material.dart';

class AddEditProductScreen extends StatefulWidget {
  static final routeName = "/edit";

  @override
  _AddEditProductScreenState createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  final _imageUrlContrller = TextEditingController();

  @override
  void dispose() {
    _imageUrlContrller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add/Edit Product'),
        ),
        body: Form(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Title',
                      icon: Icon(Icons.title),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Price',
                      icon: Icon(Icons.money),
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Description',
                      icon: Icon(Icons.description),
                    ),
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: _imageUrlContrller.text.isEmpty
                            ? Center(
                                child: Text(
                                  'Image preview',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              )
                            : FittedBox(
                                fit: BoxFit.cover,
                                child: Image.network(_imageUrlContrller.text),
                              ),
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration:
                              InputDecoration(labelText: 'Enter iamge url'),
                          keyboardType: TextInputType.url,
                          controller: _imageUrlContrller,
                          onEditingComplete: () {
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
