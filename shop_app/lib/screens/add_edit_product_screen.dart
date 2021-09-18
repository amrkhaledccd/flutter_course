import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class AddEditProductScreen extends StatefulWidget {
  static final routeName = "/edit";

  @override
  _AddEditProductScreenState createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  final _imageUrlContrller = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var formData = ProductFormData(null, '', '', 0.0, '');
  var isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments;

      if (productId != null) {
        var product =
            Provider.of<Products>(context).findById(productId.toString());

        formData.id = product.id;
        formData.title = product.title;
        formData.price = product.price;
        formData.description = product.description;
        formData.imageUrl = product.imageUrl;
        _imageUrlContrller.text = product.imageUrl;
      }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlContrller.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    setState(() {});
  }

  void _saveForm() async {
    if (!_form.currentState!.validate()) {
      return;
    }
    _form.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    final products = Provider.of<Products>(context, listen: false);
    if (formData.id == null) {
      try {
        await products.addProduct(
          formData.title,
          formData.description,
          formData.price,
          formData.imageUrl,
        );
      } catch (e) {
        await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('error'),
                  content: Text('Something went wrong'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Text('Ok')),
                  ],
                ));
      } finally {
        print("this should execute after catching error");
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      }
    } else {
      products.editProduct(
        formData.id!,
        formData.title,
        formData.description,
        formData.price,
        formData.imageUrl,
      );
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(formData.id == null ? 'Add New Product' : 'Edit Product'),
          actions: [
            IconButton(
              onPressed: _saveForm,
              icon: Icon(Icons.save),
            )
          ],
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Form(
                key: _form,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        RoundTextField(
                          child: TextFormField(
                            initialValue: formData.title,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                            decoration: InputDecoration(
                              labelText: 'Title',
                              labelStyle: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                              icon: Icon(
                                Icons.title,
                                color: Theme.of(context).primaryColor,
                              ),
                              border: InputBorder.none,
                            ),
                            textInputAction: TextInputAction.next,
                            onSaved: (value) =>
                                formData.title = value.toString(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a title';
                              }
                              return null;
                            },
                          ),
                        ),
                        RoundTextField(
                          child: TextFormField(
                            initialValue: formData.price.toString(),
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                            decoration: InputDecoration(
                              labelText: 'Price',
                              labelStyle: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                              icon: Icon(
                                Icons.money,
                                color: Theme.of(context).primaryColor,
                              ),
                              border: InputBorder.none,
                            ),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            onSaved: (value) => formData.price = double.parse(
                              value.toString(),
                            ),
                            validator: (value) {
                              if (value == null ||
                                  double.tryParse(value) == null) {
                                return 'Please enter a valid number';
                              }
                              return null;
                            },
                          ),
                        ),
                        RoundTextField(
                          child: TextFormField(
                            initialValue: formData.description,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                            decoration: InputDecoration(
                              labelText: 'Description',
                              labelStyle: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                              icon: Icon(
                                Icons.description,
                                color: Theme.of(context).primaryColor,
                              ),
                              border: InputBorder.none,
                            ),
                            maxLines: 3,
                            keyboardType: TextInputType.multiline,
                            onSaved: (value) =>
                                formData.description = value.toString(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a description';
                              }

                              if (value.length < 10) {
                                return 'Description must be 10 or more characters';
                              }

                              return null;
                            },
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
                              decoration: BoxDecoration(
                                color: _imageUrlContrller.text.isNotEmpty
                                    ? Colors.transparent
                                    : Theme.of(context).primaryColorLight,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: _imageUrlContrller.text.isEmpty
                                  ? Center(
                                      child: Text(
                                        'Image preview',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                    )
                                  : FittedBox(
                                      fit: BoxFit.fitHeight,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Image.network(
                                          _imageUrlContrller.text,
                                        ),
                                      ),
                                    ),
                            ),
                            Expanded(
                              child: RoundTextField(
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                  decoration: InputDecoration(
                                    labelText: 'Image url',
                                    labelStyle: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    icon: Icon(
                                      Icons.image,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.url,
                                  controller: _imageUrlContrller,
                                  onEditingComplete: () {
                                    final urlPattern =
                                        r"(https?:\/\/.*\.(?:png|jpg))";
                                    if (new RegExp(urlPattern,
                                                caseSensitive: false)
                                            .firstMatch(_imageUrlContrller.text
                                                .toString()) ==
                                        null) {
                                      return;
                                    }
                                    setState(() {});
                                  },
                                  focusNode: _imageUrlFocusNode,
                                  onFieldSubmitted: (_) => _saveForm(),
                                  onSaved: (value) =>
                                      formData.imageUrl = value.toString(),
                                  validator: (value) {
                                    final urlPattern =
                                        r"(https?:\/\/.*\.(?:png|jpg|jpeg))";
                                    if (new RegExp(urlPattern,
                                                caseSensitive: false)
                                            .firstMatch(value.toString()) ==
                                        null) {
                                      return 'Please enter a valid URL';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            )
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

class RoundTextField extends StatelessWidget {
  final Widget child;

  RoundTextField({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Theme.of(context).primaryColorLight,
      ),
      child: child,
    );
  }
}

class ProductFormData {
  String? id;
  String title;
  String description;
  double price;
  String imageUrl;

  ProductFormData(
    this.id,
    this.title,
    this.description,
    this.price,
    this.imageUrl,
  );
}
