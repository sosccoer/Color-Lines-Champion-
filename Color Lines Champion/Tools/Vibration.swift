//
//  Vibration.swift
//  Color Lines Champion
//
//  Created by lelya.rumynin@gmail.com on 1.04.24.
//

import Foundation
import UIKit

class Vibration {
    private let generator = UINotificationFeedbackGenerator()
    
    func vibration() {
        self.generator.prepare()
        self.generator.notificationOccurred(.success)
        
    }
}
