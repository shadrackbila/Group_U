import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/application_model.dart';
import '../../viewmodels/application_viewmodel.dart';

/**
 * Student Numbers : 223048044, 222049725, 223022994,223014209,224131946
 * Student Names : Shadrack Bila, Lerato Gladys Molefe,Marcus Mhlambi,Lisa Sandi,Lahluma Maselana
 * Question :  Student Assistant Application Form (Create / Update Operation)
 */

class ApplicationFormScreen extends StatefulWidget {
  final ApplicationModel? existing;
  const ApplicationFormScreen({super.key, this.existing});

  @override
  State<ApplicationFormScreen> createState() => _ApplicationFormScreenState();
}

class _ApplicationFormScreenState extends State<ApplicationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();

  String _yearOfStudy = 'First Year';
  String _m1Level = 'First Year';
  String _m1Name = '';
  bool _addModule2 = false;
  String? _m2Level;
  String? _m2Name;
  bool _eligible = false;
  PlatformFile? _pickedFile;
  String? _existingDocUrl;
  bool get _isEdit => widget.existing != null;

  static const List<String> _levels = [
    'First Year',
    'Second Year',
    'Third Year'
  ];

  static const Map<String, List<String>> _modules = {
    'First Year': [
      'Introduction to Programming',
      'Computer Literacy',
      'Mathematics I',
      'Database Fundamentals'
    ],
    'Second Year': [
      'Data Structures',
      'Object Oriented Programming',
      'Web Development',
      'Networking I'
    ],
    'Third Year': [
      'Software Engineering',
      'Mobile Development',
      'Cloud Computing',
      'Technical Programming III'
    ],
  };

  bool get _isImage {
    if (_pickedFile == null) return false;
    final ext = (_pickedFile!.extension ?? '').toLowerCase();
    return ['jpg', 'jpeg', 'png'].contains(ext);
  }

  bool get _isPdf => (_pickedFile?.extension ?? '').toLowerCase() == 'pdf';
  bool get _hasBytes => _pickedFile?.bytes != null;

  bool get _existingIsImage {
    if (_existingDocUrl == null) return false;
    final lower = _existingDocUrl!.toLowerCase();
    return lower.contains('.jpg') ||
        lower.contains('.jpeg') ||
        lower.contains('.png');
  }

  String _fileSize(PlatformFile file) {
    final bytes = file.size;
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1048576) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / 1048576).toStringAsFixed(1)} MB';
  }

  @override
  void initState() {
    super.initState();
    if (_isEdit) {
      final e = widget.existing!;
      _nameCtrl.text = e.studentName;
      _yearOfStudy = e.yearOfStudy;
      _m1Level = e.module1Level;
      _m1Name = e.module1Name;
      _addModule2 = e.module2Name != null;
      _m2Level = e.module2Level;
      _m2Name = e.module2Name;
      _eligible = e.eligibilityConfirmed;
      _existingDocUrl = e.documentUrl;
    } else {
      _m1Name = _modules[_m1Level]!.first;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      withData: true,
    );
    if (result != null) {
      setState(() {
        _pickedFile = result.files.single;
        _existingDocUrl = null;
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_eligible) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please confirm your eligibility.')));
      return;
    }

    final vm = context.read<ApplicationViewModel>();
    bool success;

    if (_isEdit) {
      success = await vm.updateApplication(
        widget.existing!.copyWith(
          studentName: _nameCtrl.text.trim(),
          yearOfStudy: _yearOfStudy,
          module1Level: _m1Level,
          module1Name: _m1Name,
          module2Level: _addModule2 ? _m2Level : null,
          module2Name: _addModule2 ? _m2Name : null,
          eligibilityConfirmed: _eligible,
        ),
        newDocument: _pickedFile,
      );
    } else {
      success = await vm.submitApplication(
        studentName: _nameCtrl.text.trim(),
        yearOfStudy: _yearOfStudy,
        module1Level: _m1Level,
        module1Name: _m1Name,
        module2Level: _addModule2 ? _m2Level : null,
        module2Name: _addModule2 ? _m2Name : null,
        eligibilityConfirmed: _eligible,
        documentFile: _pickedFile,
      );
    }

    if (!mounted) return;
    if (success) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(vm.errorMessage ?? 'Something went wrong.')));
    }
  }

  // ── File preview ──────────────────────────────────────────────────────────

  Widget _buildFilePreview() {
    if (_pickedFile == null && _existingDocUrl == null)
      return const SizedBox.shrink();
    if (_pickedFile != null) return _newFilePreview();
    return _existingUrlPreview();
  }

  Widget _newFilePreview() {
    return _previewShell(
      topContent: _isImage && _hasBytes
          ? ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(9)),
              child: Image.memory(
                _pickedFile!.bytes!,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const _PreviewError(),
              ),
            )
          : _isImage && !_hasBytes
              ? const _PreviewError()
              : _docIconCard(
                  icon: _isPdf
                      ? Icons.picture_as_pdf_rounded
                      : Icons.insert_drive_file_rounded,
                  color: _isPdf
                      ? const Color(0xFFD32F2F)
                      : const Color(0xFF1565C0),
                  label: _pickedFile!.name,
                ),
      bottomLabel: _pickedFile!.name,
      bottomMeta: _fileSize(_pickedFile!),
      hasTopImage: _isImage && _hasBytes,
      isImage: _isImage,
    );
  }

  Widget _existingUrlPreview() {
    final url = _existingDocUrl!;
    final fileName = Uri.parse(url).pathSegments.last;

    return _previewShell(
      topContent: _existingIsImage
          ? ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(9)),
              child: Image.network(
                url,
                height: 200,
                fit: BoxFit.cover,
                loadingBuilder: (_, child, progress) => progress == null
                    ? child
                    : const SizedBox(
                        height: 200,
                        child: Center(
                            child: CircularProgressIndicator(strokeWidth: 2))),
                errorBuilder: (_, __, ___) => const _PreviewError(),
              ),
            )
          : _docIconCard(
              icon: url.toLowerCase().contains('.pdf')
                  ? Icons.picture_as_pdf_rounded
                  : Icons.insert_drive_file_rounded,
              color: url.toLowerCase().contains('.pdf')
                  ? const Color(0xFFD32F2F)
                  : const Color(0xFF1565C0),
              label: fileName,
            ),
      bottomLabel: fileName,
      bottomMeta: 'Already uploaded',
      hasTopImage: _existingIsImage,
      isImage: _existingIsImage,
    );
  }

  Widget _previewShell({
    required Widget topContent,
    required String bottomLabel,
    required String bottomMeta,
    required bool hasTopImage,
    required bool isImage,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF1565C0).withOpacity(0.35)),
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFF0F4FF),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          topContent,
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1565C0).withOpacity(0.08),
              borderRadius: hasTopImage
                  ? const BorderRadius.vertical(bottom: Radius.circular(9))
                  : BorderRadius.circular(9),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(children: [
              Icon(isImage ? Icons.image_outlined : Icons.description_outlined,
                  size: 16, color: const Color(0xFF1565C0)),
              const SizedBox(width: 6),
              Expanded(
                child: Text(bottomLabel,
                    style:
                        const TextStyle(fontSize: 12, color: Color(0xFF424242)),
                    overflow: TextOverflow.ellipsis),
              ),
              Text(bottomMeta,
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
              const SizedBox(width: 8),
              InkWell(
                onTap: () => setState(() {
                  _pickedFile = null;
                  _existingDocUrl = null;
                }),
                borderRadius: BorderRadius.circular(20),
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(Icons.close_rounded,
                      size: 18, color: Color(0xFFD32F2F)),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _docIconCard(
      {required IconData icon, required Color color, required String label}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(children: [
        Icon(icon, size: 56, color: color),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A2E)),
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
        ),
      ]),
    );
  }

  // ── Upload zone ───────────────────────────────────────────────────────────

  Widget _buildUploadZone() {
    final hasFile = _pickedFile != null || _existingDocUrl != null;
    return GestureDetector(
      onTap: _pickFile,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(
            color: hasFile
                ? const Color(0xFF1565C0)
                : const Color(0xFF1565C0).withOpacity(0.4),
            width: hasFile ? 2 : 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
          color: hasFile
              ? const Color(0xFF1565C0).withOpacity(0.05)
              : Colors.transparent,
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
              hasFile ? Icons.check_circle_outline : Icons.upload_file_outlined,
              color: const Color(0xFF1565C0)),
          const SizedBox(width: 10),
          Text(
            hasFile ? 'Tap to replace file' : 'Upload Document (PDF / Image)',
            style: const TextStyle(
                color: Color(0xFF1565C0), fontWeight: FontWeight.w500),
          ),
        ]),
      ),
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? 'Edit Application' : 'New Application'),
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle('Personal Information'),
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder()),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Name is required' : null,
              ),
              const SizedBox(height: 14),
              DropdownButtonFormField<String>(
                initialValue: _yearOfStudy,
                decoration: const InputDecoration(
                    labelText: 'Year of Study',
                    prefixIcon: Icon(Icons.calendar_today_outlined),
                    border: OutlineInputBorder()),
                items: ['First Year', 'Second Year', 'Third Year']
                    .map((y) => DropdownMenuItem(value: y, child: Text(y)))
                    .toList(),
                onChanged: (v) => setState(() => _yearOfStudy = v!),
              ),
              const SizedBox(height: 24),
              _sectionTitle('Module 1 (Required)'),
              DropdownButtonFormField<String>(
                initialValue: _m1Level,
                decoration: const InputDecoration(
                    labelText: 'Academic Level', border: OutlineInputBorder()),
                items: _levels
                    .map((l) => DropdownMenuItem(value: l, child: Text(l)))
                    .toList(),
                onChanged: (v) => setState(() {
                  _m1Level = v!;
                  _m1Name = _modules[_m1Level]!.first;
                }),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _modules[_m1Level]!.contains(_m1Name)
                    ? _m1Name
                    : _modules[_m1Level]!.first,
                decoration: const InputDecoration(
                    labelText: 'Module Name', border: OutlineInputBorder()),
                items: _modules[_m1Level]!
                    .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                    .toList(),
                onChanged: (v) => setState(() => _m1Name = v!),
              ),
              const SizedBox(height: 24),
              _sectionTitle('Module 2 (Optional)'),
              SwitchListTile(
                title: const Text('Apply for a second module'),
                value: _addModule2,
                activeThumbColor: const Color(0xFF1565C0),
                contentPadding: EdgeInsets.zero,
                onChanged: (v) => setState(() {
                  _addModule2 = v;
                  if (v) {
                    _m2Level ??= _levels.first;
                    _m2Name ??= _modules[_m2Level]!.first;
                  }
                }),
              ),
              if (_addModule2) ...[
                DropdownButtonFormField<String>(
                  initialValue: _m2Level,
                  decoration: const InputDecoration(
                      labelText: 'Academic Level (Module 2)',
                      border: OutlineInputBorder()),
                  items: _levels
                      .map((l) => DropdownMenuItem(value: l, child: Text(l)))
                      .toList(),
                  onChanged: (v) => setState(() {
                    _m2Level = v!;
                    _m2Name = _modules[_m2Level]!.first;
                  }),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: _m2Name,
                  decoration: const InputDecoration(
                      labelText: 'Module Name (Module 2)',
                      border: OutlineInputBorder()),
                  items: _modules[_m2Level ?? _levels.first]!
                      .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                      .toList(),
                  onChanged: (v) => setState(() => _m2Name = v!),
                  validator: (v) => (_addModule2 && (v == null || v.isEmpty))
                      ? 'Select a module'
                      : null,
                ),
              ],
              const SizedBox(height: 24),
              _sectionTitle('Supporting Documentation'),
              _buildUploadZone(),
              _buildFilePreview(),
              const SizedBox(height: 24),
              _sectionTitle('Eligibility Confirmation'),
              CheckboxListTile(
                title: const Text(
                    'I confirm that I meet the minimum requirements for the module(s) I am applying to assist with.',
                    style: TextStyle(fontSize: 13)),
                value: _eligible,
                activeColor: const Color(0xFF1565C0),
                onChanged: (v) => setState(() => _eligible = v!),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 32),
              Consumer<ApplicationViewModel>(builder: (_, vm, __) {
                return SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1565C0),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: vm.isLoading ? null : _submit,
                    child: vm.isLoading
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2))
                        : Text(_isEdit ? 'Save Changes' : 'Submit Application',
                            style: const TextStyle(fontSize: 16)),
                  ),
                );
              }),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(text,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1565C0))),
      );
}

class _PreviewError extends StatelessWidget {
  const _PreviewError();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: const BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.vertical(top: Radius.circular(9))),
      child: const Center(
          child:
              Icon(Icons.broken_image_outlined, size: 40, color: Colors.grey)),
    );
  }
}
