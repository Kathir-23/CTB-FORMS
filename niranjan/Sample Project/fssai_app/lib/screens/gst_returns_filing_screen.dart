import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class GstReturnsFilingForm extends StatefulWidget {
  final VoidCallback? onSubmit;

  const GstReturnsFilingForm({super.key, this.onSubmit});

  @override
  State<GstReturnsFilingForm> createState() => _GstReturnsFilingFormState();
}

class _GstReturnsFilingFormState extends State<GstReturnsFilingForm> {
  final _formKey = GlobalKey<FormState>();
  final _clientNameCtrl = TextEditingController();
  final _businessNameCtrl = TextEditingController();
  final _gstinCtrl = TextEditingController();
  String? _selectedReturnType;
  String? _filingPeriod;
  String? _turnoverFileName;
  String? _purchaseFileName;

  final _returnTypes = ['GSTR-1', 'GSTR-3B', 'GSTR-4', 'GSTR-5', 'GSTR-6', 'GSTR-7', 'GSTR-8'];

  @override
  void dispose() {
    _clientNameCtrl.dispose();
    _businessNameCtrl.dispose();
    _gstinCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickMonthYear() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year, now.month, 1),
      firstDate: DateTime(2020),
      lastDate: DateTime(now.year, now.month, 1),
      helpText: 'Select Filing Period (Month & Year)',
    );
    if (picked != null) {
      final months = [
        'January', 'February', 'March', 'April', 'May', 'June',
        'July', 'August', 'September', 'October', 'November', 'December'
      ];
      setState(() => _filingPeriod = '${months[picked.month - 1]} ${picked.year}');
    }
  }

  Future<void> _pickFile({required bool isTurnover}) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'pdf'],
      allowMultiple: false,
    );
    if (!mounted) return;
    if (result != null && result.files.single.size <= 10 * 1024 * 1024) {
      setState(() {
        if (isTurnover) {
          _turnoverFileName = result.files.single.name;
        } else {
          _purchaseFileName = result.files.single.name;
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
            'GST Returns Filing',
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
            _buildField('GSTIN', Icons.badge_outlined, 'Enter 15-digit GSTIN', _gstinCtrl, (v) {
              if (v == null || v.trim().isEmpty) return 'Required';
              if (!RegExp(r'^\d{2}[A-Z]{5}\d{4}[A-Z]\d[Z]\d$').hasMatch(v.trim().toUpperCase())) return 'Enter valid 15-digit GSTIN';
              return null;
            }),
          ]),
          const SizedBox(height: 20),
          _buildCard('Return Details', Icons.receipt_long_outlined, [
            _buildTwoCol(
              _buildDropdownField(
                'Return Type',
                Icons.category_outlined,
                '-- Select Return Type --',
                _returnTypes,
                _selectedReturnType,
                (v) => setState(() => _selectedReturnType = v),
                (v) => v == null ? 'Select return type' : null,
              ),
              _buildDatePickerField(),
            ),
          ]),
          const SizedBox(height: 20),
          _buildCard('Upload Documents', Icons.upload_file_outlined, [
            _buildLabel('Turnover / Sales Details'),
            const SizedBox(height: 10),
            _buildFilePicker(
              fileName: _turnoverFileName,
              hint: 'Upload XLSX/PDF (max 10MB)',
              onPick: () => _pickFile(isTurnover: true),
              onClear: () => setState(() => _turnoverFileName = null),
            ),
            const SizedBox(height: 20),
            _buildLabel('Purchase / Input Tax Details'),
            const SizedBox(height: 10),
            _buildFilePicker(
              fileName: _purchaseFileName,
              hint: 'Upload XLSX/PDF (max 10MB) — Optional',
              onPick: () => _pickFile(isTurnover: false),
              onClear: () => setState(() => _purchaseFileName = null),
            ),
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
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 12,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 19, color: Color(0xFF64748B)),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF1E293B),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(height: 1, color: const Color(0xFFF1F5F9)),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF1F2937),
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
    );
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
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  Icon(icon, size: 15, color: Color(0xFF6B7280)),
                  Container(
                    height: 20,
                    width: 1,
                    color: const Color(0xFFD1D5DB),
                    margin: const EdgeInsets.only(left: 8),
                  ),
                ],
              ),
            ),
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFF6B7280), fontSize: 13),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: const BorderSide(color: Color(0xFF9CA3AF)),
              ),
              filled: true,
              fillColor: const Color(0xFFF3F4F6),
            ),
            style: const TextStyle(fontSize: 13, color: Color(0xFF374151)),
          ),
      ],
    );
  }

  Widget _buildDropdownField(
    String label,
    IconData icon,
    String placeholder,
    List<String> options,
    String? value,
    ValueChanged<String?> onChanged,
    String? Function(String?)? validator,
  ) {
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
                child: Row(
                  children: [
                    const SizedBox(width: 8),
                    Icon(icon, size: 15, color: Color(0xFF6B7280)),
                    Container(
                      height: 20,
                      width: 1,
                      color: const Color(0xFFD1D5DB),
                      margin: const EdgeInsets.only(left: 8),
                    ),
                  ],
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: const BorderSide(color: Color(0xFF9CA3AF)),
              ),
              filled: true,
              fillColor: const Color(0xFFF3F4F6),
            ),
            hint: Text(
              placeholder,
              style: const TextStyle(color: Color(0xFF6B7280), fontSize: 13),
            ),
            items: options.map((opt) {
              return DropdownMenuItem<String>(
                value: opt,
                child: Text(opt, style: const TextStyle(fontSize: 13, color: Color(0xFF374151))),
              );
            }).toList(),
            onChanged: onChanged,
            validator: validator,
          ),
      ],
    );
  }

  Widget _buildDatePickerField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Filing Period'),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: _pickMonthYear,
          child: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(7),
              border: Border.all(color: const Color(0xFFD1D5DB)),
            ),
            child: Row(
              children: [
                const SizedBox(width: 8),
                SizedBox(
                  width: 32,
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_month, size: 15, color: Color(0xFF6B7280)),
                      Container(
                        height: 20,
                        width: 1,
                        color: const Color(0xFFD1D5DB),
                        margin: const EdgeInsets.only(left: 8),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    _filingPeriod ?? 'Select month & year',
                    style: TextStyle(
                      color: _filingPeriod != null ? const Color(0xFF374151) : const Color(0xFF6B7280),
                      fontSize: 13,
                    ),
                  ),
                ),
                if (_filingPeriod != null)
                  GestureDetector(
                    onTap: () => setState(() => _filingPeriod = null),
                    child: const Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(Icons.close, size: 15, color: Color(0xFF6B7280)),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilePicker({
    required String? fileName,
    required String hint,
    required VoidCallback onPick,
    required VoidCallback onClear,
  }) {
    return GestureDetector(
      onTap: onPick,
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: const Color(0xFFD1D5DB)),
        ),
        child: Row(
          children: [
            const SizedBox(width: 8),
            const Icon(Icons.upload_file, size: 15, color: Color(0xFF6B7280)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                fileName ?? hint,
                style: TextStyle(
                  color: fileName != null ? const Color(0xFF374151) : const Color(0xFF6B7280),
                  fontSize: 13,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (fileName != null)
              GestureDetector(
                onTap: onClear,
                child: const Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Icon(Icons.close, size: 15, color: Color(0xFF6B7280)),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTwoCol(Widget left, Widget right) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: left),
        const SizedBox(width: 16),
        Expanded(child: right),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          OutlinedButton(
            onPressed: () {
              setState(() {
                _clientNameCtrl.clear();
                _businessNameCtrl.clear();
                _gstinCtrl.clear();
                _selectedReturnType = null;
                _filingPeriod = null;
                _turnoverFileName = null;
                _purchaseFileName = null;
              });
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF64748B),
              side: const BorderSide(color: Color(0xFFD1D5DB)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Text(
              'Reset',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton.icon(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                widget.onSubmit?.call();
              }
            },
            icon: const Icon(Icons.send, size: 14),
            label: const Text(
              'Submit Request',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E2A4A),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }
}
