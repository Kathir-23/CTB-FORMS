import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_layout.dart';
import 'fssai_basic_registration_screen.dart';
import 'fssai_state_license_screen.dart';
import 'fssai_central_license_screen.dart';
import 'gst_advisory_screen.dart';
import 'gst_revocation_screen.dart';
import 'gst_returns_filing_screen.dart';
import 'gst_annual_return_screen.dart';
import 'gst_notice_reply_screen.dart';
import 'gst_amendment_screen.dart';
import 'gst_final_return_screen.dart';
import 'gst_health_check_screen.dart';
import 'legal_services_screen.dart';
import 'business_registration_screen.dart';
import 'employee_compliance_screen.dart';
import 'income_tax_screen.dart';
import 'iec_screen.dart';
import 'icegate_screen.dart';
import 'apeda_screen.dart';
import 'trade_license_screen.dart';
import 'barcode_registration_screen.dart';
import 'darpan_registration_screen.dart';
import 'iso_screen.dart';
import 'ngo_12a_80g_screen.dart';
import 'accounting_bookkeeping_screen.dart';
import 'tds_returns_screen.dart';
import 'virtual_cfo_screen.dart';

class FssaiScreen extends StatefulWidget {
  const FssaiScreen({super.key});

  @override
  State<FssaiScreen> createState() => _FssaiScreenState();
}

class _FssaiScreenState extends State<FssaiScreen> {
  int _selectedNavIndex = 10;
  int _hoveredCard = -1;
  int _pressedCard = -1;
  bool _hoveringContinue = false;

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    _businessRegScrollController.dispose();
    _tdsFinancialScrollController.dispose();
    super.dispose();
  }

  // ─── FSSAI state ───
  int _fssaiSelectedRadio = 0;

  // ─── GST state ───
  int _gstSelectedCardIndex = 0;
  int _gstHoveredCard = -1;
  int _gstPressedCard = -1;
  bool _gstHoveringContinue = false;

  // ─── Business & Regulatory Regulation state ───
  int _businessRegSelectedCardIndex = 0;
  int _businessRegHoveredCard = -1;
  int _businessRegPressedCard = -1;
  bool _businessRegHoveringContinue = false;
  final ScrollController _businessRegScrollController = ScrollController();

  // ─── TDS & Financial Management state ───
  int _tdsFinancialSelectedCardIndex = 0;
  int _tdsFinancialHoveredCard = -1;
  int _tdsFinancialPressedCard = -1;
  bool _tdsFinancialHoveringContinue = false;
  final ScrollController _tdsFinancialScrollController = ScrollController();

  static const _gstCardData = [
    _GstCardInfo('GST Advisory Service', 'Expert tax guidance & planning', Icons.assistant, Color(0xFF0EA5E9), true),
    _GstCardInfo('GST Revocation', 'Reinstate your GST registration', Icons.restore, Color(0xFFF97316), false),
    _GstCardInfo('GST Returns Filing', 'GSTR-1, GSTR-3B & more', Icons.receipt_long, Color(0xFF10B981), false),
    _GstCardInfo('GST Annual Return', 'GSTR-9 / GSTR-9C filing', Icons.calendar_today, Color(0xFF8B5CF6), false),
    _GstCardInfo('GST Notice Reply', 'Respond to GST notices', Icons.markunread, Color(0xFFEF4444), false),
    _GstCardInfo('GST Amendment', 'Update your GST details', Icons.edit, Color(0xFF3B82F6), false),
    _GstCardInfo('Final Return (GSTR-10)', 'Close your GST account', Icons.cancel, Color(0xFFF59E0B), false),
    _GstCardInfo('GST Health Check', 'Audit your GST compliance', Icons.favorite_border, Color(0xFFEC4899), false),
  ];

  static const _gstDocumentsByCard = [
    [
      'Past GST Returns (GSTR-1, GSTR-3B)',
      'Purchase Invoices',
      'Sales Invoices',
      'Financial Statements (Profit & Loss, Balance Sheet)',
      'Correspondence with GST Authorities',
    ],
    [
      'GST Revocation Notice',
      'Copy of GST Registration Certificate',
      'Financial Statements',
      'Correspondence with GST Authorities',
      'Identity Proof of Authorized Signatory',
    ],
    [
      'Sales Invoices (B2B & B2C)',
      'Purchase Invoices',
      'Debit / Credit Notes',
      'Payment Challans for Tax Deposited',
      'Prior Period Adjustment Entries',
    ],
    [
      'Monthly / Quarterly GST Returns',
      'Reconciliation of ITC',
      'Audited Financial Statements',
      'Bank Statements',
      'Audit Reports (for GSTR-9C)',
    ],
    [
      'GST Notice Copy',
      'Related Invoices or Bills',
      'Previous GST Returns',
      'Bank Statements',
      'Correspondence with GST Department',
    ],
    [
      'Proof of New Address (Electricity Bill / Rent Agreement)',
      'PAN Card (if changing PAN)',
      'Bank Statement / Cancelled Cheque',
      'Identity Proof of Signatory',
      'Board Resolution / Authorization Letter',
    ],
    [
      'Cancellation / Surrender Application Copy',
      'Last Filed GST Returns',
      'Final Sales & Purchase Summary',
      'Payment Challans',
      'Prior Period Adjustments / Corrections',
    ],
    [
      'GST Returns (GSTR-1, GSTR-3B)',
      'Purchase & Sales Ledger',
      'GSTR-2B Statements',
      'Financial Statements',
    ],
  ];

  // ─── Business & Regulatory Registration card data ───
  static const _businessRegCardData = [
    _GstCardInfo('IEC Registration', 'Import Export Code', Icons.assignment, Color(0xFF3B82F6), true),
    _GstCardInfo('ICEGATE Registration', 'Customs gateway', Icons.language, Color(0xFF10B981), false),
    _GstCardInfo('APEDA Registration', 'Agri exports', Icons.agriculture, Color(0xFFF97316), false),
    _GstCardInfo('Trade License', 'Business trade license', Icons.business, Color(0xFF8B5CF6), false),
    _GstCardInfo('Barcode Registration', 'Product barcodes', Icons.qr_code, Color(0xFF10B981), false),
    _GstCardInfo('Darpan Registration', 'NGO Darpan ID', Icons.volunteer_activism, Color(0xFFF59E0B), false),
    _GstCardInfo('ISO Certification', 'Quality standards', Icons.verified, Color(0xFF3B82F6), false),
    _GstCardInfo('NGO 12A & 80G', 'NGO tax exemption', Icons.volunteer_activism, Color(0xFFEC4899), false),
  ];

  static const _businessRegDocumentsByCard = [
    [
      'PAN Card',
      'Aadhaar Card',
      'Address Proof',
      'Bank Certificate / Cancelled Cheque',
      'Business Registration Proof',
    ],
    [
      'IEC Certificate',
      'Digital Signature Certificate',
      'PAN Card',
      'Email ID & Mobile Number',
      'Bank Account Details',
    ],
    [
      'PAN Card',
      'Aadhaar Card',
      'Address Proof',
      'Bank Account Details',
      'Product Details / Export Plan',
    ],
    [
      'PAN Card',
      'Aadhaar Card',
      'Address Proof',
      'Property Tax Receipt',
      'NOC from Landlord',
    ],
    [
      'PAN Card',
      'Aadhaar Card',
      'Business Registration Proof',
      'Product List with Specifications',
      'GST Registration Certificate',
    ],
    [
      'Registration Certificate',
      'Annual Report',
      'PAN Card',
      'Aadhaar Card of Signatory',
      'Audited Financial Statements',
    ],
    [
      'PAN Card',
      'Aadhaar Card',
      'Business Registration Proof',
      'Process Flow Documents',
      'Quality Manual / Policy',
    ],
    [
      'Trust Deed / Society Registration',
      'PAN Card of Trust',
      'Aadhaar Card of Trustees',
      'Registration Certificate',
      'Bank Statements',
      'Annual Report / Activity Report',
    ],
  ];

  // ─── TDS & Financial Management card data ───
  static const _tdsFinancialCardData = [
    _GstCardInfo('Accounting & Bookkeeping', 'Financial record keeping', Icons.book, Color(0xFF3B82F6), true),
    _GstCardInfo('TDS Returns Filing', 'Tax deducted at source', Icons.receipt, Color(0xFFF97316), false),
    _GstCardInfo('Virtual CFO Services', 'CFO advisory & reporting', Icons.query_stats, Color(0xFF8B5CF6), false),
  ];

  static const _tdsFinancialDocumentsByCard = [
    [
      'Bank Statements',
      'Sales & Purchase Invoices',
      'Expense Receipts',
      'Previous Books of Accounts',
      'KYC Documents',
    ],
    [
      'PAN Card',
      'TAN Certificate',
      'TDS Challans / Payment Proof',
      'Form 16 / 16A',
      'Salary Register',
      'Vendor Invoices',
    ],
    [
      'Financial Statements (P&L, Balance Sheet)',
      'Bank Statements',
      'Tax Returns (Last 3 Years)',
      'Business Plan / Projections',
      'KYC of Directors / Partners',
    ],
  ];

  // ─────────────────────────────────────────────
  //  BUILD
  // ─────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      activeNavIndex: _selectedNavIndex,
      onNavChanged: (i) => setState(() => _selectedNavIndex = i),
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (_selectedNavIndex == 10) return _buildFssaiPage();
    if (_selectedNavIndex == 11) return _buildGstPage();
    if (_selectedNavIndex == 12) return const EmployeeComplianceScreen();
    if (_selectedNavIndex == 13) return const LegalServicesScreen();
    if (_selectedNavIndex == 14) return const BusinessRegistrationScreen();
    if (_selectedNavIndex == 15) return const IncomeTaxForm();
    if (_selectedNavIndex == 16) return _buildBusinessRegulatoryPage();
    if (_selectedNavIndex == 17) return _buildTdsFinancialManagementPage();
    return const Center(
      child: Text('Not built yet', style: TextStyle(fontSize: 18, color: AppColors.textMuted)),
    );
  }

  // ─────────────────────────────────────────────
  //  FSSAI PAGE
  // ─────────────────────────────────────────────

  Widget _buildFssaiPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFssaiHeader(),
        const SizedBox(height: 36),
        const Text(
          'Choose your business type',
          style: TextStyle(color: Color(0xFF1E293B), fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 16),
        _buildFssaiRadioSection(),
        const SizedBox(height: 28),
        _buildFssaiDocumentsCard(),
        const SizedBox(height: 36),
        _buildFssaiContinueButton(),
      ],
    );
  }

  Widget _buildFssaiHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.assignment_outlined, color: Color(0xFF3B82F6), size: 40),
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
                          style: TextStyle(color: Color(0xFF000000), fontSize: 28, fontWeight: FontWeight.w800),
                        ),
                        TextSpan(
                          text: 'Registration',
                          style: TextStyle(color: Color(0xFF3B82F6), fontSize: 28, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Expert guidance for your food business licensing and compliance',
                    style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
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
            border: const Border(left: BorderSide(color: Color(0xFF3B82F6), width: 4)),
          ),
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 2),
                child: Icon(Icons.check_box_outlined, color: Color(0xFF3B82F6), size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'GST compliance can be complex and overwhelming for many business owners. The intricate rules and frequent updates make it difficult to stay current and avoid penalties.',
                      style: TextStyle(color: Color(0xFF475569), fontSize: 14, height: 1.45),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(color: Color(0xFF475569), fontSize: 14, height: 1.45, fontFamily: 'Roboto'),
                        children: [
                          TextSpan(text: 'Our service provides '),
                          TextSpan(
                            text: 'expert guidance to simplify the entire process.',
                            style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF1E293B)),
                          ),
                          TextSpan(text: ' We handle the heavy lifting so you can focus on '),
                          TextSpan(
                            text: 'growing your business with peace of mind.',
                            style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF1E293B)),
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

  Widget _buildFssaiRadioSection() {
    return SizedBox(
      height: 180,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: _buildFssaiSelectorCard(
            0, 'Basic Registration', 'Small businesses & startups',
            Icons.storefront_outlined, const Color(0xFF0EA5E9), showRecommended: true,
          )),
          const SizedBox(width: 16),
          Expanded(child: _buildFssaiSelectorCard(
            1, 'State License', 'Mid-size operations',
            Icons.store_outlined, const Color(0xFF10B981),
          )),
          const SizedBox(width: 16),
          Expanded(child: _buildFssaiSelectorCard(
            2, 'Central License', 'Large-scale enterprises',
            Icons.grid_view_outlined, const Color(0xFFF97316),
          )),
        ],
      ),
    );
  }

  Widget _buildFssaiSelectorCard(
    int index,
    String title,
    String subtitle,
    IconData icon,
    Color iconColor, {
    bool showRecommended = false,
  }) {
    final isSelected = _fssaiSelectedRadio == index;
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
    final effectiveIconColor = (isSelected && index == 0) ? Colors.white : iconColor;

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
          setState(() { _pressedCard = -1; _fssaiSelectedRadio = index; });
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
                ? const [BoxShadow(color: Color(0x14000000), blurRadius: 12, offset: Offset(0, 4))]
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
                      style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              Icon(icon, color: effectiveIconColor, size: 22),
              const SizedBox(height: 12),
              Text(title, style: TextStyle(color: titleColor, fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(subtitle, style: TextStyle(color: subtitleColor, fontSize: 13, fontWeight: FontWeight.w400)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFssaiDocumentsCard() {
    final allDocs = [..._getFssaiLeftDocs(), ..._getFssaiRightDocs()];
    final docCount = allDocs.length;
    final licenseName = _getFssaiLicenseLabel();

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
                width: 32, height: 32,
                decoration: const BoxDecoration(color: Color(0xFFEFF6FF), shape: BoxShape.circle),
                child: const Icon(Icons.verified_outlined, color: Color(0xFF3B82F6), size: 18),
              ),
              const SizedBox(width: 12),
              Text(
                'Required documents — $licenseName License',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: const BoxDecoration(color: Color(0xFFEFF6FF), borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text('$docCount documents',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF3B82F6)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildFssaiDocGrid(),
        ],
      ),
    );
  }

  Widget _buildFssaiDocGrid() {
    final leftDocs = _getFssaiLeftDocs();
    final rightDocs = _getFssaiRightDocs();
    final maxRows = leftDocs.length > rightDocs.length ? leftDocs.length : rightDocs.length;
    return Column(
      children: List.generate(maxRows, (i) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              if (i < leftDocs.length) Expanded(child: _buildFssaiDocTile(leftDocs[i]))
              else const Expanded(child: SizedBox()),
              const SizedBox(width: 10),
              if (i < rightDocs.length) Expanded(child: _buildFssaiDocTile(rightDocs[i]))
              else const Expanded(child: SizedBox()),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildFssaiDocTile(String name) {
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
            width: 26, height: 26,
            decoration: const BoxDecoration(color: Color(0xFFEFF6FF), shape: BoxShape.circle),
            child: const Icon(Icons.check, color: Color(0xFF3B82F6), size: 14),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(name,
            style: const TextStyle(color: Color(0xFF475569), fontSize: 13.5, fontWeight: FontWeight.w400),
          )),
        ],
      ),
    );
  }

  String _getFssaiLicenseLabel() {
    switch (_fssaiSelectedRadio) {
      case 0: return 'Basic';
      case 1: return 'State';
      case 2: return 'Central';
      default: return '';
    }
  }

  List<String> _getFssaiLeftDocs() {
    switch (_fssaiSelectedRadio) {
      case 0: return ['Aadhaar Card', 'PAN Card', 'Photograph of Proprietor', 'Company register certificate'];
      case 1: return ['Partner-Specific Document', 'Business information', 'Aadhar Card', 'Company register certificate', 'PAN Card'];
      case 2: return ['Company information', 'Director information', 'Contact details', 'Business details'];
      default: return [];
    }
  }

  List<String> _getFssaiRightDocs() {
    switch (_fssaiSelectedRadio) {
      case 0: return ['Property document', 'Electricity bill', 'Property tax receipt'];
      case 1: return ['Company PAN Card', 'Photograph', 'Company Seal', 'Property document'];
      case 2: return ['Property document', 'Electricity bill', 'Property tax receipt', 'MOA / AOA'];
      default: return [];
    }
  }

  Widget _buildFssaiContinueButton() {
    return Center(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hoveringContinue = true),
        onExit: (_) => setState(() => _hoveringContinue = false),
        child: GestureDetector(
          onTap: () {
            Widget nextScreen;
            switch (_fssaiSelectedRadio) {
              case 1: nextScreen = const FssaiStateLicenseScreen(); break;
              case 2: nextScreen = const FssaiCentralLicenseScreen(); break;
              default: nextScreen = const FssaiBasicRegistrationScreen();
            }
            _showUserDetailsDialog(context, (context) => nextScreen);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 280,
            height: 54,
            decoration: BoxDecoration(
              color: _hoveringContinue ? const Color(0xFF3D4F72) : const Color(0xFF2E3A59),
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
                  switch (_fssaiSelectedRadio) {
                    case 1: nextScreen = const FssaiStateLicenseScreen(); break;
                    case 2: nextScreen = const FssaiCentralLicenseScreen(); break;
                    default: nextScreen = const FssaiBasicRegistrationScreen();
                  }
                  _showUserDetailsDialog(context, (context) => nextScreen);
                },
                child: const Center(
                  child: Text('Continue',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 0.3),
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
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return Dialog(
          backgroundColor: AppColors.bgCard,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 8,
          shadowColor: const Color(0x1F000000),
          child: SizedBox(
            width: 520,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text('User Details',
                      style: TextStyle(color: Color(0xFF1A1F2E), fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const Divider(height: 24, color: AppColors.border),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildDialogField('User Name', 'Enter your name', 'User-name is required.')),
                      const SizedBox(width: 20),
                      Expanded(child: _buildDialogField('Mobile Number', 'Enter Mobile Number', 'Please enter mobile number.')),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildDialogField('Mail Address', 'Enter Mail Address', 'Please enter mail address.'),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        Navigator.of(context).push(MaterialPageRoute(builder: nextScreenBuilder));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.brandBlue,
                        foregroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        elevation: 0,
                      ),
                      child: const Text('Submit', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDialogField(String label, String hint, String error) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        SizedBox(
          height: 48,
          child: TextField(
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
        const SizedBox(height: 6),
      ],
    );
  }

  // ─────────────────────────────────────────────
  //  GST PAGE
  // ─────────────────────────────────────────────

  Widget _buildGstPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildGstHeader(),
        const SizedBox(height: 36),
        _buildGstCardsSection(),
        const SizedBox(height: 28),
        if (_gstSelectedCardIndex >= 0) _buildGstDocumentsCard(),
        if (_gstSelectedCardIndex >= 0) ...[
          const SizedBox(height: 36),
          _buildGstContinueButton(),
        ],
        const SizedBox(height: 36),
      ],
    );
  }

  Widget _buildGstHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.assignment_outlined, color: Color(0xFF3B82F6), size: 40),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'GST ',
                          style: TextStyle(color: Color(0xFF000000), fontSize: 28, fontWeight: FontWeight.w800),
                        ),
                        TextSpan(
                          text: 'Services',
                          style: TextStyle(color: Color(0xFF3B82F6), fontSize: 28, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Expert guidance for your GST compliance and filing needs',
                    style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
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
            border: const Border(left: BorderSide(color: Color(0xFF3B82F6), width: 4)),
          ),
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 2),
                child: Icon(Icons.check_box_outlined, color: Color(0xFF3B82F6), size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'GST compliance can be complex and overwhelming for many business owners. The intricate rules and frequent updates make it difficult to stay current and avoid penalties.',
                      style: TextStyle(color: Color(0xFF475569), fontSize: 14, height: 1.45),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(color: Color(0xFF475569), fontSize: 14, height: 1.45, fontFamily: 'Roboto'),
                        children: [
                          TextSpan(text: 'Our service provides '),
                          TextSpan(
                            text: 'expert guidance to simplify the entire process.',
                            style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF1E293B)),
                          ),
                          TextSpan(text: ' We handle the heavy lifting so you can focus on '),
                          TextSpan(
                            text: 'growing your business with peace of mind.',
                            style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF1E293B)),
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

  Widget _buildGstCardsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choose your business type',
          style: TextStyle(color: Color(0xFF1E293B), fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 180,
          child: Row(
            children: [
              _buildGstArrowButton(Icons.chevron_left, () {
                final offset = _scrollController.offset;
                _scrollController.animateTo(
                  (offset - 280).clamp(0.0, _scrollController.position.maxScrollExtent),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }),
              const SizedBox(width: 8),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: List.generate(_gstCardData.length, (i) {
                      return Padding(
                        padding: EdgeInsets.only(right: i < _gstCardData.length - 1 ? 16 : 0),
                        child: SizedBox(
                          width: 248,
                          child: _buildGstServiceCard(i),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              _buildGstArrowButton(Icons.chevron_right, () {
                final offset = _scrollController.offset;
                _scrollController.animateTo(
                  (offset + 280).clamp(0.0, _scrollController.position.maxScrollExtent),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGstArrowButton(IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          width: 40, height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 8, offset: Offset(0, 2))],
          ),
          child: Icon(icon, color: const Color(0xFF475569), size: 22),
        ),
      ),
    );
  }

  Widget _buildGstServiceCard(int index) {
    final card = _gstCardData[index];
    final isSelected = _gstSelectedCardIndex == index;
    final isHovered = _gstHoveredCard == index;
    final isPressed = _gstPressedCard == index;

    final bgColor = isSelected ? const Color(0xFF2D3A6B) : Colors.white;
    final borderColor = isSelected
        ? const Color(0xFF2D3A6B)
        : (isHovered ? const Color(0xFFCBD5E1) : const Color(0xFFE2E8F0));
    final titleColor = isSelected ? Colors.white : const Color(0xFF1E293B);
    final subtitleColor = isSelected ? Colors.white.withAlpha(166) : const Color(0xFF94A3B8);
    final effectiveIconColor = isSelected ? Colors.white : card.color;

    Matrix4 getTransform() {
      if (isPressed) return Matrix4.diagonal3Values(0.97, 0.97, 1.0);
      return Matrix4.identity();
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _gstHoveredCard = index),
      onExit: (_) => setState(() => _gstHoveredCard = -1),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _gstPressedCard = index),
        onTapUp: (_) {
          setState(() { _gstPressedCard = -1; _gstSelectedCardIndex = index; });
        },
        onTapCancel: () => setState(() => _gstPressedCard = -1),
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
                ? const [BoxShadow(color: Color(0x14000000), blurRadius: 12, offset: Offset(0, 4))]
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (card.showRecommended)
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF59E0B),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Text('Recommended',
                      style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              else
                const SizedBox(height: 22),
              const SizedBox(height: 12),
              Icon(card.icon, color: effectiveIconColor, size: 22),
              const SizedBox(height: 12),
              Text(card.title,
                style: TextStyle(color: titleColor, fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(card.subtitle,
                style: TextStyle(color: subtitleColor, fontSize: 13, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGstDocumentsCard() {
    final docs = _gstDocumentsByCard[_gstSelectedCardIndex];
    final List<String> leftDocs = docs.length > 2 ? docs.sublist(0, (docs.length + 1) ~/ 2) : [docs[0]];
    final List<String> rightDocs = docs.length > 2 ? docs.sublist((docs.length + 1) ~/ 2) : (docs.length > 1 ? [docs[1]] : <String>[]);

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
                width: 32, height: 32,
                decoration: const BoxDecoration(color: Color(0xFFEFF6FF), shape: BoxShape.circle),
                child: const Icon(Icons.verified_outlined, color: Color(0xFF3B82F6), size: 18),
              ),
              const SizedBox(width: 12),
              Text(
                'Required documents — ${_gstCardData[_gstSelectedCardIndex].title}',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: const BoxDecoration(color: Color(0xFFEFF6FF), borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text('${docs.length} documents',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF3B82F6)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildGstDocGrid(leftDocs, rightDocs),
        ],
      ),
    );
  }

  Widget _buildGstDocGrid(List<String> leftDocs, List<String> rightDocs) {
    final maxRows = leftDocs.length > rightDocs.length ? leftDocs.length : rightDocs.length;
    return Column(
      children: List.generate(maxRows, (i) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              if (i < leftDocs.length) Expanded(child: _buildGstDocTile(leftDocs[i]))
              else const Expanded(child: SizedBox()),
              const SizedBox(width: 10),
              if (i < rightDocs.length) Expanded(child: _buildGstDocTile(rightDocs[i]))
              else const Expanded(child: SizedBox()),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildGstDocTile(String name) {
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
            width: 26, height: 26,
            decoration: const BoxDecoration(color: Color(0xFFEFF6FF), shape: BoxShape.circle),
            child: const Icon(Icons.check, color: Color(0xFF3B82F6), size: 14),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(name,
            style: const TextStyle(color: Color(0xFF475569), fontSize: 13.5, fontWeight: FontWeight.w400),
          )),
        ],
      ),
    );
  }

  Widget _buildGstContinueButton() {
    return Center(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _gstHoveringContinue = true),
        onExit: (_) => setState(() => _gstHoveringContinue = false),
        child: GestureDetector(
          onTap: () {
            Widget nextScreen;
            switch (_gstSelectedCardIndex) {
              case 0: nextScreen = const GstAdvisoryScreen(); break;
              case 1: nextScreen = const GstRevocationScreen(); break;
              case 2: nextScreen = const GstReturnsFilingScreen(); break;
              case 3: nextScreen = const GstAnnualReturnScreen(); break;
              case 4: nextScreen = const GstNoticeReplyScreen(); break;
              case 5: nextScreen = const GstAmendmentScreen(); break;
              case 6: nextScreen = const GstFinalReturnScreen(); break;
              case 7: nextScreen = const GstHealthCheckScreen(); break;
              default: return;
            }
            _showUserDetailsDialog(context, (context) => nextScreen);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 280,
            height: 54,
            decoration: BoxDecoration(
              color: _gstHoveringContinue ? const Color(0xFF3D4F72) : const Color(0xFF2E3A59),
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
                  switch (_gstSelectedCardIndex) {
                    case 0: nextScreen = const GstAdvisoryScreen(); break;
                    case 1: nextScreen = const GstRevocationScreen(); break;
                    case 2: nextScreen = const GstReturnsFilingScreen(); break;
                    case 3: nextScreen = const GstAnnualReturnScreen(); break;
                    case 4: nextScreen = const GstNoticeReplyScreen(); break;
                    case 5: nextScreen = const GstAmendmentScreen(); break;
                    case 6: nextScreen = const GstFinalReturnScreen(); break;
                    case 7: nextScreen = const GstHealthCheckScreen(); break;
                    default: return;
                  }
                  _showUserDetailsDialog(context, (context) => nextScreen);
                },
                child: const Center(
                  child: Text('Continue',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 0.3),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  //  BUSINESS & REGULATORY REGISTRATION PAGE  (index 16)
  // ---------------------------------------------------------------------------

  Widget _buildBusinessRegulatoryPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBusinessRegHeader(),
        const SizedBox(height: 36),
        _buildBusinessRegCardsSection(),
        const SizedBox(height: 28),
        if (_businessRegSelectedCardIndex >= 0) _buildBusinessRegDocumentsCard(),
        if (_businessRegSelectedCardIndex >= 0) ...[
          const SizedBox(height: 36),
          _buildBusinessRegContinueButton(),
        ],
        const SizedBox(height: 36),
      ],
    );
  }

  Widget _buildBusinessRegHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.assignment_outlined, color: Color(0xFF3B82F6), size: 40),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Business & Regulatory ',
                          style: TextStyle(color: Color(0xFF000000), fontSize: 28, fontWeight: FontWeight.w800),
                        ),
                        TextSpan(
                          text: 'Registration',
                          style: TextStyle(color: Color(0xFF3B82F6), fontSize: 28, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Complete compliance and registration services for your business',
                    style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
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
            border: const Border(left: BorderSide(color: Color(0xFF3B82F6), width: 4)),
          ),
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 2),
                child: Icon(Icons.check_box_outlined, color: Color(0xFF3B82F6), size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Navigating business registrations and regulatory compliance can be complex. From import-export codes to NGO registrations, each process has specific requirements.',
                      style: TextStyle(color: Color(0xFF475569), fontSize: 14, height: 1.45),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(color: Color(0xFF475569), fontSize: 14, height: 1.45, fontFamily: 'Roboto'),
                        children: [
                          TextSpan(text: 'Our service covers '),
                          TextSpan(
                            text: 'all major business registrations',
                            style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF1E293B)),
                          ),
                          TextSpan(text: ' under one roof. We handle the paperwork so you can '),
                          TextSpan(
                            text: 'focus on growing your business.',
                            style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF1E293B)),
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

  Widget _buildBusinessRegCardsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choose your service',
          style: TextStyle(color: Color(0xFF1E293B), fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 180,
          child: Row(
            children: [
              _buildGstArrowButton(Icons.chevron_left, () {
                final offset = _businessRegScrollController.offset;
                _businessRegScrollController.animateTo(
                  (offset - 280).clamp(0.0, _businessRegScrollController.position.maxScrollExtent),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }),
              const SizedBox(width: 8),
              Expanded(
                child: SingleChildScrollView(
                  controller: _businessRegScrollController,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: List.generate(_businessRegCardData.length, (i) {
                      return Padding(
                        padding: EdgeInsets.only(right: i < _businessRegCardData.length - 1 ? 16 : 0),
                        child: SizedBox(
                          width: 248,
                          child: _buildRegServiceCard(i),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              _buildGstArrowButton(Icons.chevron_right, () {
                final offset = _businessRegScrollController.offset;
                _businessRegScrollController.animateTo(
                  (offset + 280).clamp(0.0, _businessRegScrollController.position.maxScrollExtent),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRegServiceCard(int index) {
    final card = _businessRegCardData[index];
    final isSelected = _businessRegSelectedCardIndex == index;
    final isHovered = _businessRegHoveredCard == index;
    final isPressed = _businessRegPressedCard == index;

    final bgColor = isSelected ? const Color(0xFF2D3A6B) : Colors.white;
    final borderColor = isSelected
        ? const Color(0xFF2D3A6B)
        : (isHovered ? const Color(0xFFCBD5E1) : const Color(0xFFE2E8F0));
    final titleColor = isSelected ? Colors.white : const Color(0xFF1E293B);
    final subtitleColor = isSelected ? Colors.white.withAlpha(166) : const Color(0xFF94A3B8);
    final effectiveIconColor = isSelected ? Colors.white : card.color;

    Matrix4 getTransform() {
      if (isPressed) return Matrix4.diagonal3Values(0.97, 0.97, 1.0);
      return Matrix4.identity();
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _businessRegHoveredCard = index),
      onExit: (_) => setState(() => _businessRegHoveredCard = -1),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _businessRegPressedCard = index),
        onTapUp: (_) {
          setState(() { _businessRegPressedCard = -1; _businessRegSelectedCardIndex = index; });
        },
        onTapCancel: () => setState(() => _businessRegPressedCard = -1),
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
                ? const [BoxShadow(color: Color(0x14000000), blurRadius: 12, offset: Offset(0, 4))]
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (card.showRecommended)
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF59E0B),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Text('Recommended',
                      style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              else
                const SizedBox(height: 22),
              const SizedBox(height: 12),
              Icon(card.icon, color: effectiveIconColor, size: 22),
              const SizedBox(height: 12),
              Text(card.title,
                style: TextStyle(color: titleColor, fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(card.subtitle,
                style: TextStyle(color: subtitleColor, fontSize: 13, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBusinessRegDocumentsCard() {
    final docs = _businessRegDocumentsByCard[_businessRegSelectedCardIndex];
    final List<String> leftDocs = docs.length > 2 ? docs.sublist(0, (docs.length + 1) ~/ 2) : [docs[0]];
    final List<String> rightDocs = docs.length > 2 ? docs.sublist((docs.length + 1) ~/ 2) : (docs.length > 1 ? [docs[1]] : <String>[]);

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
                width: 32, height: 32,
                decoration: const BoxDecoration(color: Color(0xFFEFF6FF), shape: BoxShape.circle),
                child: const Icon(Icons.verified_outlined, color: Color(0xFF3B82F6), size: 18),
              ),
              const SizedBox(width: 12),
              Text(
                'Required documents — ${_businessRegCardData[_businessRegSelectedCardIndex].title}',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: const BoxDecoration(color: Color(0xFFEFF6FF), borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text('${docs.length} documents',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF3B82F6)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildGstDocGrid(leftDocs, rightDocs),
        ],
      ),
    );
  }

  Widget _buildBusinessRegContinueButton() {
    return Center(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _businessRegHoveringContinue = true),
        onExit: (_) => setState(() => _businessRegHoveringContinue = false),
        child: GestureDetector(
          onTap: () {
            Widget nextScreen;
            switch (_businessRegSelectedCardIndex) {
              case 0: nextScreen = const IecScreen(); break;
              case 1: nextScreen = const IcegateScreen(); break;
              case 2: nextScreen = const ApedaScreen(); break;
              case 3: nextScreen = const TradeLicenseScreen(); break;
              case 4: nextScreen = const BarcodeRegistrationScreen(); break;
              case 5: nextScreen = const DarpanRegistrationScreen(); break;
              case 6: nextScreen = const IsoScreen(); break;
              case 7: nextScreen = const NGO12A80GScreen(); break;
              default: return;
            }
            _showUserDetailsDialog(context, (context) => nextScreen);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 280,
            height: 54,
            decoration: BoxDecoration(
              color: _businessRegHoveringContinue ? const Color(0xFF3D4F72) : const Color(0xFF2E3A59),
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
                  switch (_businessRegSelectedCardIndex) {
                    case 0: nextScreen = const IecScreen(); break;
                    case 1: nextScreen = const IcegateScreen(); break;
                    case 2: nextScreen = const ApedaScreen(); break;
                    case 3: nextScreen = const TradeLicenseScreen(); break;
                    case 4: nextScreen = const BarcodeRegistrationScreen(); break;
                    case 5: nextScreen = const DarpanRegistrationScreen(); break;
                    case 6: nextScreen = const IsoScreen(); break;
                    case 7: nextScreen = const NGO12A80GScreen(); break;
                    default: return;
                  }
                  _showUserDetailsDialog(context, (context) => nextScreen);
                },
                child: const Center(
                  child: Text('Continue',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 0.3),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  //  TDS & FINANCIAL MANAGEMENT PAGE  (index 17)
  // ---------------------------------------------------------------------------

  Widget _buildTdsFinancialManagementPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTdsFinancialHeader(),
        const SizedBox(height: 36),
        _buildTdsFinancialCardsSection(),
        const SizedBox(height: 28),
        if (_tdsFinancialSelectedCardIndex >= 0) _buildTdsFinancialDocumentsCard(),
        if (_tdsFinancialSelectedCardIndex >= 0) ...[
          const SizedBox(height: 36),
          _buildTdsFinancialContinueButton(),
        ],
        const SizedBox(height: 36),
      ],
    );
  }

  Widget _buildTdsFinancialHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.trending_up, color: Color(0xFF3B82F6), size: 40),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'TDS & Financial ',
                          style: TextStyle(color: Color(0xFF000000), fontSize: 28, fontWeight: FontWeight.w800),
                        ),
                        TextSpan(
                          text: 'Management',
                          style: TextStyle(color: Color(0xFF3B82F6), fontSize: 28, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Expert financial management and TDS compliance services',
                    style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
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
            border: const Border(left: BorderSide(color: Color(0xFF3B82F6), width: 4)),
          ),
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 2),
                child: Icon(Icons.check_box_outlined, color: Color(0xFF3B82F6), size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Managing finances and tax deductions can be time-consuming for business owners. From bookkeeping to TDS returns, staying compliant requires expertise.',
                      style: TextStyle(color: Color(0xFF475569), fontSize: 14, height: 1.45),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(color: Color(0xFF475569), fontSize: 14, height: 1.45, fontFamily: 'Roboto'),
                        children: [
                          TextSpan(text: 'Our services cover '),
                          TextSpan(
                            text: 'end-to-end financial management',
                            style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF1E293B)),
                          ),
                          TextSpan(text: ' and TDS compliance. We ensure your '),
                          TextSpan(
                            text: 'books are accurate and filings are on time.',
                            style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF1E293B)),
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

  Widget _buildTdsFinancialCardsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choose your service',
          style: TextStyle(color: Color(0xFF1E293B), fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 180,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: _buildTdsServiceCard(0)),
              const SizedBox(width: 16),
              Expanded(child: _buildTdsServiceCard(1)),
              const SizedBox(width: 16),
              Expanded(child: _buildTdsServiceCard(2)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTdsServiceCard(int index) {
    final card = _tdsFinancialCardData[index];
    final isSelected = _tdsFinancialSelectedCardIndex == index;
    final isHovered = _tdsFinancialHoveredCard == index;
    final isPressed = _tdsFinancialPressedCard == index;

    final bgColor = isSelected ? const Color(0xFF2D3A6B) : Colors.white;
    final borderColor = isSelected
        ? const Color(0xFF2D3A6B)
        : (isHovered ? const Color(0xFFCBD5E1) : const Color(0xFFE2E8F0));
    final titleColor = isSelected ? Colors.white : const Color(0xFF1E293B);
    final subtitleColor = isSelected ? Colors.white.withAlpha(166) : const Color(0xFF94A3B8);
    final effectiveIconColor = isSelected ? Colors.white : card.color;

    Matrix4 getTransform() {
      if (isPressed) return Matrix4.diagonal3Values(0.97, 0.97, 1.0);
      return Matrix4.identity();
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _tdsFinancialHoveredCard = index),
      onExit: (_) => setState(() => _tdsFinancialHoveredCard = -1),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _tdsFinancialPressedCard = index),
        onTapUp: (_) {
          setState(() { _tdsFinancialPressedCard = -1; _tdsFinancialSelectedCardIndex = index; });
        },
        onTapCancel: () => setState(() => _tdsFinancialPressedCard = -1),
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
                ? const [BoxShadow(color: Color(0x14000000), blurRadius: 12, offset: Offset(0, 4))]
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (card.showRecommended)
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF59E0B),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Text('Recommended',
                      style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              else
                const SizedBox(height: 22),
              const SizedBox(height: 12),
              Icon(card.icon, color: effectiveIconColor, size: 22),
              const SizedBox(height: 12),
              Text(card.title,
                style: TextStyle(color: titleColor, fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(card.subtitle,
                style: TextStyle(color: subtitleColor, fontSize: 13, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTdsFinancialDocumentsCard() {
    final docs = _tdsFinancialDocumentsByCard[_tdsFinancialSelectedCardIndex];
    final List<String> leftDocs = docs.length > 2 ? docs.sublist(0, (docs.length + 1) ~/ 2) : [docs[0]];
    final List<String> rightDocs = docs.length > 2 ? docs.sublist((docs.length + 1) ~/ 2) : (docs.length > 1 ? [docs[1]] : <String>[]);

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
                width: 32, height: 32,
                decoration: const BoxDecoration(color: Color(0xFFEFF6FF), shape: BoxShape.circle),
                child: const Icon(Icons.verified_outlined, color: Color(0xFF3B82F6), size: 18),
              ),
              const SizedBox(width: 12),
              Text(
                'Required documents — ${_tdsFinancialCardData[_tdsFinancialSelectedCardIndex].title}',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: const BoxDecoration(color: Color(0xFFEFF6FF), borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text('${docs.length} documents',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF3B82F6)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildGstDocGrid(leftDocs, rightDocs),
        ],
      ),
    );
  }

  Widget _buildTdsFinancialContinueButton() {
    return Center(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _tdsFinancialHoveringContinue = true),
        onExit: (_) => setState(() => _tdsFinancialHoveringContinue = false),
        child: GestureDetector(
          onTap: () {
            Widget nextScreen;
            switch (_tdsFinancialSelectedCardIndex) {
              case 0: nextScreen = const AccountingBookkeepingScreen(); break;
              case 1: nextScreen = const TDSReturnsScreen(); break;
              case 2: nextScreen = const VirtualCFOScreen(); break;
              default: return;
            }
            _showUserDetailsDialog(context, (context) => nextScreen);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 280,
            height: 54,
            decoration: BoxDecoration(
              color: _tdsFinancialHoveringContinue ? const Color(0xFF3D4F72) : const Color(0xFF2E3A59),
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
                  switch (_tdsFinancialSelectedCardIndex) {
                    case 0: nextScreen = const AccountingBookkeepingScreen(); break;
                    case 1: nextScreen = const TDSReturnsScreen(); break;
                    case 2: nextScreen = const VirtualCFOScreen(); break;
                    default: return;
                  }
                  _showUserDetailsDialog(context, (context) => nextScreen);
                },
                child: const Center(
                  child: Text('Continue',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 0.3),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GstCardInfo {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final bool showRecommended;

  const _GstCardInfo(this.title, this.subtitle, this.icon, this.color, this.showRecommended);
}

