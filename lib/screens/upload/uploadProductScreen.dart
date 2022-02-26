import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stack/widgets/alerts/global_Dialog.dart';
import 'package:uuid/uuid.dart';

class UploadProductScreen extends StatefulWidget {
  static const routeName = '/upload-product';
  UploadProductScreen({Key? key}) : super(key: key);

  @override
  State<UploadProductScreen> createState() => _UploadProductScreenState();
}

class _UploadProductScreenState extends State<UploadProductScreen> {
  final _formKey = GlobalKey<FormState>();

  var _productTitle = '';

  var _productPrice = '';

  var _productCategory = '';

  var _productBrand = '';

  var _productDescription = '';

  var _productQuantity = '';

  final TextEditingController _categoryContrroller = TextEditingController();

  final TextEditingController _brandContrroller = TextEditingController();

  String? _categoryValue;

  String? _brandValue;

  String _url = '';

  bool _isLoading = false;

  GlobalMethods _globalMethods = GlobalMethods();

  var uuid = Uuid();

  File? _image;

//
  _showAlertDialog(BuildContext context, String title, String content) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        });
  }

//
  void _trySubmit() {
    final _isValid = _formKey.currentState!.validate();
    if (!_isValid) {
      _formKey.currentState!.save();
    }
  }

  //
  Future _getGellaryImage() async {
    if (await Permission.contacts.request().isGranted) {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      // Either the permission was already granted before or the user just granted it.
    }
// You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
    ].request();
// You can request multiple permissions at once.

    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
    });
  }

  //
  Future _getCameraImage() async {
    if (await Permission.contacts.request().isGranted) {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      // Either the permission was already granted before or the user just granted it.
    }
// You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
    ].request();
// You can request multiple permissions at once.

    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
    });
  }
  //

  void removeImage() {
    setState(() {
      _image = null;
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _image == null
                            ? Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 2, color: Colors.grey),
                                ),
                              )
                            : Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 2, color: Colors.grey),
                                ),
                                child: Image.file(
                                  _image!,
                                  fit: BoxFit.contain,
                                ),
                              ),
                      ),
                      Column(
                        children: [
                          TextButton.icon(
                            onPressed: _getCameraImage,
                            icon: const Icon(Icons.camera_alt),
                            label: Text('Camera'),
                          ),
                          TextButton.icon(
                            onPressed: _getGellaryImage,
                            icon: const Icon(Icons.image),
                            label: Text('Gallery'),
                          ),
                          TextButton.icon(
                            onPressed: removeImage,
                            icon: const Icon(Icons.remove_circle),
                            label: Text('Remove'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Flexible(
                        flex: 3,
                        child: TextFormField(
                          key: ValueKey('title'),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Please enter a title';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Title',
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onSaved: (val) {
                            _productTitle = val.toString();
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        flex: 1,
                        child: TextFormField(
                          key: ValueKey('price'),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Price is missing';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            // FilteringTextInputFormatter.allow(RegExp('r[0-9]')),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                            labelText: 'Price \$',
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: Icon(Icons.money_sharp),
                          ),
                          onSaved: (val) {
                            _productPrice = val.toString();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          key: ValueKey('category'),
                          controller: _categoryContrroller,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Please enter a caategory';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Add New Category',
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: Icon(Icons.money_sharp),
                          ),
                          onSaved: (val) {
                            _productCategory = val.toString();
                          },
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          //border of dropdown button
                          borderRadius: BorderRadius.circular(
                              5), //border raiuds of dropdown button
                        ),

                        //
                        child: DropdownButton<String>(
                          items: [
                            DropdownMenuItem<String>(
                              child: Text('Phones'),
                              value: 'Phones',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('Clothes'),
                              value: 'Clothes',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('Beauty & health'),
                              value: 'Beauty',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('Shoes'),
                              value: 'Shoes',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('Funiture'),
                              value: 'Funiture',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('Watches'),
                              value: 'Watches',
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _categoryValue = value.toString();
                              _categoryContrroller.text = value.toString();

                              print(_productCategory);
                            });
                          },
                          hint: Text('Select a Category'),
                          value: _categoryValue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 9),
                          child: Container(
                            child: TextFormField(
                              controller: _brandContrroller,

                              key: ValueKey('Brand'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Brand is missed';
                                }
                                return null;
                              },
                              //keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'Brand',
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                prefixIcon: Icon(Icons.money_sharp),
                              ),
                              onSaved: (value) {
                                _productBrand = value.toString();
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      DropdownButton<String>(
                        items: [
                          DropdownMenuItem<String>(
                            child: Text('Brandless'),
                            value: 'Brandless',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('Addidas'),
                            value: 'Addidas',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('Apple'),
                            value: 'Apple',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('Dell'),
                            value: 'Dell',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('H&M'),
                            value: 'H&M',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('Nike'),
                            value: 'Nike',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('Samsung'),
                            value: 'Samsung',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('Huawei'),
                            value: 'Huawei',
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _brandValue = value.toString();
                            _brandContrroller.text = value.toString();
                          });
                        },
                        hint: Text('Select a Brand'),
                        value: _brandValue,
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        //flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 9),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            key: ValueKey('Quantity'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Quantity is missed';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Quantity',
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              prefixIcon: Icon(Icons.money_sharp),
                            ),
                            onSaved: (value) {
                              _productQuantity = value.toString();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    key: ValueKey('Description'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'product description is required';
                      }
                      return null;
                    },
                    //controller: this._controller,
                    maxLines: 10,
                    textCapitalization: TextCapitalization.sentences,

                    decoration: InputDecoration(
                      labelText: 'Description',
                      hintText: 'Product description',
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onSaved: (value) {
                      _productDescription = value.toString();
                    },
                    onChanged: (text) {
                      // setState(() => charLength -= text.length);
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  //
                  InkWell(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      width: MediaQuery.of(context).size.width - 20,
                      height: 55,
                      child: Center(
                        child: Text(
                          'Submit Product',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
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
