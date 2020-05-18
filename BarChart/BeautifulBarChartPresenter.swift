//
//  BeautifulBarChartPresenter.swift
//  BarChart
//
//  Created by Nguyen Vu Nhat Minh on 21/5/19.
//  Copyright © 2019 Nguyen Vu Nhat Minh. All rights reserved.
//

import Foundation
import CoreGraphics.CGGeometry

class BeautifulBarChartPresenter {
    let barWidth: CGFloat
    let space: CGFloat
    
    /// Reserved space to show text below each bar
    private let bottomSpace: CGFloat = 0.0
    /// Reserved space to show value (or height) of the bar
    private let topSpace: CGFloat = 10
    
    var dataEntries: [DataEntry] = []
    
    init(barWidth: CGFloat = 140, space: CGFloat = -70) {
        self.barWidth = barWidth
        self.space = space
    }
    
    func computeContentWidth() -> CGFloat {
        return (barWidth) * CGFloat(dataEntries.count + 1)/2
    }
    
    func computeBarEntries(viewHeight: CGFloat ) -> [BeautifulBarEntry] {
        var result: [BeautifulBarEntry] = []
        
        for (index, entry) in dataEntries.enumerated() {
            let entryHeight = CGFloat(entry.height) * (viewHeight / 2  - bottomSpace - topSpace)
            var position:CGFloat = CGFloat(index)
            var yPosition = viewHeight  - bottomSpace - entryHeight
            if index > 3 {
                yPosition = viewHeight
                position -= 4
            }
            let xPosition: CGFloat = CGFloat(position) * (barWidth + space)
            
            
            let barEntry = BeautifulBarEntry(origin: CGPoint(x: xPosition, y: yPosition), barWidth: barWidth, barHeight: entryHeight, data: entry)
            
            result.append(barEntry)
        }
        
        return result
    }
}
