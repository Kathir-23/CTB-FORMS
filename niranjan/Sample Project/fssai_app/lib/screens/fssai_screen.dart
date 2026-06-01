import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_layout.dart';
import 'fssai_basic_registration_screen.dart';
import 'fssai_state_license_screen.dart';
import 'fssai_central_license_screen.dart';
import 'gst_advisory_service_screen.dart';
import 'gst_revocation_screen.dart';
import 'gst_returns_filing_screen.dart';
import 'gst_annual_return_screen.dart';
import 'gst_notice_reply_screen.dart';
import 'gst_amendment_screen.dart';
import 'gst_final_return_screen.dart';
import 'gst_registration_screen.dart';
import 'income_tax_screen.dart';
import 'itr_form_screen.dart';
import 'legal_services_screen.dart';
import 'legal_nda_screen.dart';
import 'legal_contract_drafting_screen.dart';
import 'legal_franchise_agreement_screen.dart';

class FssaiScreen extends StatefulWidget {
  const FssaiScreen({super.key});

  @override
  State<FssaiScreen> createState() => _FssaiScreenState();
}

class _FssaiScreenState extends State<FssaiScreen> {
  int _selectedRadio = 0;
  int _selectedNavIndex = 10;
  int _hoveredCard = -1;
  int _pressedCard = -1;
  bool _hoveringContinue = false;

  void _redirectToGstHome() {
    setState(() => _selectedNavIndex = 10);
  }

  void _redirectToIncomeTaxHome() {
    setState(() => _selectedNavIndex = 20);
  }

  void _redirectToLegalHome() {
    setState(() => _selectedNavIndex = 30);
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      activeNavIndex: _selectedNavIndex,
      onNavChanged: (i) => setState(() => _selectedNavIndex = i),
      child: _selectedNavIndex == 10
          ? GstRegistrationForm(
              onNavigateToAdvisory: () => setState(() => _selectedNavIndex = 11),
              onNavigateToRevocation: () => setState(() => _selectedNavIndex = 14),
              onNavigateToReturns: () => setState(() => _selectedNavIndex = 15),
              onNavigateToAnnualReturn: () => setState(() => _selectedNavIndex = 16),
              onNavigateToNoticeReply: () => setState(() => _selectedNavIndex = 17),
              onNavigateToAmendment: () => setState(() => _selectedNavIndex = 18),
              onNavigateToFinalReturn: () => setState(() => _selectedNavIndex = 19),
            )
          : _selectedNavIndex == 11
              ? GstAdvisoryForm(onSubmit: _redirectToGstHome)
              : _selectedNavIndex == 12
                  ? _buildFssaiContent()
                  : _selectedNavIndex == 14
                      ? GstRevocationForm(onSubmit: _redirectToGstHome)
                      : _selectedNavIndex == 15
                          ? GstReturnsFilingForm(onSubmit: _redirectToGstHome)
                          : _selectedNavIndex == 16
                              ? GstAnnualReturnForm(onSubmit: _redirectToGstHome)
                              : _selectedNavIndex == 17
                                  ? GstNoticeReplyForm(onSubmit: _redirectToGstHome)
                                  : _selectedNavIndex == 18
                                      ? GstAmendmentForm(onSubmit: _redirectToGstHome)
                                      : _selectedNavIndex == 19
                                          ? GstFinalReturnForm(onSubmit: _redirectToGstHome)
                                          : _selectedNavIndex == 20
                                              ? IncomeTaxForm(
                                                  onNavigateToGeneral: () => setState(() => _selectedNavIndex = 29),
                                                  onNavigateToItr1: () => setState(() => _selectedNavIndex = 21),
                                                  onNavigateToItr2: () => setState(() => _selectedNavIndex = 22),
                                                  onNavigateToItr3: () => setState(() => _selectedNavIndex = 23),
                                                  onNavigateToItr4: () => setState(() => _selectedNavIndex = 24),
                                                  onNavigateToItr5: () => setState(() => _selectedNavIndex = 25),
                                                  onNavigateToItr6: () => setState(() => _selectedNavIndex = 26),
                                                  onNavigateToItr7: () => setState(() => _selectedNavIndex = 27),
                                                  onNavigateToNoticeResponse: () => setState(() => _selectedNavIndex = 28),
                                                )
                                              : _selectedNavIndex == 21
                                                  ? ItrForm(itrType: 0, onSubmit: _redirectToIncomeTaxHome)
                                                  : _selectedNavIndex == 22
                                                      ? ItrForm(itrType: 1, onSubmit: _redirectToIncomeTaxHome)
                                                      : _selectedNavIndex == 23
                                                          ? ItrForm(itrType: 2, onSubmit: _redirectToIncomeTaxHome)
                                                          : _selectedNavIndex == 24
                                                              ? ItrForm(itrType: 3, onSubmit: _redirectToIncomeTaxHome)
                                                              : _selectedNavIndex == 25
                                                                  ? ItrForm(itrType: 4, onSubmit: _redirectToIncomeTaxHome)
                                                                  : _selectedNavIndex == 26
                                                                      ? ItrForm(itrType: 5, onSubmit: _redirectToIncomeTaxHome)
                                                                      : _selectedNavIndex == 27
                                                                          ? ItrForm(itrType: 6, onSubmit: _redirectToIncomeTaxHome)
                                          : _selectedNavIndex == 28
                                              ? ItrForm(itrType: 7, onSubmit: _redirectToIncomeTaxHome)
                                              : _selectedNavIndex == 29
                                                  ? ItrForm(itrType: 8, onSubmit: _redirectToIncomeTaxHome)
                                                  : _selectedNavIndex == 30
                                                      ? LegalServicesForm(
                                                          onNavigateToNda: () => setState(() => _selectedNavIndex = 31),
                                                          onNavigateToLegalAgreement: () => setState(() => _selectedNavIndex = 32),
                                                          onNavigateToFranchise: () => setState(() => _selectedNavIndex = 33),
                                                        )
                                                      : _selectedNavIndex == 31
                                                          ? LegalNdaForm(onSubmit: _redirectToLegalHome)
                                                          : _selectedNavIndex == 32
                                                              ? LegalContractDraftingForm(onSubmit: _redirectToLegalHome)
                                                              : _selectedNavIndex == 33
                                                                  ? LegalFranchiseAgreementForm(onSubmit: _redirectToLegalHome)
                                                                  : const Center(
                                                                                  child: Text(
                                                                                    'Not built yet',
                                                                                    style: TextStyle(fontSize: 18, color: AppColors.textMuted),
                                                                                  ),
                                                                                ),
    );
  }

  Widget _buildFssaiContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeaderCard(),
        const SizedBox(height: 36),
        const Text(
          'Choose your business type',
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        _buildRadioSection(),
        const SizedBox(height: 28),
        _buildDocumentsCard(),
        const SizedBox(height: 36),
        _buildContinueButton(),
      ],
    );
  }

  Widget _buildHeaderCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.assignment_outlined,
              color: Color(0xFF3B82F6),
              size: 40,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'FSSAI ',
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(
                          text: 'Registration',
                          style: TextStyle(
                            color: Color(0xFF3B82F6),
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Expert guidance for your food business licensing and compliance',
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFF0F9FF),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            border: const Border(
              left: BorderSide(
                color: Color(0xFF3B82F6),
                width: 4,
              ),
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 2),
                child: Icon(
                  Icons.check_box_outlined,
                  color: Color(0xFF3B82F6),
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'GST compliance can be complex and overwhelming for many business owners. The intricate rules and frequent updates make it difficult to stay current and avoid penalties.',
                      style: TextStyle(
                        color: Color(0xFF475569),
                        fontSize: 14,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          color: Color(0xFF475569),
                          fontSize: 14,
                          height: 1.45,
                          fontFamily: 'Roboto',
                        ),
                        children: [
                          TextSpan(text: 'Our service provides '),
                          TextSpan(
                            text: 'expert guidance to simplify the entire process.',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          TextSpan(text: ' We handle the heavy lifting so you can focus on '),
                          TextSpan(
                            text: 'growing your business with peace of mind.',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                        ],
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

  Widget _buildRadioSection() {
    return SizedBox(
      height: 180,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _buildSelectorCard(
              0,
              'Basic Registration',
              'Small businesses & startups',
              Icons.storefront_outlined,
              const Color(0xFF0EA5E9),
              showRecommended: true,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildSelectorCard(
              1,
              'State License',
              'Mid-size operations',
              Icons.store_outlined,
              const Color(0xFF10B981),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildSelectorCard(
              2,
              'Central License',
              'Large-scale enterprises',
              Icons.grid_view_outlined,
              const Color(0xFFF97316),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectorCard(
    int index,
    String title,
    String subtitle,
    IconData icon,
    Color iconColor, {
    bool showRecommended = false,
  }) {
    final isSelected = _selectedRadio == index;
    final isHovered = _hoveredCard == index;
    final isPressed = _pressedCard == index;
    final bgColor = isSelected ? const Color(0xFF2D3A6B) : Colors.white;
    final borderColor = isSelected
        ? const Color(0xFF2D3A6B)
        : (isHovered ? const Color(0xFFCBD5E1) : const Color(0xFFE2E8F0));
    final titleColor = isSelected ? Colors.white : const Color(0xFF1E293B);
    final subtitleColor = isSelected
        ? Colors.white.withAlpha(166)
        : const Color(0xFF94A3B8);
    final effectiveIconColor =
        (isSelected && index == 0) ? Colors.white : iconColor;

    Matrix4 getTransform() {
      if (isPressed) return Matrix4.diagonal3Values(0.97, 0.97, 1.0);
      return Matrix4.identity();
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hoveredCard = index),
      onExit: (_) => setState(() => _hoveredCard = -1),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressedCard = index),
        onTapUp: (_) {
          setState(() {
            _pressedCard = -1;
            _selectedRadio = index;
          });
        },
        onTapCancel: () => setState(() => _pressedCard = -1),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: getTransform(),
          transformAlignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor, width: 1),
            boxShadow: isHovered && !isSelected
                ? [
                    const BoxShadow(
                      color: Color(0x14000000),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showRecommended)
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF59E0B),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Text(
                      'Recommended',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              Icon(icon, color: effectiveIconColor, size: 22),
              const SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  color: titleColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: subtitleColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDocumentsCard() {
    final allDocs = [..._getLeftDocs(), ..._getRightDocs()];
    final docCount = allDocs.length;
    final licenseName = _getLicenseLabel();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.verified_outlined,
                  color: Color(0xFF3B82F6),
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Required documents — $licenseName License',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E293B),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$docCount documents',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3B82F6),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildDocumentGrid(allDocs),
        ],
      ),
    );
  }

  Widget _buildDocumentGrid(List<String> docs) {
    final leftDocs = _getLeftDocs();
    final rightDocs = _getRightDocs();
    final maxRows = leftDocs.length > rightDocs.length ? leftDocs.length : rightDocs.length;

    return Column(
      children: List.generate(maxRows, (i) {
        final leftDoc = i < leftDocs.length ? leftDocs[i] : null;
        final rightDoc = i < rightDocs.length ? rightDocs[i] : null;
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              if (leftDoc != null) Expanded(child: _buildDocumentTile(leftDoc))
              else const Expanded(child: SizedBox()),
              const SizedBox(width: 10),
              if (rightDoc != null) Expanded(child: _buildDocumentTile(rightDoc))
              else const Expanded(child: SizedBox()),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildDocumentTile(String docName) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: const BoxDecoration(
              color: Color(0xFFEFF6FF),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check,
              color: Color(0xFF3B82F6),
              size: 14,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              docName,
              style: const TextStyle(
                color: Color(0xFF475569),
                fontSize: 13.5,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getLicenseLabel() {
    switch (_selectedRadio) {
      case 0: return 'Basic';
      case 1: return 'State';
      case 2: return 'Central';
      default: return '';
    }
  }

  List<String> _getLeftDocs() {
    switch (_selectedRadio) {
      case 0:
        return [
          'Aadhaar Card',
          'PAN Card',
          'Photograph of Proprietor',
          'Company register certificate',
        ];
      case 1:
        return [
          'Partner-Specific Document',
          'Business information',
          'Aadhar Card',
          'Company register certificate',
          'PAN Card',
        ];
      case 2:
        return [
          'Company information',
          'Director information',
          'Contact details',
          'Business details',
        ];
      default:
        return [];
    }
  }

  List<String> _getRightDocs() {
    switch (_selectedRadio) {
      case 0:
        return [
          'Property document',
          'Electricity bill',
          'Property tax receipt',
        ];
      case 1:
        return [
          'Company PAN Card',
          'Photograph',
          'Company Seal',
          'Property document',
        ];
      case 2:
        return [
          'Property document',
          'Electricity bill',
          'Property tax receipt',
          'MOA / AOA',
        ];
      default:
        return [];
    }
  }

  Widget _buildContinueButton() {
    return Center(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hoveringContinue = true),
        onExit: (_) => setState(() => _hoveringContinue = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 280,
          height: 54,
          decoration: BoxDecoration(
            color: _hoveringContinue
                ? const Color(0xFF3D4F72)
                : const Color(0xFF2E3A59),
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF2E3A59).withAlpha(80),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(32),
              onTap: () {
                Widget nextScreen;
                switch (_selectedRadio) {
                  case 1:
                    nextScreen = const FssaiStateLicenseScreen();
                    break;
                  case 2:
                    nextScreen = const FssaiCentralLicenseScreen();
                    break;
                  default:
                    nextScreen = const FssaiBasicRegistrationScreen();
                }
                _showUserDetailsDialog(context, (_) => nextScreen);
              },
              child: const Center(
                child: Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showUserDetailsDialog(BuildContext context, WidgetBuilder nextScreenBuilder) {
    final nameCtrl = TextEditingController();
    final mobileCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return Dialog(
          backgroundColor: AppColors.bgCard,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
          shadowColor: const Color(0x1F000000),
          child: SizedBox(
            width: 520,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'User Details',
                        style: TextStyle(
                          color: Color(0xFF1A1F2E),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Divider(height: 24, color: AppColors.border),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildDialogField(
                            'User Name',
                            'Enter your name',
                            nameCtrl,
                            (v) => v == null || v.trim().isEmpty ? 'User-name is required.' : null,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: _buildDialogField(
                            'Mobile Number',
                            'Enter Mobile Number',
                            mobileCtrl,
                            (v) {
                              if (v == null || v.trim().isEmpty) return 'Please enter mobile number.';
                              if (!RegExp(r'^\d{10}$').hasMatch(v.trim())) return 'Enter valid 10-digit number.';
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildDialogField(
                      'Mail Address',
                      'Enter Mail Address',
                      emailCtrl,
                      (v) {
                        if (v == null || v.trim().isEmpty) return 'Please enter mail address.';
                        if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(v.trim())) return 'Enter valid email address.';
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Navigator.of(ctx).pop();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: nextScreenBuilder,
                              ),
                            ).then((_) {
                              setState(() => _selectedNavIndex = 10);
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.brandBlue,
                          foregroundColor: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                          child: const Text(
                            'Submit',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDialogField(
    String label,
    String hint,
    TextEditingController controller,
    String? Function(String?)? validator,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
        SizedBox(
          height: 48,
          child: TextFormField(
            controller: controller,
            validator: validator,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 15),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.brandBlue, width: 2),
              ),
              filled: true,
              fillColor: AppColors.white,
            ),
            style: const TextStyle(fontSize: 15, color: Color(0xFF1E293B)),
          ),
        ),
      ],
    );
  }
}
