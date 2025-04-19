// QuizAPIClient.swift
import Foundation

/// Networking layer for fetching quiz parts with simple caching
final class QuizAPIClient {
    static let shared = QuizAPIClient()
    private let baseURL: URL
    private let session: URLSession
    private let cacheDir: URL

    init(baseURL: URL = URL(string: "http://127.0.0.1:4000")!, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
        self.cacheDir = FileManager.default
            .urls(for: .cachesDirectory, in: .userDomainMask)[0]
    }

    // MARK: - Summary models for listing questions
    private struct SummaryItem: Codable {
        let id: Int
        let imageId: Int?
        let conversationId: Int?
        let talkId: Int?
    }
    private struct QuizSummary: Codable {
        let part: String
        let count: Int
        let questions: [SummaryItem]
    }

    /// Fetches a quiz part by first listing question IDs, then fetching each detail concurrently
    func fetchQuizPart(named part: String) async throws -> QuizPart {
        let summaryEndpoint = baseURL.appendingPathComponent("api/quiz/\(part)/questions")
        // 1) Fetch summary
        let (sumData, sumResponse) = try await session.data(from: summaryEndpoint)
        guard let sumHttp = sumResponse as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        if !(200...299).contains(sumHttp.statusCode) {
            // Try decoding server error message
            if let errObj = try? JSONDecoder().decode([String: String].self, from: sumData), let msg = errObj["error"] {
                throw NSError(domain: "HTTPError", code: sumHttp.statusCode, userInfo: [NSLocalizedDescriptionKey: msg])
            }
            throw NSError(domain: "HTTPError", code: sumHttp.statusCode, userInfo: [NSLocalizedDescriptionKey: "Server error \(sumHttp.statusCode)"])
        }
        let summary: QuizSummary
        do { summary = try JSONDecoder().decode(QuizSummary.self, from: sumData) }
        catch { throw NSError(domain: "DecodeError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid summary format"])
        }
        // 2) Fetch each question detail
        let questions: [Question] = try await withThrowingTaskGroup(of: Question.self) { group in
            for item in summary.questions {
                group.addTask {
                    try await self.fetchQuestion(part: part, id: item.id)
                }
            }
            var collected: [Question] = []
            for try await q in group {
                collected.append(q)
            }
            return collected
        }
        return QuizPart(questions: questions)
    }

    /// Fetches a single question detail including media URLs
    private func fetchQuestion(part: String, id: Int) async throws -> Question {
        let endpoint = baseURL.appendingPathComponent("api/quiz/\(part)/questions/\(id)")
        let (data, response) = try await session.data(from: endpoint)
        guard let http = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        if !(200...299).contains(http.statusCode) {
            if let errObj = try? JSONDecoder().decode([String: String].self, from: data), let msg = errObj["error"] {
                throw NSError(domain: "HTTPError", code: http.statusCode, userInfo: [NSLocalizedDescriptionKey: msg])
            }
            throw NSError(domain: "HTTPError", code: http.statusCode, userInfo: [NSLocalizedDescriptionKey: "Server error \(http.statusCode)"])
        }
        do {
            return try JSONDecoder().decode(Question.self, from: data)
        } catch {
            let jsonStr = String(data: data, encoding: .utf8) ?? "<invalid utf8>"
            throw NSError(domain: "DecodeError", code: 0,
                          userInfo: [NSLocalizedDescriptionKey: "Invalid question format: \n\(jsonStr)"])
        }
    }
}
