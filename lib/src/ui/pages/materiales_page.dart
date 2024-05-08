import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:itca_construction/src/providers/price_provider.dart';
import 'package:itca_construction/src/ui/widgets/action_button.dart';
import 'package:itca_construction/src/ui/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class MaterialesPage extends StatefulWidget {
  const MaterialesPage({super.key});

  @override
  State<MaterialesPage> createState() => _MaterialesPageState();
}

class _MaterialesPageState extends State<MaterialesPage> {
  final priceProvider = PriceProvider.instance;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final prices = priceProvider.getPrices();
    return ChangeNotifierProvider.value(
        value: priceProvider,
        child: Builder(builder: (context) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Materiales'),
              ),
              body: Form(
                key: _formKey,
                child: SafeArea(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemBuilder: (context, index) {
                            final price = prices[index];
                            return _item(context, index, price);
                          },
                          itemCount: prices.length,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                        child: ActionButton(
                          onPressed: _savePrices,
                          child: const Text('Guardar Precios'),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        }));
  }

  void _savePrices() {
    if (_formKey.currentState!.validate()) {
      priceProvider.savePrices();

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Precios guardados'),
        ),
      );
    }
  }

  Widget? _item(
      BuildContext context, int index, Tuple2<Decimal, PriceItem> price) {
    final controller = priceProvider.getController(price);
    return TextFieldWidget(
      label: getItemName(price.item2),
      controller: controller,
      requiredField: true,
      suffixWidget: const Text("\$"),
    );
  }
}
