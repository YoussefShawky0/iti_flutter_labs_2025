import 'package:flutter/material.dart';

import '../services/news_service.dart';
import '../utils/app_config.dart';

class SearchTestWidget extends StatefulWidget {
  const SearchTestWidget({super.key});

  @override
  State<SearchTestWidget> createState() => _SearchTestWidgetState();
}

class _SearchTestWidgetState extends State<SearchTestWidget> {
  final NewsService _newsService = NewsService();
  final TextEditingController _controller = TextEditingController();
  String _result = '';
  bool _loading = false;

  Future<void> _testSearch() async {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      _loading = true;
      _result = 'Testing search...';
    });

    try {
      print('🔍 Testing search for: ${_controller.text}');
      final articles = await _newsService.searchNews(query: _controller.text);

      setState(() {
        _result = 'Success! Found ${articles.length} articles';
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _result = 'Error: $e';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Test')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('API Key: ${AppConfig.newsApiKey.substring(0, 8)}...'),
            Text('Base URL: ${AppConfig.newsApiBaseUrl}'),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Search Query',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _testSearch(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loading ? null : _testSearch,
              child: _loading
                  ? const CircularProgressIndicator()
                  : const Text('Test Search'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SingleChildScrollView(child: Text(_result)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
