//
//  LevelSceneExtension.swift
//  Decifrando
//
//  Created by Helena Leitão on 22/11/16.
//
//

import UIKit
import SpriteKit
import AVFoundation

extension LevelScene: AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    func setupRecorder() {
        
        let recordSettings = [AVFormatIDKey: kAudioFormatAppleLossless,
                              AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue,
                              AVEncoderBitRateKey: 320000,
                              AVNumberOfChannelsKey: 2,
                              AVSampleRateKey: 44100.0] as [String : Any]
        
        do {
            soundRecorder = try AVAudioRecorder(url: getFileURL() as URL, settings: recordSettings as [String: AnyObject])
            soundRecorder.delegate = self
            soundRecorder.prepareToRecord()
            
        } catch {
            
            print("error")
            
        }
    }
    
    func getFileURL()->NSURL {
        
        let path = NSURL(fileURLWithPath: getCacheDirectory()).appendingPathComponent(fileName)
        
        return path! as NSURL
        
    }
    
    func getCacheDirectory()->String {
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        return paths[0]
        
    }
    
    func preparePlayer() {
        
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: getFileURL() as URL)
            soundPlayer.delegate = self
            soundPlayer.prepareToPlay()
            soundPlayer.volume = 1.0
            
        } catch {
            
            print("error")
            
        }
    }
}

