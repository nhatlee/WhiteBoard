//
//  DrawingEngine.swift
//  WhiteBoard
//
//  Created by Nhat Le on 30/3/25.
//

import Foundation
import SwiftUI

final class DrawingEngine {
    func createPath(for points: [CGPoint]) -> Path {
        var path = Path()
        if let firstPoint = points.first {
            path.move(to: firstPoint)
        }
        for i in 1..<points.count {
            let mid = calculateMidPoint(points[i-1], points[i])
            path.addQuadCurve(to: mid, control: points[i-1])
        }
        
        if let last = points.last {
            path.addLine(to: last)
        }
        return path
    }
    
    func calculateMidPoint(_ lsh: CGPoint, _ rhs: CGPoint) -> CGPoint {
        return CGPoint(x: (lsh.x + rhs.x) / 2, y: (lsh.y + rhs.y) / 2)
    }
}
