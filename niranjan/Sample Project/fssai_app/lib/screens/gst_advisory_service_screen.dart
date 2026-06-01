import 'package:flutter/material.dart';

class GstAdvisoryForm extends StatefulWidget {
  final VoidCallback? onSubmit;

  const GstAdvisoryForm({super.key, this.onSubmit});

  @override
  State<GstAdvisoryForm> createState() => _GstAdvisoryFormState();
}

class _GstAdvisoryFormState extends State<GstAdvisoryForm> {
  final _formKey = GlobalKey<FormState>();
  final _clientNameCtrl = TextEditingController();
  final _businessNameCtrl = TextEditingController();
  final _gstinCtrl = TextEditingController();
  final _turnoverCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _mobileCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();
  String? _selectedBusinessType;
  bool _taxPlanning = false;
  bool _inputTaxCredit = false;
  bool _complianceUpdates = false;
  bool _otherAdvisory = false;
  static const int _maxChars = 500;

  final _businessTypes = ['Retail', 'Wholesale', 'Manufacturer', 'Service Provider', 'Others'];

  @override
  void dispose() {
    _clientNameCtrl.dispose();
    _businessNameCtrl.dispose();
    _gstinCtrl.dispose();
    _turnoverCtrl.dispose();
    _emailCtrl.dispose();
    _mobileCtrl.dispose();
    _descriptionCtrl.dispose();
    super.dispose();
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
            'GST Advisory Service',
            style: TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 23,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 28),
          _buildCard('Client Information', Icons.person_outline, [
            _buildTwoCol(
              _buildField('Client Name', Icons.person_outline, 'Enter client name', _clientNameCtrl, (v) => v == null || v.trim().isEmpty ? 'Required' : null),
              _buildField('Business Name', Icons.business, 'Enter business name', _businessNameCtrl, (v) => v == null || v.trim().isEmpty ? 'Required' : null),
            ),
            const SizedBox(height: 20),
            _buildTwoCol(
              _buildField('GSTIN', Icons.badge_outlined, 'Enter GSTIN (optional)', _gstinCtrl),
              _buildDropdownField(
                'Business Type',
                Icons.category_outlined,
                '-- Select Business Type --',
                _businessTypes,
                _selectedBusinessType,
                (v) => setState(() => _selectedBusinessType = v),
                (v) => v == null ? 'Select business type' : null,
              ),
            ),
          ]),
          const SizedBox(height: 20),
          _buildCard('Business & Advisory Details', Icons.analytics_outlined, [
            _buildField('Annual Turnover', Icons.currency_rupee, 'Enter annual turnover', _turnoverCtrl, (v) => v == null || v.trim().isEmpty ? 'Required' : null),
            const SizedBox(height: 20),
            _buildLabel('Advisory Required'),
            const SizedBox(height: 10),
            _buildCheckboxGrid(),
          ]),
          const SizedBox(height: 20),
          _buildCard('Contact Details', Icons.contact_mail_outlined, [
            _buildTwoCol(
              _buildField('Contact Email', Icons.email_outlined, 'Enter email address', _emailCtrl, (v) {
                if (v == null || v.trim().isEmpty) return 'Required';
                if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(v.trim())) return 'Invalid email';
                return null;
              }),
              _buildField('Contact Number', Icons.phone_outlined, 'Enter contact number', _mobileCtrl, (v) {
                if (v == null || v.trim().isEmpty) return 'Required';
                if (!RegExp(r'^\d{10}$').hasMatch(v.trim())) return 'Invalid 10-digit number';
                return null;
              }),
            ),
            const SizedBox(height: 20),
            _buildLabel('Description/Query'),
            const SizedBox(height: 10),
            _buildTextArea(),
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

  Widget _buildCheckboxGrid() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              _buildCheckboxItem('Tax Planning', _taxPlanning, (v) {
                setState(() => _taxPlanning = v ?? false);
              }),
              const SizedBox(height: 8),
              _buildCheckboxItem('Compliance Updates', _complianceUpdates, (v) {
                setState(() => _complianceUpdates = v ?? false);
              }),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            children: [
              _buildCheckboxItem('Input Tax Credit', _inputTaxCredit, (v) {
                setState(() => _inputTaxCredit = v ?? false);
              }),
              const SizedBox(height: 8),
              _buildCheckboxItem('Other', _otherAdvisory, (v) {
                setState(() => _otherAdvisory = v ?? false);
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCheckboxItem(String label, bool value, ValueChanged<bool?> onChanged) {
    return Container(
      height: 32,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: const Color(0xFFD1D5DB)),
      ),
      child: Row(
        children: [
          const SizedBox(width: 8),
          SizedBox(
            width: 16,
            height: 16,
            child: Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: const Color(0xFF1E2A4A),
              side: const BorderSide(color: Color(0xFFD1D5DB)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF374151),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: const Color(0xFFD1D5DB)),
          ),
          child: Column(
            children: [
              TextField(
                maxLines: 4,
                maxLength: _maxChars,
                controller: _descriptionCtrl,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                  hintText: 'Describe your query...',
                  hintStyle: const TextStyle(color: Color(0xFF6B7280), fontSize: 13),
                  counterText: '',
                ),
                style: const TextStyle(fontSize: 13, color: Color(0xFF374151)),
              ),
              Container(
                height: 1,
                color: const Color(0xFFD1D5DB),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${_descriptionCtrl.text.length}/$_maxChars',
                      style: TextStyle(
                        color: _descriptionCtrl.text.length >= _maxChars
                            ? const Color(0xFFEF4444)
                            : const Color(0xFF6B7280),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
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
                _turnoverCtrl.clear();
                _emailCtrl.clear();
                _mobileCtrl.clear();
                _descriptionCtrl.clear();
                _selectedBusinessType = null;
                _taxPlanning = false;
                _inputTaxCredit = false;
                _complianceUpdates = false;
                _otherAdvisory = false;
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
