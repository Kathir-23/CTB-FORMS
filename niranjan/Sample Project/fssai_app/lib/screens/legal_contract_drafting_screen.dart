import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class LegalContractDraftingForm extends StatefulWidget {
  final VoidCallback? onSubmit;

  const LegalContractDraftingForm({super.key, this.onSubmit});

  @override
  State<LegalContractDraftingForm> createState() => _LegalContractDraftingFormState();
}

class _LegalContractDraftingFormState extends State<LegalContractDraftingForm> {
  final _formKey = GlobalKey<FormState>();
  final _clientNameCtrl = TextEditingController();
  final _businessPanCtrl = TextEditingController();
  final _keyClausesCtrl = TextEditingController();
  final _contactPersonCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _mobileCtrl = TextEditingController();
  DateTime? _effectiveDate;
  String? _businessType;
  String? _agreementType;
  String? _supportingDocName;
  bool _hasSubmitted = false;

  final _businessTypes = ['Proprietorship', 'Partnership', 'Pvt Ltd', 'LLP', 'NGO', 'Other'];
  final _agreementTypes = ['Partnership', 'Service', 'Vendor', 'Client', 'Other'];

  @override
  void dispose() {
    _clientNameCtrl.dispose();
    _businessPanCtrl.dispose();
    _keyClausesCtrl.dispose();
    _contactPersonCtrl.dispose();
    _emailCtrl.dispose();
    _mobileCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      setState(() => _effectiveDate = date);
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
            'Legal Agreement Drafting',
            style: TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 23,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 28),
          _buildCard('Client Information', Icons.person_outline, [
            _buildTwoCol(
              _buildField('Client Name', Icons.person_outline, 'Business/Entity name', _clientNameCtrl, (v) => v == null || v.trim().isEmpty ? 'Required' : null),
              _buildDropdownField(
                'Business Type',
                Icons.business_outlined,
                '-- Select --',
                _businessTypes,
                _businessType,
                (v) => setState(() => _businessType = v),
                (v) => v == null ? 'Select business type' : null,
              ),
            ),
            const SizedBox(height: 20),
            _buildTwoCol(
              _buildField('Business PAN', Icons.badge_outlined, 'PAN of entity', _businessPanCtrl, (v) => v == null || v.trim().isEmpty ? 'Required' : null),
              _buildDropdownField(
                'Agreement Type',
                Icons.description_outlined,
                '-- Select --',
                _agreementTypes,
                _agreementType,
                (v) => setState(() => _agreementType = v),
                (v) => v == null ? 'Select agreement type' : null,
              ),
            ),
          ]),
          const SizedBox(height: 20),
          _buildCard('Agreement Details', Icons.article_outlined, [
            _buildTextField('Key Clauses', Icons.list_alt_outlined, 'Specific requirements/clauses', _keyClausesCtrl, (v) => v == null || v.trim().isEmpty ? 'Required' : null),
            const SizedBox(height: 20),
            _buildDateField(),
          ]),
          const SizedBox(height: 20),
          _buildCard('Contact Details', Icons.contact_mail_outlined, [
            _buildTwoCol(
              _buildField('Contact Person Name', Icons.person_outline, 'Authorized signatory', _contactPersonCtrl, (v) => v == null || v.trim().isEmpty ? 'Required' : null),
              _buildField('Contact Email', Icons.email_outlined, 'Email ID', _emailCtrl, (v) {
                if (v == null || v.trim().isEmpty) return 'Required';
                if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(v.trim())) return 'Invalid email';
                return null;
              }),
            ),
            const SizedBox(height: 20),
            _buildField('Contact Number', Icons.phone_outlined, 'Mobile', _mobileCtrl, (v) {
              if (v == null || v.trim().isEmpty) return 'Required';
              if (!RegExp(r'^\d{10}$').hasMatch(v.trim())) return 'Invalid 10-digit number';
              return null;
            }),
          ]),
          const SizedBox(height: 20),
          _buildCard('Supporting Documents', Icons.attach_file_outlined, [
            _buildFileField('Supporting Docs (Business Proofs)', Icons.upload_file, (name) {
              setState(() => _supportingDocName = name);
            }, _hasSubmitted && _supportingDocName == null ? 'This field is required' : null),
          ]),
          const SizedBox(height: 28),
          _buildActionButtons(),
          const SizedBox(height: 28),
        ],
      ),
    );
  }

  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Effective Date'),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: _pickDate,
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(7),
              border: Border.all(color: const Color(0xFFD1D5DB)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, size: 15, color: Color(0xFF6B7280)),
                const SizedBox(width: 8),
                Container(height: 20, width: 1, color: const Color(0xFFD1D5DB)),
                const SizedBox(width: 12),
                Text(
                  _effectiveDate != null
                      ? '${_effectiveDate!.day}/${_effectiveDate!.month}/${_effectiveDate!.year}'
                      : 'Date of agreement commencement',
                  style: TextStyle(
                    color: _effectiveDate != null ? const Color(0xFF374151) : const Color(0xFF6B7280),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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

  Widget _buildTextField(String label, IconData icon, String hint, TextEditingController controller, [String? Function(String?)? validator]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: const Color(0xFFD1D5DB)),
          ),
          child: TextFormField(
            maxLines: 3,
            controller: controller,
            validator: validator,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
              hintText: hint,
              hintStyle: const TextStyle(color: Color(0xFF6B7280), fontSize: 13),
            ),
            style: const TextStyle(fontSize: 13, color: Color(0xFF374151)),
          ),
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

  Widget _buildFileField(String label, IconData icon, ValueChanged<String> onFilePicked, String? errorText) {
    String? fileName;
    bool isHovered = false;

    return StatefulBuilder(
      builder: (context, setLocalState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel(label),
            const SizedBox(height: 6),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) => setLocalState(() => isHovered = true),
              onExit: (_) => setLocalState(() => isHovered = false),
              child: GestureDetector(
                onTap: () async {
                  final result = await FilePicker.platform.pickFiles();
                  if (result != null && result.files.isNotEmpty) {
                    final name = result.files.single.name;
                    setLocalState(() => fileName = name);
                    onFilePicked(name);
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: double.infinity,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isHovered ? const Color(0xFFF1F4F8) : Colors.white,
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(
                      color: errorText != null ? const Color(0xFFEF4444) : const Color(0xFFD1D5DB),
                    ),
                  ),
                  child: Row(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: isHovered ? const Color(0xFFB8BFC9) : const Color(0xFFD1D5DB),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(6),
                            bottomLeft: Radius.circular(6),
                          ),
                          border: const Border(
                            right: BorderSide(color: Color(0xFFCBD5E1)),
                          ),
                        ),
                        child: Icon(icon, size: 18, color: const Color(0xFF6B7280)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          fileName ?? 'No file chosen',
                          style: TextStyle(
                            color: fileName != null ? const Color(0xFF475569) : const Color(0xFF9CA3AF),
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (errorText != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  errorText,
                  style: const TextStyle(color: Color(0xFFEF4444), fontSize: 12),
                ),
              ),
          ],
        );
      },
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
                _businessPanCtrl.clear();
                _keyClausesCtrl.clear();
                _contactPersonCtrl.clear();
                _emailCtrl.clear();
                _mobileCtrl.clear();
                _effectiveDate = null;
                _businessType = null;
                _agreementType = null;
                _supportingDocName = null;
                _hasSubmitted = false;
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
              setState(() => _hasSubmitted = true);
              if (_formKey.currentState!.validate() && _supportingDocName != null) {
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
