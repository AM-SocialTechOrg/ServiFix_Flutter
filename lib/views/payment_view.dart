import 'package:flutter/material.dart';
import 'package:servifix_flutter/api/service/paymentService.dart';

class PaymentScreen extends StatefulWidget {
  final double amount;

  const PaymentScreen({Key? key, required this.amount}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  final PaymentService _paymentService = PaymentService();

  String? _selectedPaymentType;
  final List<Map<String, dynamic>> _paymentTypes = [
    {'label': 'Visa', 'value': 'visa', 'icon': 'assets/visa.png'},
    {'label': 'Mastercard', 'value': 'mastercard', 'icon': 'assets/mastercard.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Realizar Pago'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Monto: ${widget.amount}', style: TextStyle(fontSize: 18)),
            DropdownButtonFormField<String>(
              value: _selectedPaymentType,
              items: _paymentTypes.map((paymentType) {
                return DropdownMenuItem<String>(
                  value: paymentType['value'],
                  child: Row(
                    children: [
                      Image.asset(paymentType['icon'], width: 24, height: 24),
                      SizedBox(width: 10),
                      Text(paymentType['label']),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPaymentType = value;
                });
              },
              decoration: InputDecoration(labelText: 'Tipo de Pago'),
            ),
            TextField(
              controller: _cardNumberController,
              decoration: InputDecoration(labelText: 'Número de Tarjeta'),
              keyboardType: TextInputType.number,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _expiryDateController,
                    decoration: InputDecoration(labelText: 'Fecha de Vencimiento (MM/AA)'),
                    keyboardType: TextInputType.datetime,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _cvvController,
                    decoration: InputDecoration(labelText: 'CVV'),
                    keyboardType: TextInputType.number,
                    obscureText: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implementar la lógica de envío de pago aquí
              },
              child: Text('Enviar Pago'),
            ),
          ],
        ),
      ),
    );
  }
}
