import 'package:news_depi_final_project/features/gemini/domain/repositories/i_gemini_repository.dart';

import '../../../news/data/model/article.dart';

class GetAiSummaryUseCase {
  final IGeminiRepository _repository;

  GetAiSummaryUseCase(this._repository);

  // ============================================================
  // 1. Search Summary
  // ============================================================
  Future<String> call({
    required String topic,
    required List<Article> articles,
  }) async {
    // 1. Prepare content
    final articlesContent = articles
        .map((a) => '- Source: ${a.sourceName} | Title: ${a.title}')
        .join('\n');

    // 2. System Prompt (English)
    final prompt =
        '''
You are an AI news summarizer.
Task: Summarize the following articles about "$topic" into a single focused paragraph.

Strict Instructions:
1. Start the summary DIRECTLY. Do not say "Here is the summary" or "Based on the articles".
2. Do NOT repeat the prompt or the instructions.
3. Focus only on key insights.

Articles:
$articlesContent
''';

    // Send to Gemini
    return await _repository.generateText(prompt);
  }

  // ============================================================
  // 2. Dual Language
  // ============================================================
  Future<String> callDualLang({
    required String topic,
    required List<Article> articles,
  }) async {
    final articlesContent = articles
        .map((a) => 'Source: ${a.sourceName} - Title: ${a.title}')
        .join('\n');

    const separator = "###SPLIT###";

    final prompt =
        '''
    You are an expert news assistant. 
    Topic: "$topic"
    Articles:
    $articlesContent

    Task:
    1. Write a short summary of the **news from the last 24 hours** in **ENGLISH**.
    2. Write exactly "$separator".
    3. Write a short summary of the **news from the last 24 hours** in **ARABIC**.
    
    Constraint: Output ONLY the requested format. Do not add conversational text.
    ''';

    return await _repository.generateText(prompt);
  }
}
