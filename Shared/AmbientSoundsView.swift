//
//  AmbientSoundsView.swift
//  sleepTrackerHackathon
//
//  Created by Rosalie Wessels on 2/27/21.
//

import SwiftUI
import AVFoundation

struct AmbientSoundsView: View {
    
    // music link: https://www.youtube.com/watch?v=p0hDPz0mo9w
    // speaker image link: https://www.pinterest.com/pin/593560425879134319/
    // pause image link: https://www.iconfinder.com/icons/2337856/halt_pause_pause_button_pause_music_pause_video_stop_icon
    
    @State var calmSounds: AVAudioPlayer?
    @State var sounds = ["calmSounds.mp3"]
    @State var speaker = "speaker"
    @State var pause = "pause"
    
    func playSounds() {
        let path = Bundle.main.path(forResource: "calmSounds.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)

        do {
            calmSounds = try AVAudioPlayer(contentsOf: url)
            calmSounds?.play()
        } catch {
            // couldn't load file :(
        }
    }
    
    func stop() {}
    
    var body: some View {
        VStack {
            VStack {
                Text("Play calming and ambient music:")
                    .font(Font.custom("Menlo-Bold", size: 30))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(width:250, height:150)
                HStack {
                    Button(action: {self.playSounds()}) {
                        ZStack {
                            Circle()
                                .frame(width: 60)
                                .foregroundColor(Color.white.opacity(0.8))
                            Image(speaker)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40)
                        }
                    }
                    Button(action: {
                        calmSounds?.stop()
                    }) {
                        ZStack {
                            Circle()
                                .frame(width: 60)
                                .foregroundColor(Color.white.opacity(0.8))
                            Image(pause)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40)
                        }
                    }
                }
            }
            .frame(height:230)
        }
        .background(Image("moonBackground")
                    .scaledToFill())
    }
}


struct AmbientSoundsView_Previews: PreviewProvider {
    static var previews: some View {
        AmbientSoundsView()
    }
}
