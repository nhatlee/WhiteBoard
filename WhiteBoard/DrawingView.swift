//
//  DrawingView.swift
//  WhiteBoard
//
//  Created by Nhat Le on 30/3/25.
//

import SwiftUI

struct DrawingView: View {
    @State private var viewModel = DrawingViewModel()
    
    var body: some View {
        VStack {
            settingView
            drawView
        }
    }
    
    private var settingView: some View {
        VStack(spacing: 20) {
            ColorPicker(selection: $viewModel.selectedColor, supportsOpacity: true) {
                EmptyView()
            }
            .labelsHidden()
            VStack(alignment: .leading) {
                Text("Line width: \(Int(viewModel.selectedWidth))")
                HStack {
                    Text("1")
                    Slider(value: $viewModel.selectedWidth, in: 1...50)
                        .frame(maxWidth: 300)
                    Text(String(format: "%.0f", viewModel.selectedWidth))
                }
            }
            
            drawActionView
            
        }
        .padding(20)
    }
    
    private var drawActionView: some View {
        HStack(spacing: 25) {
                Button {
                    viewModel.backward()
                } label: {
                    Image(systemName: "arrow.uturn.backward")
                        .imageScale(.large)
                }
                .disabled(viewModel.lines.isEmpty)
                
                Button {
                    viewModel.forward()
                } label: {
                    Image(systemName: "arrow.uturn.forward")
                        .imageScale(.large)
                }
                .disabled(viewModel.deleteLines.isEmpty)
                
                Button {
                    viewModel.showConfirmation.toggle()
                } label: {
                    Image(systemName: "trash.fill")
                        .imageScale(.large)
                }
                .disabled(viewModel.lines.isEmpty)
                .confirmationDialog("Clear All", isPresented: $viewModel.showConfirmation) {
                    Button(role: .destructive) {
                        viewModel.clearAll()
                    } label: {
                        Text("Clear all")
                    }

                }
            }
            
            
    }
    
    private var drawView: some View {
        Canvas { context, size in
            for line in viewModel.lines {
                let path = viewModel.createPath(for: line.points)
                context.stroke(path, with: .color(line.color), lineWidth: line.width)
            }
        }
        .gesture(
            DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onChanged { value in
                    viewModel.onDragGestureChange(value)
                }
                .onEnded { value in
                    if let last = viewModel.lines.last, last.points.isEmpty {
                        viewModel.lines.removeLast()
                    }
                }
        )
    }
    
    
}

#Preview {
    DrawingView()
}
