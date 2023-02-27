import 'package:flutter/material.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.dispose();
    _imageUrlFocus.removeListener(_updateImageUrl);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imageUrlFocus.addListener(_updateImageUrl);
  }

  void _updateImageUrl() {
    if (!_imageUrlFocus.hasFocus) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Produto'),
      ),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Nome'),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_priceFocus);
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Preço'),
              textInputAction: TextInputAction.next,
              focusNode: _priceFocus,
              keyboardType: TextInputType.numberWithOptions(
                decimal: true,
              ),
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_descriptionFocus);
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Descrição'),
              focusNode: _descriptionFocus,
              keyboardType: TextInputType.multiline,
              maxLines: 3,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'URL da Imagem'),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.url,
                    focusNode: _imageUrlFocus,
                    controller: _imageUrlController,
                  ),
                ),
                Container(
                  height: 100,
                  width: 100,
                  margin: const EdgeInsets.only(top: 10, left: 10),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1, color: Colors.grey),
                      left: BorderSide(width: 1, color: Colors.grey),
                      right: BorderSide(width: 1, color: Colors.grey),
                      bottom: BorderSide(width: 1, color: Colors.grey),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: _imageUrlController.text.isEmpty ? Text('Informe a URL') : FittedBox(
                    child: Image.network(
                      _imageUrlController.text,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}
