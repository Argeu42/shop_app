import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/models/product_list.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _formData = <String, Object>{};

  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.dispose();
    _imageUrlController.removeListener(updateImage);
  }

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final argument = ModalRoute.of(context)?.settings.arguments;
      if (argument != null) {
        final product = argument as Product;
        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['price'] = product.price;
        _formData['description'] = product.description;
        _formData['imageUrl'] = product.imageUrl;

        _imageUrlController.text = product.imageUrl;
      }
    }
  }

  void updateImage() {
    setState(() {});
  }

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFile =
        url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg') ||
        url.toLowerCase().endsWith('pt-br');
    return isValidUrl && endsWithFile;
  }

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    setState(() => _isLoading = true);
    try {
      await Provider.of<ProductList>(
        context,
        listen: false,
      ).saveProduct(_formData);
      Navigator.of(context).pop();
    } catch (onError) {
      await showDialog<void>(
        context: context, 
        builder: (ctx) => AlertDialog(
          title: Text("Ocorreu um erro!"),
          content: Text('Ocorreu um erro para salvar o produto.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), 
              child: Text('Ok')
            ),
          ],
        )
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Produto'),
        actions: [IconButton(onPressed: _submitForm, icon: Icon(Icons.save))],
      ),
      body:
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        initialValue: _formData['name']?.toString(),
                        decoration: InputDecoration(labelText: 'Nome'),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_priceFocus);
                        },
                        onSaved: (newValue) {
                          _formData['name'] = newValue ?? '';
                        },
                        validator: (value) {
                          final trueValue = value ?? '';

                          if (trueValue.trim().isEmpty) {
                            return 'Nome é obrigatório.';
                          } else if (trueValue.trim().length < 5) {
                            return 'Nome precisa ter mais de 5 letras.';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _formData['price']?.toString(),
                        decoration: InputDecoration(labelText: 'Preço'),
                        textInputAction: TextInputAction.next,
                        focusNode: _priceFocus,
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        onFieldSubmitted: (_) {
                          FocusScope.of(
                            context,
                          ).requestFocus(_descriptionFocus);
                        },
                        onSaved: (newValue) {
                          _formData['price'] = double.parse(newValue ?? '0');
                        },
                        validator: (value) {
                          final trueValue = value ?? '0';
                          if (trueValue.trim().isEmpty) {
                            return 'Preço é obrigatório.';
                          }
                          final double doubleValue;
                          try {
                            doubleValue = double.parse(trueValue);
                          } catch (e) {
                            return 'Informe um preço válido!';
                          }
                          if (doubleValue <= 0) {
                            return 'Informe um preço válido!';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _formData['description']?.toString(),
                        decoration: InputDecoration(labelText: 'Descrição'),
                        focusNode: _descriptionFocus,
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        onSaved: (newValue) {
                          _formData['description'] = newValue ?? '';
                        },
                        validator: (value) {
                          final trueValue = value ?? '';

                          if (trueValue.trim().isEmpty) {
                            return 'Descrição é obrigatório.';
                          } else if (trueValue.trim().length < 10) {
                            return 'Descrição precisa ter mais de 10 letras.';
                          }
                          return null;
                        },
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Url da Imagem',
                              ),
                              focusNode: _imageUrlFocus,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.url,
                              controller: _imageUrlController,
                              onFieldSubmitted: (_) => _submitForm(),
                              onSaved: (newValue) {
                                _formData['imageUrl'] = newValue ?? '';
                              },
                              validator: (value) {
                                final trueValue = value ?? '';
                                if (!isValidImageUrl(trueValue)) {
                                  return 'Informe uma Url válida!';
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            height: 100,
                            width: 100,
                            margin: const EdgeInsets.only(top: 10, left: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            alignment: Alignment.center,
                            child:
                                _imageUrlController.text.isEmpty
                                    ? Text('Informe a Url')
                                    : Image.network(_imageUrlController.text),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}
