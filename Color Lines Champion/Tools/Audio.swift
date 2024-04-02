//
//  Audio.swift
//  Color Lines Champion
//
//  Created by lelya.rumynin@gmail.com on 1.04.24.
//

import SwiftUI

import AVFoundation

class Audio: NSObject, ObservableObject {
    var audioPlayer: AVAudioPlayer?
    
    func playSound() {
        
        if let path = Bundle.main.path(forResource: "dropCoin", ofType: "mp3") {
            do {
                self.audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                self.audioPlayer?.play()
            } catch {
                print("Sound Error")
            }
        }
    }
}


