//
//  LearnSounds.swift
//  IntermediateBootcamp
//
//  Created by Denis DRAGAN on 11.11.2023.
//

import SwiftUI
import AVKit

private class SoundManager {
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    enum SoundOption: String {
        case tada
        case badum
    }
    
    func playSound(sound: SoundOption) {
        
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        }
        catch let error {
            print("Error is \(error.localizedDescription)")
        }
    }
}

struct LearnSounds: View {
    var body: some View {
        VStack(spacing: 20) {
            Button("Sound 1") {
                SoundManager.instance.playSound(sound: .tada)
            }
            Button("Sound 2") {
                SoundManager.instance.playSound(sound: .badum)
            }
        }
    }
}

#Preview {
    LearnSounds()
}
