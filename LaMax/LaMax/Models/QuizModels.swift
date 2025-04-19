// QuizModels.swift
import Foundation

struct QuizPart: Codable {
    let questions: [Question]
}

/// Detailed question model, part-specific fields are optional
struct Question: Codable, Identifiable {
    let id: Int
    let part: String?
    let text: String?
    let choices: [Choice]?
    let answer: String?
    let imageId: Int?
    let imageUrl: URL?
    let audioPrompt: String?
    let audioUrl: URL?
    let context: String?
    let utterances: [Utterance]?
    let question: NestedQuestion? // for parts 3 & 4
    let talkAudioUrl: URL?

    enum CodingKeys: String, CodingKey {
        case id, part, text, choices, answer, imageId, imageUrl, audioPrompt, audioUrl, context, utterances, question, talkAudioUrl
    }
}

// MARK: - Choice model for question options
/// Choice can be a plain string or an object with label/text
struct Choice: Codable, Equatable, Hashable {
    let label: String
    let text: String

    init(label: String, text: String) {
        self.label = label
        self.text = text
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let str = try? container.decode(String.self) {
            self.label = str
            self.text = str
        } else {
            let dict = try container.decode([String: String].self)
            guard let label = dict["label"], let text = dict["text"] else {
                throw DecodingError.dataCorruptedError(in: container,
                    debugDescription: "Invalid choice format: expected string or {label,text}")
            }
            self.label = label
            self.text = text
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(text)
    }

    static func == (lhs: Choice, rhs: Choice) -> Bool {
        return lhs.label == rhs.label && lhs.text == rhs.text
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(label)
        hasher.combine(text)
    }
}

/// Utterance in Part 3 conversations
struct Utterance: Codable, Identifiable {
    let sequence: Int
    let speaker: String
    let text: String
    let audioUrl: URL?
    var id: Int { sequence }
}

/// Nested question structure for parts 3 & 4
struct NestedQuestion: Codable, Identifiable {
    let id: Int
    let text: String?
    let choices: [Choice]?
    let answer: String?

    enum CodingKeys: String, CodingKey {
        case id, text, choices, answer
    }
}
