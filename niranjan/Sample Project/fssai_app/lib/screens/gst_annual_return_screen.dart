import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class GstAnnualReturnForm extends StatefulWidget {
  final VoidCallback? onSubmit;

  const GstAnnualReturnForm({super.key, this.onSubmit});

  @override
  State<GstAnnualReturnForm> createState() => _GstAnnualReturnFormState();
}

class _GstAnnualReturnFormState extends State<GstAnnualReturnForm> {
  final _formKey = GlobalKey<FormState>();
  final _clientNameCtrl = TextEditingController();
  final _businessNameCtrl = TextEditingController();
  final _gstinCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  String? _selectedFinancialYear;
  String? _gstr9FileName;
  String? _gstr9cFileName;

  final _financialYears = ['FY 2023-24', 'FY 2024-25', 'FY 2025-26', 'FY 2026-27'];

  @override
  void dispose() {
    _clientNameCtrl.dispose();
    _businessNameCtrl.dispose();
    _gstinCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickFile({required bool isGstr9}) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'pdf'],
      allowMultiple: false,
    );
    if (!mounted) return;
    if (result != null && result.files.single.size <= 10 * 1024 * 1024) {
      setState(() {
        if (isGstr9) {
          _gstr9FileName = result.files.single.name;
        } else {
          _gstr9cFileName = result.files.single.name;
        }
      });
    } else if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('File exceeds 10MB limit')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          const Text(
            'GST Annual Return Filing',
            style: TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 23,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 24),
          _buildCard('Client Information', Icons.person_outline, [
            _buildTwoCol(
              _buildField('Client Name', Icons.person_outline, 'Enter client name', _clientNameCtrl, (v) => v == null || v.trim().isEmpty ? 'Required' : null),
              _buildField('Business Name', Icons.business, 'Enter business name', _businessNameCtrl, (v) => v == null || v.trim().isEmpty ? 'Required' : null),
            ),
            const SizedBox(height: 20),
            _buildTwoCol(
              _buildField('GSTIN', Icons.badge_outlined, 'Enter 15-digit GSTIN', _gstinCtrl, (v) {
                if (v == null || v.trim().isEmpty) return 'Required';
                if (!RegExp(r'^\d{2}[A-Z]{5}\d{4}[A-Z]\d[Z]\d$').hasMatch(v.trim().toUpperCase())) return 'Enter valid 15-digit GSTIN';
                return null;
              }),
              _buildDropdownField('Financial Year', _financialYears, _selectedFinancialYear, (v) => setState(() => _selectedFinancialYear = v), (v) => v == null ? 'Select FY' : null),
            ),
          ]),
          const SizedBox(height: 20),
          _buildCard('Upload Documents', Icons.upload_file_outlined, [
            _buildLabel('GSTR-9 Data'),
            const SizedBox(height: 10),
            _buildFilePicker(
              fileName: _gstr9FileName,
              hint: 'Upload XLSX/PDF (max 10MB)',
              onPick: () => _pickFile(isGstr9: true),
              onClear: () => setState(() => _gstr9FileName = null),
            ),
            const SizedBox(height: 20),
            _buildLabel('GSTR-9C Data'),
            const SizedBox(height: 10),
            _buildFilePicker(
              fileName: _gstr9cFileName,
              hint: 'Upload PDF (max 10MB) — Optional',
              onPick: () => _pickFile(isGstr9: false),
              onClear: () => setState(() => _gstr9cFileName = null),
            ),
          ]),
          const SizedBox(height: 20),
          _buildCard('Contact Details', Icons.contact_mail_outlined, [
            _buildField('Contact Email', Icons.email_outlined, 'Enter email address', _emailCtrl, (v) {
              if (v == null || v.trim().isEmpty) return 'Required';
              if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(v.trim())) return 'Invalid email';
              return null;
            }),
          ]),
          const SizedBox(height: 28),
          _buildActionButtons(),
          const SizedBox(height: 28),
        ],
      ),
    );
  }

  Widget _buildCard(String title, IconData icon, List<Widget> children) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Color(0x0F000000), blurRadius: 12, offset: Offset(0, 2))],
      ),
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(icon, size: 19, color: Color(0xFF64748B)),
            const SizedBox(width: 8),
            Text(title, style: const TextStyle(color: Color(0xFF1E293B), fontSize: 16, fontWeight: FontWeight.w600)),
          ]),
          const SizedBox(height: 16),
          Container(height: 1, color: const Color(0xFFF1F5F9)),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(text, style: const TextStyle(color: Color(0xFF1F2937), fontSize: 13, fontWeight: FontWeight.w500));
  }

  Widget _buildField(String label, IconData icon, String hint, TextEditingController controller, [String? Function(String?)? validator]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            prefixIcon: SizedBox(
              width: 32,
              child: Row(children: [
                const SizedBox(width: 8),
                Icon(icon, size: 15, color: Color(0xFF6B7280)),
                Container(height: 20, width: 1, color: const Color(0xFFD1D5DB), margin: const EdgeInsets.only(left: 8)),
              ]),
            ),
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFF6B7280), fontSize: 13),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(7), borderSide: const BorderSide(color: Color(0xFFD1D5DB))),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(7), borderSide: const BorderSide(color: Color(0xFFD1D5DB))),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(7), borderSide: const BorderSide(color: Color(0xFF9CA3AF))),
              filled: true,
              fillColor: const Color(0xFFF3F4F6),
            ),
            style: const TextStyle(fontSize: 13, color: Color(0xFF374151)),
          ),
      ],
    );
  }

  Widget _buildDropdownField(String label, List<String> options, String? value, ValueChanged<String?> onChanged, String? Function(String?)? validator) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
            value: value,
            isExpanded: true,
            decoration: InputDecoration(
              prefixIcon: SizedBox(
                width: 32,
                child: Row(children: [
                  const Icon(Icons.calendar_view_month, size: 15, color: Color(0xFF6B7280)),
                  Container(height: 20, width: 1, color: const Color(0xFFD1D5DB), margin: const EdgeInsets.only(left: 8)),
                ]),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(7), borderSide: const BorderSide(color: Color(0xFFD1D5DB))),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(7), borderSide: const BorderSide(color: Color(0xFFD1D5DB))),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(7), borderSide: const BorderSide(color: Color(0xFF9CA3AF))),
              filled: true,
              fillColor: const Color(0xFFF3F4F6),
            ),
            hint: const Text('-- Select FY --', style: TextStyle(color: Color(0xFF6B7280), fontSize: 13)),
            items: options.map((opt) => DropdownMenuItem(value: opt, child: Text(opt, style: const TextStyle(fontSize: 13, color: Color(0xFF374151))))).toList(),
            onChanged: onChanged,
            validator: validator,
          ),
      ],
    );
  }

  Widget _buildFilePicker({required String? fileName, required String hint, required VoidCallback onPick, required VoidCallback onClear}) {
    return GestureDetector(
      onTap: onPick,
      child: Container(
        width: double.infinity, height: 40,
        decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(7), border: Border.all(color: const Color(0xFFD1D5DB))),
        child: Row(children: [
          const SizedBox(width: 8),
          const Icon(Icons.upload_file, size: 15, color: Color(0xFF6B7280)),
          const SizedBox(width: 8),
          Expanded(child: Text(fileName ?? hint, style: TextStyle(color: fileName != null ? const Color(0xFF374151) : const Color(0xFF6B7280), fontSize: 13), overflow: TextOverflow.ellipsis)),
          if (fileName != null)
            GestureDetector(onTap: onClear, child: const Padding(padding: EdgeInsets.only(right: 8), child: Icon(Icons.close, size: 15, color: Color(0xFF6B7280)))),
        ]),
      ),
    );
  }

  Widget _buildTwoCol(Widget left, Widget right) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: left), const SizedBox(width: 16), Expanded(child: right)]);
  }

  Widget _buildActionButtons() {
    return Align(
      alignment: Alignment.centerRight,
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        OutlinedButton(
          onPressed: () => setState(() {
            _clientNameCtrl.clear(); _businessNameCtrl.clear(); _gstinCtrl.clear(); _emailCtrl.clear();
            _selectedFinancialYear = null; _gstr9FileName = null; _gstr9cFileName = null;
          }),
          style: OutlinedButton.styleFrom(foregroundColor: const Color(0xFF64748B), side: const BorderSide(color: Color(0xFFD1D5DB)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
          child: const Text('Reset', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ),
        const SizedBox(width: 12),
        ElevatedButton.icon(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.onSubmit?.call();
            }
          },
          icon: const Icon(Icons.send, size: 14),
          label: const Text('Submit Request', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1E2A4A), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), elevation: 0),
        ),
      ]),
    );
  }
}
