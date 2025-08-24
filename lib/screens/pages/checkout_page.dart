// File: screens/pages/checkout_page.dart
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';
import 'package:trading_app/models/cart_manager.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({
    super.key,
    required List<Map<String, dynamic>> items,
    required double subtotal,
    required int shipping,
    required int tax,
    required double total,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int _selectedAddress = 0;
  int _selectedPayment = 0;

  List<Map<String, String>> _addresses = [
    {
      "title": "Home",
      "detail": "House 10, Road 5, Block 3, Baridhara,\nDhaka, 1212",
    },
    {
      "title": "Office",
      "detail": "Apartment B3, House 25, Road 10, Banani\nDhaka, 1213",
    },
  ];

  List<Map<String, String>> _payments = [
    {
      "brand": "Mastercard",
      "last4": "8940",
      "asset": "assets/images/mastercard.png",
    },
    {"brand": "Visa", "last4": "7206", "asset": "assets/images/visa.png"},
    {"brand": "Cash", "last4": "—", "asset": "assets/images/cash.png"},
  ];

  Color get _green => const Color(0xFF13A559);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _green,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text("Checkout"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          Icon(Icons.notifications_outlined, color: Colors.white),
          SizedBox(width: 12),
          Icon(Icons.more_vert, color: Colors.white),
          SizedBox(width: 8),
        ],
      ),
      body: Consumer<CartManager>(
        builder: (context, cart, _) {
          if (cart.items.isEmpty) {
            return const Center(
              child: Text("Your cart is empty", style: TextStyle(fontSize: 18)),
            );
          }

          final subtotal = cart.totalPrice;
          const shipping = 5.0;
          final tax = subtotal * 0.1;
          final total = subtotal + shipping + tax;

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionHeader(
                        "Delivery Address",
                        icon: Icons.location_on,
                        trailing: "Add New",
                        onTap: () => _addNewAddress(),
                      ),
                      const SizedBox(height: 12),
                      ...List.generate(
                        _addresses.length,
                        (i) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: _addressCard(
                            i,
                            _addresses[i]["title"]!,
                            _addresses[i]["detail"]!,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _sectionHeader(
                        "Payment Method",
                        icon: Icons.credit_card,
                        trailing: "Add New",
                        onTap: () => _addNewPayment(),
                      ),
                      const SizedBox(height: 12),
                      _paymentRow(),
                      const SizedBox(height: 20),
                      _sectionHeader("Order Summary", icon: Icons.receipt_long),
                      const SizedBox(height: 12),
                      _summaryRow("Subtotal", subtotal),
                      _summaryRow("Shipping", shipping),
                      _summaryRow("Tax", tax),
                      const Divider(),
                      _summaryRow("Total", total, bold: true),
                    ],
                  ),
                ),
              ),
              SafeArea(
                top: false,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.black.withOpacity(.05),
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Total Price",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              "\$${total.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: _green,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () =>
                            _showSuccessDialog(context, cart, total),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _green,
                          minimumSize: const Size(150, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Payment",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ===== UI COMPONENTS =====
  Widget _sectionHeader(
    String title, {
    required IconData icon,
    String? trailing,
    VoidCallback? onTap,
  }) {
    return Row(
      children: [
        Icon(icon, color: _green),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
        ),
        const Spacer(),
        if (trailing != null)
          InkWell(
            onTap: onTap,
            child: Text(
              trailing,
              style: TextStyle(color: _green, fontWeight: FontWeight.w700),
            ),
          ),
      ],
    );
  }

  Widget _addressCard(int idx, String title, String detail) {
    final selected = _selectedAddress == idx;
    return InkWell(
      onTap: () => setState(() => _selectedAddress = idx),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? _green : Colors.grey.shade300,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: selected ? _green : Colors.grey,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  Text(
                    detail,
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),
            Icon(Icons.edit_outlined, color: Colors.grey.shade500),
          ],
        ),
      ),
    );
  }

  Widget _paymentRow() {
    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _payments.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, i) {
          final p = _payments[i];
          final selected = _selectedPayment == i;
          return GestureDetector(
            onTap: () => setState(() => _selectedPayment = i),
            child: Container(
              width: 150,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: selected ? _green : Colors.grey.shade300,
                  width: selected ? 2 : 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 36,
                    width: 50,
                    decoration: BoxDecoration(
                      color: _green.withOpacity(.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(p["asset"]!, fit: BoxFit.contain),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    p["brand"]!,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  Text(
                    p["last4"] == "—"
                        ? "Cash on Delivery"
                        : "•••• ${p["last4"]}",
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _summaryRow(String label, double value, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: bold ? FontWeight.w800 : FontWeight.normal,
          ),
        ),
        Text(
          "\$${value.toStringAsFixed(2)}",
          style: TextStyle(
            fontWeight: bold ? FontWeight.w800 : FontWeight.normal,
            color: bold ? _green : Colors.black,
          ),
        ),
      ],
    );
  }

  // ===== Add New Address / Payment =====
  void _addNewAddress() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add New Address"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Enter address"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() {
                  _addresses.add({
                    "title": "Custom",
                    "detail": controller.text,
                  });
                });
              }
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void _addNewPayment() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add New Payment"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: "Enter card last 4 digits",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() {
                  _payments.add({
                    "brand": "Custom Card",
                    "last4": controller.text,
                    "asset": "assets/images/visa.png",
                  });
                });
              }
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  // ===== SUCCESS + PDF =====
  Future<void> _showSuccessDialog(
    BuildContext context,
    CartManager cart,
    double total,
  ) async {
    await showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: _green, size: 74),
              const Text(
                "Order Successful!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
              ElevatedButton(
                onPressed: () => _generatePdf(cart, total),
                child: const Text("Preview Invoice"),
              ),
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Go Back"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _generatePdf(CartManager cart, double total) async {
    final pdf = pw.Document();
    final itemsTable = cart.items
        .map(
          (e) => [
            e['name'],
            e['quantity'].toString(),
            '\$${(e['price'] as num).toStringAsFixed(2)}',
            '\$${((e['price'] as num) * (e['quantity'] as int)).toStringAsFixed(2)}',
          ],
        )
        .toList();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          pw.Header(
            level: 0,
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  "Beta Care Store",
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  "Invoice",
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          pw.Text("Billed To: John Doe, Dhaka, Bangladesh"),
          pw.SizedBox(height: 20),
          pw.Table.fromTextArray(
            headers: ["Product", "Qty", "Price", "Subtotal"],
            data: itemsTable,
            headerDecoration: pw.BoxDecoration(color: PdfColors.grey700),
            headerStyle: pw.TextStyle(
              color: PdfColors.white,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Column(
              children: [
                _totalLine("Subtotal", cart.totalPrice),
                _totalLine("Shipping", 5),
                _totalLine("Tax", cart.totalPrice * 0.1),
                _totalLine("Total", total, bold: true),
              ],
            ),
          ),
          pw.Divider(),
          pw.Center(child: pw.Text("Thank you for shopping with us!")),
        ],
      ),
    );

    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }

  pw.Widget _totalLine(String label, num value, {bool bold = false}) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(
            fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
          ),
        ),
        pw.Text(
          "\$${value.toStringAsFixed(2)}",
          style: pw.TextStyle(
            fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
