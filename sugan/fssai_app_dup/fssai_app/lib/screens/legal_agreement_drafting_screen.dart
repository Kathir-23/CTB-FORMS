import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_layout.dart';
import '../widgets/form_fields.dart';

class LegalAgreementDraftingScreen extends StatefulWidget {
  const LegalAgreementDraftingScreen({super.key});

  @override
  State<LegalAgreementDraftingScreen> createState() => _LegalAgreementDraftingScreenState();
}

class _LegalAgreementDraftingScreenState extends State<LegalAgreementDraftingScreen> {
  int _selectedNavIndex = 14;
  final _formKey = GlobalKey<FormState>();
  bool _hoveringSubmit = false;

  final _clientName = TextEditingController();
  String? _businessType;
  final _businessPan = TextEditingController();
  String? _agreementType;
  final _keyClauses = TextEditingController();
  DateTime? _selectedDate;
  final _contactPerson = TextEditingController();
  final _email = TextEditingController();
  final _contact = TextEditingController();
  String? _fileName;
  bool _showFileError = false;

  final List<String> _businessTypes = ['Proprietorship','Partnership','Pvt Ltd','LLP','NGO','Other'];
  final List<String> _agreementTypes = ['Partnership','Service','Vendor','Client','Other'];

  @override
  void dispose() {
    _clientName.dispose();
    _businessPan.dispose();
    _keyClauses.dispose();
    _contactPerson.dispose();
    _email.dispose();
    _contact.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(context: context, initialDate: _selectedDate ?? DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime.now());
    if (picked != null) setState(() { _selectedDate = picked; });
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(activeNavIndex: _selectedNavIndex, onNavChanged: (i) => setState(() => _selectedNavIndex = i), showBackButton: true, child: _selectedNavIndex == 14 ? _buildForm() : const SizedBox.shrink());
  }

  Widget _buildForm() {
    return Form(key: _formKey, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Business & Regulatory Registration Portal > Legal Agreement Drafting', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13)),
      const SizedBox(height: 4),
      const Text('Legal Agreement Drafting Request Form', style: TextStyle(color: Color(0xFF0F172A), fontSize: 22, fontWeight: FontWeight.w600)),
      const SizedBox(height: 24),

      FormCard(title: 'Client & Agreement Details', icon: Icons.description_outlined, child: Column(children: [
        Row(children: [Expanded(child: _buildTextField(label: 'Client Name*', hint: 'Business/Entity name', controller: _clientName, validator: (v) { if (v==null||v.trim().isEmpty) return 'Required'; if (v.trim().length<3) return 'Min 3 chars'; return null;})), const SizedBox(width:20), Expanded(child: _buildDropdown(label: 'Business Type*', value: _businessType, items: _businessTypes, onChanged: (v)=>setState(()=>_businessType=v), validator: (v){ if (v==null||v.isEmpty) return 'Please select'; return null;}))]),
        const SizedBox(height:12),
        Row(children: [Expanded(child: _buildTextField(label: 'Business PAN*', hint: 'PAN of entity', controller: _businessPan, validator: (v){ if (v==null||v.trim().isEmpty) return 'Required'; if (v.trim().length!=10) return 'Invalid PAN'; return null;})), const SizedBox(width:20), Expanded(child: _buildDropdown(label: 'Agreement Type*', value: _agreementType, items: _agreementTypes, onChanged: (v)=>setState(()=>_agreementType=v), validator: (v){ if (v==null||v.isEmpty) return 'Please select'; return null;}))]),
        const SizedBox(height:12),
        _buildTextArea(label: 'Key Clauses*', hint: 'Specific requirements/clauses', controller: _keyClauses, validator: (v){ if (v==null||v.trim().isEmpty) return 'Required'; if (v.trim().length<10) return 'Min 10 chars'; return null;}),
        const SizedBox(height:12),
        Row(children: [Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Effective Date*', style: TextStyle(color: Color(0xFF374151), fontSize: 13, fontWeight: FontWeight.w500)), const SizedBox(height:6), SizedBox(height:44, child: TextFormField(readOnly: true, decoration: InputDecoration(hintText: _selectedDate==null?'DD/MM/YYYY':'', contentPadding: const EdgeInsets.symmetric(horizontal:14, vertical:12), border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)), filled:true, fillColor: Colors.white), onTap: ()=>_selectDate(context), validator: (v){ if (_selectedDate==null) return 'Date required'; return null;}))])), const SizedBox(width:20), Expanded(child: _buildTextField(label: 'Contact Person Name*', hint: 'Authorized signatory', controller: _contactPerson, validator: (v){ if (v==null||v.trim().isEmpty) return 'Required'; if (v.trim().length<3) return 'Min 3 chars'; return null;}))]),
      ])),

      const SizedBox(height:16),
      FormCard(title: 'Contact & Supporting Documents', icon: Icons.contact_mail_outlined, child: Column(children: [
        Row(children: [Expanded(child: _buildTextField(label: 'Contact Email*', hint: 'Email ID', controller: _email, keyboardType: TextInputType.emailAddress, validator: (v){ if (v==null||v.trim().isEmpty) return 'Required'; final re=RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}'); if(!re.hasMatch(v.trim())) return 'Invalid'; return null;})), const SizedBox(width:20), Expanded(child: _buildTextField(label: 'Contact Number*', hint: 'Mobile', controller: _contact, keyboardType: TextInputType.phone, validator: (v){ if (v==null||v.trim().isEmpty) return 'Required'; if (v.trim().length!=10||int.tryParse(v.trim())==null) return '10 digits'; return null;}))]),
        const SizedBox(height:12),
        FormFileField(label: 'Supporting Docs*', icon: Icons.folder_open_outlined, helperText: 'Business Proofs – PDF/JPG ≤ 10MB', onFilePicked: (name){ setState(()=>_fileName=name); _showFileError=false; }),
        if (_showFileError) const Padding(padding: EdgeInsets.only(top:8.0), child: Text('Please upload supporting documents', style: TextStyle(color: Color(0xFFEF4444), fontSize:12))),
      ])),

      const SizedBox(height:24), _buildSubmitButton(),
    ]));
  }

  Widget _buildTextField({required String label, required String hint, required TextEditingController controller, required String? Function(String?) validator, TextInputType keyboardType = TextInputType.text}) { final hasAsterisk = label.endsWith('*'); final cleanLabel = hasAsterisk ? label.substring(0, label.length-1) : label; return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [ RichText(text: TextSpan(children: [ TextSpan(text: cleanLabel, style: const TextStyle(color: Color(0xFF374151), fontSize:13, fontWeight: FontWeight.w500)), if (hasAsterisk) const TextSpan(text: ' *', style: TextStyle(color: Color(0xFFEF4444))) ])), const SizedBox(height:6), TextFormField(controller: controller, validator: validator, keyboardType: keyboardType, decoration: InputDecoration(hintText: hint, contentPadding: const EdgeInsets.symmetric(horizontal:14, vertical:12), border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)), filled:true, fillColor: Colors.white)), const SizedBox(height:8), ]); }

  Widget _buildTextArea({required String label, required String hint, required TextEditingController controller, required String? Function(String?) validator}) { final hasAsterisk = label.endsWith('*'); final cleanLabel = hasAsterisk ? label.substring(0, label.length-1) : label; return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [ RichText(text: TextSpan(children: [ TextSpan(text: cleanLabel, style: const TextStyle(color: Color(0xFF374151), fontSize:13, fontWeight: FontWeight.w500)), if (hasAsterisk) const TextSpan(text: ' *', style: TextStyle(color: Color(0xFFEF4444))) ])), const SizedBox(height:6), TextFormField(controller: controller, validator: validator, maxLines:3, decoration: InputDecoration(hintText: hint, contentPadding: const EdgeInsets.symmetric(horizontal:14, vertical:12), border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)), filled:true, fillColor: Colors.white)), const SizedBox(height:8), ]); }

  Widget _buildDropdown({required String label, required String? value, required List<String> items, required ValueChanged<String?> onChanged, required String? Function(String?) validator}) { final hasAsterisk = label.endsWith('*'); final cleanLabel = hasAsterisk ? label.substring(0, label.length-1) : label; return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [ RichText(text: TextSpan(children: [ TextSpan(text: cleanLabel, style: const TextStyle(color: Color(0xFF374151), fontSize:13, fontWeight: FontWeight.w500)), if (hasAsterisk) const TextSpan(text: ' *', style: TextStyle(color: Color(0xFFEF4444))) ])), const SizedBox(height:6), DropdownButtonFormField<String>(value: value, hint: const Text('-- Select --', style: TextStyle(color: Color(0xFF9CA3AF))), items: items.map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), decoration: InputDecoration(contentPadding: const EdgeInsets.symmetric(horizontal:14, vertical:12), border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)), filled:true, fillColor: Colors.white), onChanged: onChanged, validator: validator), const SizedBox(height:8), ]); }

  Widget _buildSubmitButton() { return Padding(padding: const EdgeInsets.only(top:8), child: MouseRegion(cursor: SystemMouseCursors.click, onEnter: (_)=>setState(()=>_hoveringSubmit=true), onExit: (_)=>setState(()=>_hoveringSubmit=false), child: SizedBox(width: double.infinity, height:48, child: ElevatedButton(onPressed: (){ final valid = _formKey.currentState?.validate() ?? false; final uploaded = _fileName != null; if (!uploaded) setState(()=>_showFileError=true); if (valid && uploaded) _showSuccessDialog(); }, style: ElevatedButton.styleFrom(backgroundColor: _hoveringSubmit ? const Color(0xFF4A59D0) : AppColors.brandBlue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), child: const Text('Submit Application', style: TextStyle(fontSize:16, fontWeight: FontWeight.w600)))))); }

  void _showSuccessDialog() { showDialog(context: context, barrierDismissible: false, builder: (ctx){ return Dialog(backgroundColor: Colors.transparent, elevation: 0, child: Container(width:420, padding: const EdgeInsets.symmetric(horizontal:40, vertical:40), decoration: BoxDecoration(color: AppColors.bgCard, borderRadius: BorderRadius.circular(16)), child: Column(mainAxisSize: MainAxisSize.min, children: [ Container(width:56, height:56, decoration: const BoxDecoration(color: Color(0xFF22C55E), shape: BoxShape.circle), child: const Icon(Icons.check, color: Colors.white, size:32)), const SizedBox(height:20), const Text('Application Submitted!', style: TextStyle(color: Color(0xFF1A1F2E), fontSize:20, fontWeight: FontWeight.w700)), const SizedBox(height:12), const Text('We have received your request. Our team will review and respond shortly.', style: TextStyle(color: Color(0xFF64748B), fontSize:14), textAlign: TextAlign.center), const SizedBox(height:28), SizedBox(width:double.infinity, child: ElevatedButton(onPressed: (){ Navigator.of(ctx).pop(); Navigator.of(context).pop(); }, style: ElevatedButton.styleFrom(backgroundColor: AppColors.brandBlue, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal:24, vertical:12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), elevation:0), child: const Text('Back to Services', style: TextStyle(fontSize:15, fontWeight: FontWeight.w600)))) ]), ), ); }); }
}
