//
//  Line.swift
//  WhiteBoard
//
//  Created by Nhat Le on 30/3/25.
//

import Foundation
import SwiftUI

struct Line {
    var points: [CGPoint]
    var color: Color
    var width: CGFloat
    
    init(points: CGPoint..., color: Color, width: CGFloat) {
        self.points = points
        self.color = color
        self.width = width
    }
    
    init(points: [CGPoint], color: Color, width: CGFloat) {
        self.points = points
        self.color = color
        self.width = width
    }
}
