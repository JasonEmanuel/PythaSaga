//
//  AtlasImageView.swift
//  PythaSaga
//
//  Created by Jason Emanuel on 26/04/24.
//

import SwiftUI

#if os(iOS)
import UIKit
#endif

extension AtlasImage {
#if os(iOS)
    typealias NativeImage = UIImage
#endif
}

struct AtlasImage: View {
    let imageName: String
    let columns: Int
    let rows: Int
    let fps: Double
    let size: CGSize
    let reverseAnimation: Bool
    let repeatAnimation: Bool
    
    @State private var timer: Timer? = nil
    @State private var currentFrame = 0
    @State private var frames: [NativeImage] = []
    @State private var isReversed = false

    var body: some View {
        Image(uiImage: frames.isEmpty ? NativeImage(named: imageName)! : (frames.indices.contains(currentFrame) ? frames[currentFrame] : NativeImage()))
            .interpolation(.none)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size.width, height: size.height)
            .onAppear {
                splitAtlasImage() // Panggil fungsi splitAtlasImage saat pertama kali tampil
                startAnimation()
            }
            .onChange(of: imageName) { _ in
                splitAtlasImage()
                startAnimation()
            }
    }

    func splitAtlasImage() {
        guard let atlasImage = NativeImage(named: imageName) else { return }
        let atlasWidth = atlasImage.size.width
        let atlasHeight = atlasImage.size.height
        let cellWidth = atlasWidth / CGFloat(columns)
        let cellHeight = atlasHeight / CGFloat(rows)

        frames = []

        for row in 0..<rows {
            for col in 0..<columns {
                let rect = CGRect(x: CGFloat(col) * cellWidth,
                                  y: CGFloat(row) * cellHeight,
                                  width: cellWidth,
                                  height: cellHeight)
                if let cgImage = atlasImage.cgImage?.cropping(to: rect) {
                    let frameImage = NativeImage(cgImage: cgImage)
                    frames.append(frameImage)
                }
            }
        }
    }
    
    func startAnimation() {
                
        let totalFrames = columns * rows
        let frameDuration = 1.0 / fps
        
        if timer != nil {
            timer?.invalidate()
        }
        
        if reverseAnimation {
            timer = Timer.scheduledTimer(withTimeInterval: frameDuration, repeats: true) { _ in
                if currentFrame == totalFrames - 1 {
                    isReversed = true
                } else if currentFrame == 0 {
                    isReversed = false
                }

                if isReversed {
                    currentFrame -= 1
                } else {
                    currentFrame += 1
                }
            }
            
            RunLoop.current.add(timer!, forMode: .common)
        } else {
            timer = Timer.scheduledTimer(withTimeInterval: frameDuration, repeats: true) { _ in
                currentFrame = (currentFrame + 1) % totalFrames
            }
            
            RunLoop.current.add(timer!, forMode: .common)
        }
    }
}


