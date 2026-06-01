import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../theme/app_theme.dart';

class GstFormTitle extends StatelessWidget {
  final String title;
  const GstFormTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF1A1F2E),
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class GstBreadcrumb extends StatelessWidget {
  final String path;
  const GstBreadcrumb({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Text(
      path,
      style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
    );
  }
}

class GstFormCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  const GstFormCard({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: const Color(0xFF64748B)),
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
          const SizedBox(height: 12),
          Container(height: 1, color: const Color(0xFFF1F5F9)),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }
}

Widget _buildLabel(String text, bool required) {
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: text,
          style: const TextStyle(
            color: Color(0xFF374151),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        if (required)
          const TextSpan(
            text: ' *',
            style: TextStyle(color: Color(0xFFEF4444), fontSize: 13),
          ),
      ],
    ),
  );
}

class GstTextField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final bool required;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? errorText;
  final TextInputType keyboardType;
  final int maxLength;
  final ValueChanged<String>? onChanged;

  const GstTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.controller,
    this.required = false,
    this.validator,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.maxLength = 1000,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label, required),
        const SizedBox(height: 6),
        SizedBox(
          height: 44,
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            maxLength: maxLength,
            onChanged: onChanged,
            decoration: InputDecoration(
              counterText: '',
              prefixIcon: Icon(icon, size: 16, color: const Color(0xFF94A3B8)),
              hintText: hint.isEmpty ? null : hint,
              hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Color(0xFF94A3B8)),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Color(0xFFEF4444)),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Color(0xFFEF4444)),
              ),
              filled: true,
              fillColor: Colors.white,
              errorText: errorText,
              errorStyle: const TextStyle(color: Color(0xFFEF4444), fontSize: 12),
            ),
            style: const TextStyle(fontSize: 14, color: Color(0xFF374151)),
            validator: validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ),
      ],
    );
  }
}

class GstDropdownField extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool required;
  final String? value;
  final String placeholder;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String? errorText;

  const GstDropdownField({
    super.key,
    required this.label,
    required this.icon,
    required this.items,
    required this.onChanged,
    this.required = false,
    this.value,
    this.placeholder = 'Select...',
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label, required),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: errorText != null ? const Color(0xFFEF4444) : const Color(0xFFE2E8F0),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF94A3B8), size: 22),
              hint: Row(
                children: [
                  Icon(icon, size: 16, color: const Color(0xFF94A3B8)),
                  const SizedBox(width: 10),
                  Text(
                    placeholder,
                    style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
                  ),
                ],
              ),
              items: items.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Row(
                    children: [
                      Icon(icon, size: 16, color: const Color(0xFF94A3B8)),
                      const SizedBox(width: 10),
                      Text(item, style: const TextStyle(fontSize: 14, color: Color(0xFF374151))),
                    ],
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 14),
            child: Text(
              errorText!,
              style: const TextStyle(color: Color(0xFFEF4444), fontSize: 12),
            ),
          ),
      ],
    );
  }
}

class GstFileField extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool required;
  final String? fileName;
  final ValueChanged<String> onFilePicked;
  final String? errorText;
  final String acceptText;
  final double maxSizeMB;

  const GstFileField({
    super.key,
    required this.label,
    required this.icon,
    required this.onFilePicked,
    this.required = false,
    this.fileName,
    this.errorText,
    this.acceptText = 'PDF, JPG, PNG, XLSX',
    this.maxSizeMB = 10,
  });

  @override
  State<GstFileField> createState() => _GstFileFieldState();
}

class _GstFileFieldState extends State<GstFileField> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(widget.label, widget.required),
        const SizedBox(height: 6),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: GestureDetector(
            onTap: _pickFile,
            child: Container(
              width: double.infinity,
              height: 44,
              decoration: BoxDecoration(
                color: _isHovered ? const Color(0xFFF1F4F8) : Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: hasError ? const Color(0xFFEF4444) : const Color(0xFFE2E8F0),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: _isHovered ? const Color(0xFFB8BFC9) : const Color(0xFFD1D5DB),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                      ),
                      border: const Border(
                        right: BorderSide(color: Color(0xFFCBD5E1)),
                      ),
                    ),
                    child: Icon(widget.icon, size: 18, color: const Color(0xFF6B7280)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.fileName ?? 'No file chosen',
                      style: TextStyle(
                        color: widget.fileName != null ? const Color(0xFF475569) : const Color(0xFF9CA3AF),
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
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            widget.acceptText,
            style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 11),
          ),
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              widget.errorText!,
              style: const TextStyle(color: Color(0xFFEF4444), fontSize: 12),
            ),
          ),
      ],
    );
  }

  Widget _buildLabel(String text, bool required) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: const TextStyle(
              color: Color(0xFF374151),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (required)
            const TextSpan(
              text: ' *',
              style: TextStyle(color: Color(0xFFEF4444), fontSize: 13),
            ),
        ],
      ),
    );
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.isNotEmpty) {
      final name = result.files.single.name;
      widget.onFilePicked(name);
    }
  }
}

class GstTextareaField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final bool required;
  final TextEditingController controller;
  final int maxChars;
  final String? Function(String?)? validator;
  final String? errorText;

  const GstTextareaField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.controller,
    this.required = false,
    this.maxChars = 500,
    this.validator,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label, required),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          maxLines: 4,
          maxLength: maxChars,
          decoration: InputDecoration(
            counterText: '',
            hintText: hint.isEmpty ? null : hint,
            hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xFF94A3B8)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xFFEF4444)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xFFEF4444)),
            ),
            filled: true,
            fillColor: Colors.white,
            errorText: errorText,
            errorStyle: const TextStyle(color: Color(0xFFEF4444), fontSize: 12),
          ),
          style: const TextStyle(fontSize: 14, color: Color(0xFF374151)),
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${controller.text.length} / $maxChars',
              style: TextStyle(
                color: controller.text.length > maxChars ? const Color(0xFFEF4444) : const Color(0xFF94A3B8),
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class GstMultiSelectField extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool required;
  final List<String> options;
  final List<String> selectedValues;
  final ValueChanged<List<String>> onChanged;
  final String? errorText;

  const GstMultiSelectField({
    super.key,
    required this.label,
    required this.icon,
    required this.options,
    required this.selectedValues,
    required this.onChanged,
    this.required = false,
    this.errorText,
  });

  @override
  State<GstMultiSelectField> createState() => _GstMultiSelectFieldState();
}

class _GstMultiSelectFieldState extends State<GstMultiSelectField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(widget.label, widget.required),
        const SizedBox(height: 8),
        ...widget.options.map((option) {
          final isSelected = widget.selectedValues.contains(option);
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: InkWell(
              onTap: () {
                final updated = List<String>.from(widget.selectedValues);
                if (isSelected) {
                  updated.remove(option);
                } else {
                  updated.add(option);
                }
                widget.onChanged(updated);
              },
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Checkbox(
                      value: isSelected,
                      onChanged: (v) {
                        final updated = List<String>.from(widget.selectedValues);
                        if (v == true) {
                          updated.add(option);
                        } else {
                          updated.remove(option);
                        }
                        widget.onChanged(updated);
                      },
                      activeColor: AppColors.brandBlue,
                      side: const BorderSide(color: Color(0xFFE2E8F0)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      option,
                      style: const TextStyle(
                        color: Color(0xFF475569),
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
        if (widget.errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              widget.errorText!,
              style: const TextStyle(color: Color(0xFFEF4444), fontSize: 12),
            ),
          ),
      ],
    );
  }

  Widget _buildLabel(String text, bool required) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: const TextStyle(
              color: Color(0xFF374151),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (required)
            const TextSpan(
              text: ' *',
              style: TextStyle(color: Color(0xFFEF4444), fontSize: 13),
            ),
        ],
      ),
    );
  }
}

class GstSubmitButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const GstSubmitButton({super.key, required this.onPressed, this.label = 'Submit'});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.brandBlue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
          ),
          child: Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

void showLegalSuccessDialog(BuildContext context, String serviceName) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          width: 420,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          decoration: BoxDecoration(
            color: AppColors.bgCard,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  color: Color(0xFF22C55E),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 32),
              ),
              const SizedBox(height: 20),
              const Text(
                'Application Submitted!',
                style: TextStyle(
                  color: Color(0xFF1A1F2E),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'We have received your $serviceName request. Our team will review and get back to you shortly.',
                style: const TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.brandBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Back to Legal Services',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showBusinessSuccessDialog(BuildContext context, String serviceName) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          width: 420,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          decoration: BoxDecoration(
            color: AppColors.bgCard,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  color: Color(0xFF22C55E),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 32),
              ),
              const SizedBox(height: 20),
              const Text(
                'Application Submitted!',
                style: TextStyle(
                  color: Color(0xFF1A1F2E),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'We have received your $serviceName request. Our team will review and get back to you shortly.',
                style: const TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.brandBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Back to Business Registration',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showGstSuccessDialog(BuildContext context, String serviceName) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          width: 420,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          decoration: BoxDecoration(
            color: AppColors.bgCard,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  color: Color(0xFF22C55E),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 32),
              ),
              const SizedBox(height: 20),
              const Text(
                'Application Submitted!',
                style: TextStyle(
                  color: Color(0xFF1A1F2E),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'We have received your $serviceName request. Our team will review and get back to you shortly.',
                style: const TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.brandBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Back to GST Services',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _userDetailsField(String label, String hint) {
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
    ],
  );
}

void showUserDetailsDialog(BuildContext context, WidgetBuilder nextScreenBuilder) {
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
                    Expanded(child: _userDetailsField('User Name', 'Enter your name')),
                    const SizedBox(width: 20),
                    Expanded(child: _userDetailsField('Mobile Number', 'Enter Mobile Number')),
                  ],
                ),
                const SizedBox(height: 16),
                _userDetailsField('Mail Address', 'Enter Mail Address'),
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
