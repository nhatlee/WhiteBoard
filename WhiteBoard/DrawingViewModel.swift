//
//  DrawingViewModel.swift
//  WhiteBoard
//
//  Created by Nhat Le on 30/3/25.
//

import Foundation
import SwiftUI

@Observable
final class DrawingViewModel {
    var showConfirmation = false
    
    var lines = [Line]()
    var deleteLines: [Line] = []
    
    private let engine = DrawingEngine()
    
    var selectedColor: Color = .blue
    var selectedWidth: CGFloat = 6
    
    
    func clearAll() {
        lines.removeAll()
        deleteLines.removeAll()
    }
    
    func createPath(for points: [CGPoint]) -> Path {
        engine.createPath(for: points)
    }
    
    func backward() {
        let lastLine = lines.popLast()
        if let lastLine {
            deleteLines.append(lastLine)
        }
    }
    
    func forward() {
        let last = deleteLines.popLast()
        if let last {
            lines.append(last)
        }
    }
    
    func onDragGestureChange(_ value: DragGesture.Value) {
        let newPoint = value.location
        if value.translation.width + value.translation.height == 0 {
            // Starting point
            lines.append(
                Line(points: newPoint, color: selectedColor, width: selectedWidth)
            )
        } else {
            let lastIdx = lines.count - 1
            lines[lastIdx].points.append(newPoint)
        }
    }
}
