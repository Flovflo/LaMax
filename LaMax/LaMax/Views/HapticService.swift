//
//  HapticService.swift
//  LaMax
//
//  Created by Florian Taffin on 04/04/2025.
//

import UIKit

class HapticService {
    static let shared = HapticService()
    
    private init() { }
    
    func triggerFeedback(isCorrect: Bool) {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        if isCorrect {
            generator.notificationOccurred(.success)
        } else {
            generator.notificationOccurred(.error)
        }
    }
}
