//
//  PlaySound.swift
//  Honeymoon
//
//  Created by Denis Yaremenko on 01.05.2024.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?
    

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
