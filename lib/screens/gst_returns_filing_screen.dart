import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_layout.dart';
import '../widgets/gst_form_fields.dart';

class GstReturnsFilingScreen extends StatefulWidget {
  const GstReturnsFilingScreen({super.key});

  @override
  State<GstReturnsFilingScreen> createState() => _GstReturnsFilingScreenState();
}

class _GstReturnsFilingScreenState extends State<GstReturnsFilingScreen> {
  int _selectedNavIndex = 11;
  final _formKey = GlobalKey<FormState>();

  final _clientNameCtrl = TextEditingController();
  final _businessNameCtrl = TextEditingController();
  final _gstinCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

  String? _returnType;
  String? _filingMonth;
  String? _filingYear;

  String? _errReturnType;
  String? _errFilingPeriod;

  String? _salesFile;
  String? _purchaseFile;
  String? _debitCreditFile;
  String? _paymentChallansFile;
  String? _priorPeriodFile;

  @override
  void dispose() {
    _clientNameCtrl.dispose();
    _businessNameCtrl.dispose();
    _gstinCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  bool validateEmail(String? v) => v != null && RegExp(r'^[\w\.\-]+@[\w\-]+\.\w{2,}$').hasMatch(v);
  bool validatePhone(String? v) => v != null && RegExp(r'^\d{10}$').hasMatch(v);

  void _submit() {
    setState(() {
      _errReturnType = _returnType == null ? 'Please select a return type' : null;
      _errFilingPeriod = (_filingMonth == null || _filingYear == null) ? 'Please select filing period' : null;
    });
    if (!_formKey.currentState!.validate()) return;
    if (_errReturnType != null || _errFilingPeriod != null) return;
    if (_salesFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sales / Turnover Details is required')),
      );
      return;
    }
    showGstSuccessDialog(context, 'GST Returns Filing');
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      activeNavIndex: _selectedNavIndex,
      onNavChanged: (i) => setState(() => _selectedNavIndex = i),
      showBackButton: true,
      child: _selectedNavIndex == 11 ? _buildForm() : const Center(
        child: Text('Not built yet', style: TextStyle(fontSize: 18, color: AppColors.textMuted)),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GstBreadcrumb(path: 'GST Services > GST Returns Filing'),
          const SizedBox(height: 4),
          const GstFormTitle(title: 'GST Returns Filing'),
          const SizedBox(height: 24),
          GstFormCard(title: 'Client Information', icon: Icons.person, child: _buildClientInfo()),
          const SizedBox(height: 16),
          GstFormCard(title: 'Return Details', icon: Icons.calendar_today, child: _buildReturnDetails()),
          const SizedBox(height: 16),
          GstFormCard(title: 'Documents', icon: Icons.folder, child: _buildDocuments()),
          const SizedBox(height: 24),
          GstSubmitButton(onPressed: _submit),
        ],
      ),
    );
  }

  Widget _buildClientInfo() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstTextField(
              label: 'Client Name', hint: 'Full name of the client', icon: Icons.person, required: true,
              controller: _clientNameCtrl,
              validator: (v) => v == null || v.trim().length < 3 ? 'Minimum 3 characters' : null,
            )),
            const SizedBox(width: 20),
            Expanded(child: GstTextField(
              label: 'Business Name', hint: 'Registered business name', icon: Icons.business, required: true,
              controller: _businessNameCtrl,
              validator: (v) => v == null || v.trim().length < 3 ? 'Minimum 3 characters' : null,
            )),
          ],
        ),
        const SizedBox(height: 16),
        GstTextField(
          label: 'GSTIN', hint: '15-digit GST Identification Number', icon: Icons.badge, required: true,
          controller: _gstinCtrl,
          validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (!RegExp(r'^[0-9A-Za-z]{15}$').hasMatch(v) ? 'Exactly 15 alphanumeric characters' : null),
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstTextField(
              label: 'Contact Email', hint: 'Client email address', icon: Icons.email, required: true,
              controller: _emailCtrl,
              validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (!validateEmail(v) ? 'Invalid email format' : null),
            )),
            const SizedBox(width: 20),
            Expanded(child: GstTextField(
              label: 'Contact Number', hint: '10-digit mobile number', icon: Icons.phone, required: true,
              controller: _phoneCtrl, keyboardType: TextInputType.phone,
              validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (!validatePhone(v) ? 'Exactly 10 digits required' : null),
            )),
          ],
        ),
      ],
    );
  }

  Widget _buildReturnDetails() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstDropdownField(
              label: 'Return Type', icon: Icons.list, required: true,
              value: _returnType,
              items: ['GSTR-1', 'GSTR-3B', 'CMP-08', 'Other'],
              onChanged: (v) => setState(() { _returnType = v; _errReturnType = null; }),
              errorText: _errReturnType,
            )),
            const SizedBox(width: 20),
            Expanded(child: _buildMonthYearPicker()),
          ],
        ),
      ],
    );
  }

  Widget _buildMonthYearPicker() {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final now = DateTime.now();
    final years = List.generate(5, (i) => '${now.year - i}');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Filing Period', true),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _errFilingPeriod != null ? const Color(0xFFEF4444) : const Color(0xFFE2E8F0)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _filingMonth,
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF94A3B8), size: 22),
                    hint: Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: Text('Month', style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14)),
                    ),
                    items: months.map((m) => DropdownMenuItem(value: m, child: Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: Text(m, style: const TextStyle(fontSize: 14)),
                    ))).toList(),
                    onChanged: (v) => setState(() { _filingMonth = v; _errFilingPeriod = null; }),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _errFilingPeriod != null ? const Color(0xFFEF4444) : const Color(0xFFE2E8F0)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _filingYear,
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF94A3B8), size: 22),
                    hint: Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: Text('Year', style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14)),
                    ),
                    items: years.map((y) => DropdownMenuItem(value: y, child: Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: Text(y, style: const TextStyle(fontSize: 14)),
                    ))).toList(),
                    onChanged: (v) => setState(() { _filingYear = v; _errFilingPeriod = null; }),
                  ),
                ),
              ),
            ),
          ],
        ),
        if (_errFilingPeriod != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 14),
            child: Text(_errFilingPeriod!, style: const TextStyle(color: Color(0xFFEF4444), fontSize: 12)),
          ),
      ],
    );
  }

  Widget _buildLabel(String text, bool required) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: text, style: const TextStyle(color: Color(0xFF374151), fontSize: 13, fontWeight: FontWeight.w500)),
          if (required) const TextSpan(text: ' *', style: TextStyle(color: Color(0xFFEF4444), fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildDocuments() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstFileField(
              label: 'Sales / Turnover Details', icon: Icons.receipt, required: true,
              fileName: _salesFile, onFilePicked: (n) => _salesFile = n,
              acceptText: 'XLSX/PDF, max 10MB',
            )),
            const SizedBox(width: 20),
            Expanded(child: GstFileField(
              label: 'Purchase / Input Tax Details', icon: Icons.shopping_cart,
              fileName: _purchaseFile, onFilePicked: (n) => _purchaseFile = n,
              acceptText: 'XLSX/PDF, max 10MB',
            )),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstFileField(
              label: 'Debit / Credit Notes', icon: Icons.note,
              fileName: _debitCreditFile, onFilePicked: (n) => _debitCreditFile = n,
              acceptText: 'XLSX/PDF, max 10MB',
            )),
            const SizedBox(width: 20),
            Expanded(child: GstFileField(
              label: 'Payment Challans', icon: Icons.payment,
              fileName: _paymentChallansFile, onFilePicked: (n) => _paymentChallansFile = n,
              acceptText: 'PDF only, max 10MB',
            )),
          ],
        ),
        const SizedBox(height: 16),
        GstFileField(
          label: 'Prior Period Entries', icon: Icons.history,
          fileName: _priorPeriodFile, onFilePicked: (n) => _priorPeriodFile = n,
          acceptText: 'PDF/XLSX, max 10MB',
        ),
      ],
    );
  }
}
