import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class GstNoticeReplyForm extends StatefulWidget {
  final VoidCallback? onSubmit;

  const GstNoticeReplyForm({super.key, this.onSubmit});

  @override
  State<GstNoticeReplyForm> createState() => _GstNoticeReplyFormState();
}

class _GstNoticeReplyFormState extends State<GstNoticeReplyForm> {
  final _formKey = GlobalKey<FormState>();
  final _clientNameCtrl = TextEditingController();
  final _businessNameCtrl = TextEditingController();
  final _gstinCtrl = TextEditingController();
  final _explanationCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  String? _selectedNoticeType;
  DateTime? _noticeDate;
  String? _noticeFileName;
  static const int _maxChars = 500;

  final _noticeTypes = ['Show Cause', 'Demand', 'Scrutiny', 'Assessment', 'Other'];

  @override
  void dispose() {
    _clientNameCtrl.dispose();
    _businessNameCtrl.dispose();
    _gstinCtrl.dispose();
    _explanationCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _noticeDate ?? now,
      firstDate: DateTime(2020),
      lastDate: now,
    );
    if (picked != null) setState(() => _noticeDate = picked);
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: false,
    );
    if (!mounted) return;
    if (result != null && result.files.single.size <= 5 * 1024 * 1024) {
      setState(() => _noticeFileName = result.files.single.name);
    } else if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('File exceeds 5MB limit')));
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
          const Text('GST Notice Reply', style: TextStyle(color: Color(0xFF0F172A), fontSize: 23, fontWeight: FontWeight.w700)),
          const SizedBox(height: 24),
          _buildCard('Client Information', Icons.person_outline, [
            _buildTwoCol(
              _buildField('Client Name', Icons.person_outline, 'Enter client name', _clientNameCtrl, (v) => v == null || v.trim().isEmpty ? 'Required' : null),
              _buildField('Business Name', Icons.business, 'Enter business name', _businessNameCtrl, (v) => v == null || v.trim().isEmpty ? 'Required' : null),
            ),
            const SizedBox(height: 16),
            _buildField('GSTIN', Icons.badge_outlined, 'Enter 15-digit GSTIN', _gstinCtrl, (v) {
              if (v == null || v.trim().isEmpty) return 'Required';
              if (!RegExp(r'^\d{2}[A-Z]{5}\d{4}[A-Z]\d[Z]\d$').hasMatch(v.trim().toUpperCase())) return 'Enter valid 15-digit GSTIN';
              return null;
            }),
          ]),
          const SizedBox(height: 16),
          _buildCard('Notice Details', Icons.mail_outline, [
            _buildTwoCol(
              _buildDropdownField('Notice Type', _noticeTypes, _selectedNoticeType, (v) => setState(() => _selectedNoticeType = v), (v) => v == null ? 'Select notice type' : null),
              _buildDatePickerField(),
            ),
          ]),
          const SizedBox(height: 16),
          _buildCard('Documents', Icons.upload_file_outlined, [
            _buildLabel('Notice Copy'),
            const SizedBox(height: 8),
            _buildFilePicker(fileName: _noticeFileName, hint: 'Upload PDF (max 5MB)', onPick: _pickFile, onClear: () => setState(() => _noticeFileName = null)),
          ]),
          const SizedBox(height: 16),
          _buildCard('Explanation', Icons.description_outlined, [
            _buildLabel('Client Explanation'),
            const SizedBox(height: 8),
            _buildTextArea(),
          ]),
          const SizedBox(height: 16),
          _buildCard('Contact Details', Icons.contact_mail_outlined, [
            _buildField('Contact Email', Icons.email_outlined, 'Enter email address', _emailCtrl, (v) {
              if (v == null || v.trim().isEmpty) return 'Required';
              if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(v.trim())) return 'Invalid email';
              return null;
            }),
          ]),
          const SizedBox(height: 24),
          _buildActionButtons(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildCard(String title, IconData icon, List<Widget> children) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: const [BoxShadow(color: Color(0x0F000000), blurRadius: 12, offset: Offset(0, 2))]),
      padding: const EdgeInsets.all(28),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [Icon(icon, size: 19, color: Color(0xFF64748B)), const SizedBox(width: 8), Text(title, style: const TextStyle(color: Color(0xFF1E293B), fontSize: 16, fontWeight: FontWeight.w600))]),
        const SizedBox(height: 16),
        Container(height: 1, color: const Color(0xFFF1F5F9)),
        const SizedBox(height: 20),
        ...children,
      ]),
    );
  }

  Widget _buildLabel(String text) => Text(text, style: const TextStyle(color: Color(0xFF1F2937), fontSize: 13, fontWeight: FontWeight.w500));

  Widget _buildField(String label, IconData icon, String hint, TextEditingController controller, [String? Function(String?)? validator]) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _buildLabel(label),
      const SizedBox(height: 6),
      TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          prefixIcon: SizedBox(
            width: 32,
            child: Row(children: [const SizedBox(width: 8), Icon(icon, size: 14, color: Color(0xFF9CA3AF)), Container(height: 20, width: 1, color: const Color(0xFFD1D5DB), margin: const EdgeInsets.only(left: 8))]),
          ),
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(7), borderSide: const BorderSide(color: Color(0xFFD1D5DB))),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(7), borderSide: const BorderSide(color: Color(0xFFD1D5DB))),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(7), borderSide: const BorderSide(color: Color(0xFF9CA3AF))),
            filled: true,
            fillColor: const Color(0xFFF3F4F6),
          ),
          style: const TextStyle(fontSize: 12, color: Color(0xFF374151)),
        ),
    ]);
  }

  Widget _buildDropdownField(String label, List<String> options, String? value, ValueChanged<String?> onChanged, String? Function(String?)? validator) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _buildLabel(label),
      const SizedBox(height: 6),
      DropdownButtonFormField<String>(
          value: value,
          isExpanded: true,
          decoration: InputDecoration(
            prefixIcon: SizedBox(
              width: 32,
              child: Row(children: [const Icon(Icons.category_outlined, size: 14, color: Color(0xFF9CA3AF)), Container(height: 20, width: 1, color: const Color(0xFFD1D5DB), margin: const EdgeInsets.only(left: 8))]),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(7), borderSide: const BorderSide(color: Color(0xFFD1D5DB))),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(7), borderSide: const BorderSide(color: Color(0xFFD1D5DB))),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(7), borderSide: const BorderSide(color: Color(0xFF9CA3AF))),
            filled: true,
            fillColor: const Color(0xFFF3F4F6),
          ),
          hint: const Text('-- Select Notice Type --', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
          items: options.map((opt) => DropdownMenuItem(value: opt, child: Text(opt, style: const TextStyle(fontSize: 12, color: Color(0xFF374151))))).toList(),
          onChanged: onChanged,
          validator: validator,
        ),
    ]);
  }

  Widget _buildDatePickerField() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _buildLabel('Notice Date'),
      const SizedBox(height: 6),
      GestureDetector(
        onTap: _pickDate,
        child: Container(
          width: double.infinity, height: 38,
          decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(7), border: Border.all(color: const Color(0xFFD1D5DB))),
          child: Row(children: [
            const SizedBox(width: 8),
            SizedBox(
              width: 32,
              child: Row(children: [const Icon(Icons.calendar_month, size: 14, color: Color(0xFF9CA3AF)), Container(height: 20, width: 1, color: const Color(0xFFD1D5DB), margin: const EdgeInsets.only(left: 8))]),
            ),
            const SizedBox(width: 4),
            Expanded(child: Text(_noticeDate != null ? '${_noticeDate!.day}/${_noticeDate!.month}/${_noticeDate!.year}' : 'Select date', style: TextStyle(color: _noticeDate != null ? const Color(0xFF374151) : const Color(0xFF9CA3AF), fontSize: 12))),
            if (_noticeDate != null) GestureDetector(onTap: () => setState(() => _noticeDate = null), child: const Padding(padding: EdgeInsets.only(right: 8), child: Icon(Icons.close, size: 14, color: Color(0xFF9CA3AF)))),
          ]),
        ),
      ),
    ]);
  }

  Widget _buildTextArea() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        width: double.infinity,
        decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(7), border: Border.all(color: const Color(0xFFD1D5DB))),
        child: Column(children: [
          TextField(
            maxLines: 4, maxLength: _maxChars, controller: _explanationCtrl,
            decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.fromLTRB(12, 10, 12, 0), hintText: 'Describe the situation...', hintStyle: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12), counterText: ''),
            style: const TextStyle(fontSize: 12, color: Color(0xFF374151)),
          ),
          Container(height: 1, color: const Color(0xFFD1D5DB)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Text('${_explanationCtrl.text.length}/$_maxChars', style: TextStyle(color: _explanationCtrl.text.length >= _maxChars ? const Color(0xFFEF4444) : const Color(0xFF9CA3AF), fontSize: 12)),
            ]),
          ),
        ]),
      ),
    ]);
  }

  Widget _buildFilePicker({required String? fileName, required String hint, required VoidCallback onPick, required VoidCallback onClear}) {
    return GestureDetector(
      onTap: onPick,
      child: Container(
        width: double.infinity, height: 38,
        decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(7), border: Border.all(color: const Color(0xFFD1D5DB))),
        child: Row(children: [
          const SizedBox(width: 8), const Icon(Icons.upload_file, size: 14, color: Color(0xFF9CA3AF)), const SizedBox(width: 8),
          Expanded(child: Text(fileName ?? hint, style: TextStyle(color: fileName != null ? const Color(0xFF374151) : const Color(0xFF9CA3AF), fontSize: 12), overflow: TextOverflow.ellipsis)),
          if (fileName != null) GestureDetector(onTap: onClear, child: const Padding(padding: EdgeInsets.only(right: 8), child: Icon(Icons.close, size: 14, color: Color(0xFF9CA3AF)))),
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
            _clientNameCtrl.clear(); _businessNameCtrl.clear(); _gstinCtrl.clear(); _explanationCtrl.clear(); _emailCtrl.clear();
            _selectedNoticeType = null; _noticeDate = null; _noticeFileName = null;
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
