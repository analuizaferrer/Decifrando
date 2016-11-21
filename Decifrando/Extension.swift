//
//  Extension.swift
//  Decifrando
//
//  Created by juliana vidal on 11/21/16.
//
//

import SpriteKit

class SizeSettings{
    static var screenSize : CGSize! = nil
    static let refSize : CGSize = CGSize(width:1024,height:768)
}

extension SKSpriteNode{
    func fitAspect(toSize size: CGSize){
        self.size = getAspectFitSize(toSize: size)
    }
    
    func fitAspect(toX x : CGFloat, toY y: CGFloat){
        fitAspect(toSize: CGSize(width:x,height:y))
    }
    
    func fillAspect(toSize size: CGSize){
        self.size = getAspectFillSize(toSize: size)
    }
    
    func fillAspect(toX x : CGFloat, toY y: CGFloat){
        fillAspect(toSize: CGSize(width:x,height:y))
    }
}

func getAspectFitSize(toSize size: CGSize) -> CGSize{
    let ss = SizeSettings.screenSize
    let rs = SizeSettings.refSize
    let s = min(ss!.width/rs.width,ss!.height/rs.height)
    return CGSize(width: s*size.width, height: size.height*s)
}

func getAspectFitSize(toX x: CGFloat, toY y: CGFloat) -> CGSize{
    return getAspectFitSize(toSize: CGSize(width:x,height:y))
}

func getAspectFillSize(toSize size: CGSize) -> CGSize{
    let ss = SizeSettings.screenSize
    let rs = SizeSettings.refSize
    let s = max(ss!.width/rs.width,ss!.height/rs.height)
    return CGSize(width: s*size.width, height: size.height*s)
}

func getAspectFillSize(toX x: CGFloat, toY y: CGFloat) -> CGSize{
    return getAspectFillSize(toSize: CGSize(width:x,height:y))
}
