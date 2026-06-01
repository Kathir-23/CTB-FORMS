import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FormCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const FormCard({
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

class FormTextField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final String? helperText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const FormTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    this.helperText,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final hasAsterisk = label.endsWith('*');
    final cleanLabel = hasAsterisk ? label.substring(0, label.length - 1) : label;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(cleanLabel, hasAsterisk),
        const SizedBox(height: 6),
        SizedBox(
          height: 44,
          child: TextFormField(
            controller: controller,
            validator: validator,
            decoration: InputDecoration(
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
              filled: true,
              fillColor: Colors.white,
            ),
            style: const TextStyle(fontSize: 14, color: Color(0xFF374151)),
          ),
        ),
        if (helperText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              helperText!,
              style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
            ),
          ),
      ],
    );
  }

  Widget _buildLabel(String text, bool hasAsterisk) {
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
          if (hasAsterisk)
            const TextSpan(
              text: ' *',
              style: TextStyle(
                color: Color(0xFFEF4444),
                fontSize: 13,
              ),
            ),
        ],
      ),
    );
  }
}

class FormDropdownField extends StatelessWidget {
  final String label;
  final IconData icon;
  final String placeholder;
  final String? value;
  final List<String>? items;
  final ValueChanged<String?>? onChanged;
  final String? Function(String?)? validator;

  const FormDropdownField({
    super.key,
    required this.label,
    required this.icon,
    this.placeholder = '-- Select --',
    this.value,
    this.items,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final hasAsterisk = label.endsWith('*');
    final cleanLabel = hasAsterisk ? label.substring(0, label.length - 1) : label;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(cleanLabel, hasAsterisk),
        const SizedBox(height: 6),
        SizedBox(
          height: 44,
          child: DropdownButtonFormField<String>(
            value: value,
            isExpanded: true,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, size: 16, color: const Color(0xFF94A3B8)),
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
              filled: true,
              fillColor: Colors.white,
            ),
            hint: Text(
              placeholder,
              style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
            ),
            items: items?.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item, style: const TextStyle(fontSize: 14, color: Color(0xFF374151))),
              );
            }).toList() ?? [],
            onChanged: onChanged,
            validator: validator,
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String text, bool hasAsterisk) {
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
          if (hasAsterisk)
            const TextSpan(
              text: ' *',
              style: TextStyle(
                color: Color(0xFFEF4444),
                fontSize: 13,
              ),
            ),
        ],
      ),
    );
  }
}

class FormFileField extends StatefulWidget {
  final String label;
  final IconData icon;
  final ValueChanged<String> onFilePicked;
  final String? errorText;

  const FormFileField({
    super.key,
    required this.label,
    required this.icon,
    required this.onFilePicked,
    this.errorText,
  });

  @override
  State<FormFileField> createState() => _FormFileFieldState();
}

class _FormFileFieldState extends State<FormFileField> {
  String? _fileName;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final hasAsterisk = widget.label.endsWith('*');
    final cleanLabel = hasAsterisk ? widget.label.substring(0, widget.label.length - 1) : widget.label;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(cleanLabel, hasAsterisk),
        const SizedBox(height: 6),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: GestureDetector(
            onTap: _pickFile,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: double.infinity,
              height: 44,
              decoration: BoxDecoration(
                color: _isHovered ? const Color(0xFFF1F4F8) : Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: widget.errorText != null ? const Color(0xFFEF4444) : const Color(0xFFE2E8F0),
                ),
              ),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
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
                      _fileName ?? 'No file chosen',
                      style: TextStyle(
                        color: _fileName != null ? const Color(0xFF475569) : const Color(0xFF9CA3AF),
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

  Widget _buildLabel(String text, bool hasAsterisk) {
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
          if (hasAsterisk)
            const TextSpan(
              text: ' *',
              style: TextStyle(
                color: Color(0xFFEF4444),
                fontSize: 13,
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.isNotEmpty) {
      final name = result.files.single.name;
      setState(() => _fileName = name);
      widget.onFilePicked(name);
    }
  }
}
