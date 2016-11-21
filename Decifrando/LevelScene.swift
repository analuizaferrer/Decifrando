//
//  LevelScene.swift
//  Decifrando
//
//  Created by Ana Luiza Ferrer on 03/11/16.
//
//

import Foundation
import SpriteKit
import AVFoundation

class LevelScene: SKScene {
    
    var correctWord: String!
    var boxArray: [Box]!
    var lettersArray: [Letter]!
    var background: SKSpriteNode!
    var selectedNode: Letter?
    var letterPreviousPosition: CGPoint!
    var recordVoice: SKLabelNode!
    var playVoice:SKLabelNode!
    var soundRecorder: AVAudioRecorder!
    var soundPlayer: AVAudioPlayer!
    var fileName = "audioFile.m4a"
    
    override func didMove(to view: SKView) {
        
        let selectedLevel: Int = AppData.sharedInstance.selectedLevelIndex
        correctWord = AppData.sharedInstance.levelsList[selectedLevel].word
        
        background = SKSpriteNode(color: UIColor.yellow, size: CGSize(width: self.size.width, height: self.size.height))
        self.background.name = "background"
        self.background.anchorPoint = CGPoint.zero
        self.addChild(background)
        
        let imageNode = SKSpriteNode(imageNamed: AppData.sharedInstance.levelsList[AppData.sharedInstance.selectedLevelIndex].image)
        imageNode.position = CGPoint(x: size.width/2, y: 2*size.height/2.7)
        imageNode.size = CGSize(width: size.width/3, height: size.width/3)
        self.addChild(imageNode)
        
        self.recordVoice = SKLabelNode(text: "Gravar voz")
        self.recordVoice.fontName = "Riffic"
        self.recordVoice.fontColor = UIColor.black
        self.recordVoice.name = "Record"
        self.recordVoice.position = CGPoint(x: size.width-350, y: size.height-70)
        self.recordVoice.isHidden = true
        self.background.addChild(recordVoice)
        
        self.playVoice = SKLabelNode(text: "Tocar voz")
        self.playVoice.fontName = "Riffic"
        self.playVoice.fontColor = UIColor.black
        self.playVoice.name = "Play"
        self.playVoice.position = CGPoint(x: size.width-120, y: size.height-70)
        self.playVoice.isHidden = true
        self.background.addChild(playVoice)
        
        boxArray = []
        
        for letter in correctWord.characters {
            
            boxArray.append(Box(letter: letter))
            
        }
        
        var i = 0
        for box in boxArray {
            
            let offsetFraction = (CGFloat(i) + 1.0)/(CGFloat(boxArray.count) + 1.0)
            
            box.position = CGPoint(x: size.width * offsetFraction, y: size.height/3)
            addChild(box)
            
            i = i + 1
            
        }
        
        lettersArray = []
        
        for letter in correctWord.characters {
            
            lettersArray.append(Letter(letter: letter))
    
        }
        
        for _ in 0 ..< 10-correctWord.characters.count {
        
            lettersArray.append(Letter())
        
        }
        
        lettersArray.shuffle()
        
        var j = 0
        for letter in lettersArray {
            
            let offsetFraction = (CGFloat(j) + 1.0)/(CGFloat(lettersArray.count) + 1.0)
            
            letter.position = CGPoint(x: size.width * offsetFraction, y: size.height/8)
            letter.zPosition = 20
            background.addChild(letter)
            j = j + 1
            
        }
        
        let backLabel = SKLabelNode(fontNamed: "Riffic")
        backLabel.text = "Voltar"
        backLabel.fontSize = 40
        backLabel.fontColor = SKColor.black
        backLabel.position = CGPoint(x: size.width/8, y: 9*size.height/10)
        backLabel.name = "Back"
        addChild(backLabel)
        
//        
//        let s = getAspectFitSize(toX: 130, toY: 130)
//        let backButton = SKSpriteNode(imageNamed: "backButton")
//        //        backLabel.text = "Voltar"
//        //        backLabel.fontSize = 40
//        //        backLabel.fontColor = SKColor.black
//        backButton.size = s
//        //        backButton.position = CGPoint(x: size.width/8, y: 9*size.height/10)
//        backButton.position = CGPoint(x: 400, y: 400)
//        backButton.name = "Back"
//        addChild(backButton)

        self.setupRecorder()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let positionInScene = touch.location(in: self)
        
        selectNodeForTouch(touchLocation: positionInScene)
    }
    
    func selectNodeForTouch(touchLocation: CGPoint) {
        
        selectedNode = Letter()
        
        let touchedNode = self.atPoint(touchLocation)
        letterPreviousPosition = touchedNode.position
        if touchedNode is Letter {
            
            if !(selectedNode?.isEqual(touchedNode))! && selectedNode != nil{
                selectedNode?.removeAllActions()
                selectedNode?.run(SKAction.rotate(toAngle: 0.0, duration: 0.1))
                
                selectedNode = touchedNode as? Letter
            }
        } else if touchedNode.name == "Back" {
            
            self.returnToCategoryScene()
            
        } else if touchedNode.name == "Record" {
            
            self.soundRecorder.record()
            touchedNode.name = "Stop"
            self.recordVoice.text = "Parar de gravar"
            
        } else if touchedNode.name == "Stop" {
            
            self.soundRecorder.stop()
            touchedNode.name = "Record"
            self.recordVoice.text = "Gravar voz"
            self.playVoice.isHidden = false
            
        } else if touchedNode.name == "Play" {
            
            self.preparePlayer()
            soundPlayer.play()
            touchedNode.name = "Pause"
            
        } else if touchedNode.name == "Pause" {
            
            soundPlayer.stop()
            touchedNode.name = "Play"
            
        }
    }
    
    func panForTranslation(translation: CGPoint) {
        let position = selectedNode?.position
        
        if selectedNode?.name != nil && selectedNode?.name! == Letter.kLetterNodeName {
            selectedNode?.position = CGPoint(x: (position?.x)! + translation.x, y: (position?.y)! + translation.y)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if touches.first != nil {
        let touch = touches.first!
        let positionInScene = touch.location(in: self)
        let previousPosition = touch.previousLocation(in: self)
        let translation = CGPoint(x: positionInScene.x - previousPosition.x, y: positionInScene.y - previousPosition.y)
            
                panForTranslation(translation: translation)

        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
     
        letterIsInsideBox()
        
        if didWin() {
            
            levelComplete()
    
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        letterIsInsideBox()
        
        if didWin() {
            
            levelComplete()
            
        }
    }
    
    func letterIsInsideBox() {
        
        var correctBox = false
        
        for box in boxArray {
            
            let xMin = box.position.x - box.size.width/2
            let xMax = box.position.x + box.size.width/2
            let yMin = box.position.y - box.anchorPoint.y*box.size.height
            let yMax = box.position.y + (1-box.anchorPoint.y)*box.size.height
            
            if (selectedNode?.position.x)! > xMin && (selectedNode?.position.x)! < xMax && (selectedNode?.position.y)! > yMin && (selectedNode?.position.y)! < yMax {
                
                if selectedNode?.text?.characters.first == box.boxLetter {
                    
                    selectedNode?.position.x = box.position.x
                    selectedNode?.position.y = box.position.y - (selectedNode?.fontSize)!/4
                    
                    correctBox = true
                    box.isFull = true
                    
                    playSound()
                    
                } else {
                    
                    selectedNode?.position = letterPreviousPosition
                    
                }
            }
        }
        
        if !correctBox {
            
            selectedNode?.position = letterPreviousPosition
            
        }
    }
    
    func didWin()->Bool {
        
        for box in boxArray {
            if !box.isFull {
                return false
            }
        }
        
        return true
    }
    
    func levelComplete () {
    
        AppData.sharedInstance.levelsList[AppData.sharedInstance.selectedLevelIndex].completed = true
        
        self.recordVoice.isHidden = false
        
//        let reveal = SKTransition.fade(withDuration: 1)
//        let levelCompletedScene = LevelCompletedScene(size: self.size)
//        self.view?.presentScene(levelCompletedScene, transition: reveal)
        
    }
    
    func returnToCategoryScene() {
        
        let reveal = SKTransition.fade(withDuration: 1.0)
        let scene = CategoryScene(size: size)
        self.view?.presentScene(scene, transition:reveal)
        
    }
    
    func playSound() {
        
        run(SKAction.playSoundFileNamed("Som Genérico.mp3", waitForCompletion: false))
        
    }
}

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
            
            print("erro")
            
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
            
            print("erro")
            
        }
    }
}
