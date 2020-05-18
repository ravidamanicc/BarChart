//
//  BeautifulBarEntry.swift
//  BarChart
//
//  Created by Nguyen Vu Nhat Minh on 22/5/19.
//  Copyright © 2019 Nguyen Vu Nhat Minh. All rights reserved.
//

import Foundation
import CoreGraphics.CGGeometry

struct BeautifulBarEntry {
    let origin: CGPoint
    let barWidth: CGFloat
    let barHeight: CGFloat
    let data: DataEntry
    let mainBarEntry: MainBarEntry
    let mainBarEntryUpsideDown: MainBarEntryUpsideDown
    let topBubbleEntry: TopBubbleEntry
    let bottomBubbleEntry: BottomBubbleEntry
    
    init(origin: CGPoint, barWidth: CGFloat, barHeight: CGFloat, data: DataEntry) {
        self.origin = origin
        self.barWidth = barWidth
        self.barHeight = barHeight
        self.data = data
        self.mainBarEntry = MainBarEntry(origin: self.origin, barWidth: barWidth, barHeight: barHeight)
        self.mainBarEntryUpsideDown = MainBarEntryUpsideDown(origin: self.origin, barWidth: barWidth, barHeight: barHeight)

        self.topBubbleEntry = TopBubbleEntry(bottomLeftPoint: CGPoint(x: self.origin.x, y: self.origin.y + barHeight), barWidth: barWidth, barHeight: barHeight)
        self.bottomBubbleEntry = BottomBubbleEntry(bottomLeftPoint: CGPoint(x: self.origin.x, y: self.origin.y + barHeight + 240), barWidth: barWidth, barHeight: barHeight)

    }
    
    var bottomTitleFrame: CGRect {
        return CGRect(x: origin.x, y: origin.y + barHeight + 10, width: barWidth, height: 22)
    }
    
    var linkingLine: LineSegment {
        let startPoint = CGPoint(x: origin.x + barWidth / 2, y: origin.y - 4)
        let endPoint = CGPoint(x: startPoint.x, y: startPoint.y - 40)
        return LineSegment(startPoint: startPoint, endPoint: endPoint)
    }
}

struct MainBarEntry {
    let origin: CGPoint
    let barWidth: CGFloat
    let barHeight: CGFloat
    
    var curvedSegments: [CurvedSegment] {
        var startPoint, endPoint, toPoint, controlPoint1, controlPoint2: CGPoint
        
        startPoint = CGPoint(x: origin.x, y: origin.y + barHeight)
        endPoint = CGPoint(x: origin.x + barWidth/2, y: origin.y + barHeight)
        toPoint = CGPoint(x: origin.x + barWidth/2, y: origin.y)
        controlPoint1 = CGPoint(x: (origin.x + barWidth/2), y: origin.y + barHeight)
        controlPoint2 = CGPoint(x: origin.x + barWidth*3/10, y: origin.y)
        let segment1 = CurvedSegment(startPoint: startPoint, endPoint: endPoint, toPoint: toPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)

        startPoint = CGPoint(x: origin.x + barWidth, y: origin.y + barHeight)
        endPoint = CGPoint(x: origin.x + barWidth/2, y: origin.y + barHeight)
        toPoint = CGPoint(x: origin.x + barWidth/2, y: origin.y)
        controlPoint1 = CGPoint(x: origin.x+barWidth/2, y: origin.y + barHeight)
        controlPoint2 = CGPoint(x: origin.x + barWidth*7/10, y: origin.y)
        let segment2 = CurvedSegment(startPoint: startPoint, endPoint: endPoint, toPoint: toPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        

        
        return [segment1, segment2]
    }
}

struct MainBarEntryUpsideDown {
    let origin: CGPoint
    let barWidth: CGFloat
    let barHeight: CGFloat
    
    var curvedSegments: [CurvedSegment] {
        var startPoint, endPoint, toPoint, controlPoint1, controlPoint2: CGPoint
        
        
        startPoint = CGPoint(x: origin.x, y: origin.y )
        endPoint = CGPoint(x: origin.x + barWidth/2, y: origin.y )
        toPoint = CGPoint(x: origin.x + barWidth/2, y: origin.y + barHeight)
        controlPoint1 = CGPoint(x: (origin.x + barWidth/2), y: origin.y )
        controlPoint2 = CGPoint(x: origin.x + barWidth*3/10, y: origin.y + barHeight)
        let segment1 = CurvedSegment(startPoint: startPoint, endPoint: endPoint, toPoint: toPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        
        startPoint = CGPoint(x: origin.x + barWidth, y: origin.y )
        endPoint = CGPoint(x: origin.x + barWidth/2, y: origin.y)
        toPoint = CGPoint(x: origin.x + barWidth/2, y: origin.y  + barHeight)
        controlPoint1 = CGPoint(x: origin.x+barWidth/2, y: origin.y )
        controlPoint2 = CGPoint(x: origin.x + barWidth*7/10, y: origin.y + barHeight)
        let segment2 = CurvedSegment(startPoint: startPoint, endPoint: endPoint, toPoint: toPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        
        return [segment1, segment2]
    }
}

struct TopBubbleEntry {
    private let topBubbleRadius: CGFloat = 32.0
    private var curvedValue: CGFloat {
        /// This curveValue helps to create 2 control points that can be used to draw a quater of a circle using Bezier curve function
        return 0.552284749831 * topBubbleRadius
    }
    
    let origin: CGPoint
    var textValueFrame: CGRect {
        return CGRect(x: origin.x, y: origin.y - 20, width: topBubbleRadius * 2, height: 32)
    }
    
    init(bottomLeftPoint point: CGPoint, barWidth: CGFloat, barHeight: CGFloat) {
        self.origin = CGPoint(x: point.x + barWidth / 2 - topBubbleRadius, y: round(point.y - barHeight - 80))
    }
    
    var curvedSegments: [CurvedSegment] {
        var startPoint, endPoint, toPoint, controlPoint1, controlPoint2: CGPoint
        
        startPoint = origin
        endPoint = CGPoint(x: origin.x + topBubbleRadius, y: origin.y)
        toPoint = CGPoint(x: origin.x + topBubbleRadius, y: origin.y - topBubbleRadius)
        controlPoint1 = CGPoint(x: origin.x, y: origin.y - curvedValue)
        controlPoint2 = CGPoint(x: origin.x + topBubbleRadius - curvedValue, y: origin.y - topBubbleRadius)
        let segment1 = CurvedSegment(startPoint: startPoint, endPoint: endPoint, toPoint: toPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        
        startPoint = CGPoint(x: origin.x + topBubbleRadius, y: origin.y - topBubbleRadius)
        endPoint = CGPoint(x: origin.x + topBubbleRadius, y: origin.y)
        toPoint = CGPoint(x: origin.x + topBubbleRadius*2, y: origin.y)
        controlPoint1 = CGPoint(x: origin.x + topBubbleRadius + curvedValue, y: origin.y - topBubbleRadius)
        controlPoint2 = CGPoint(x: origin.x + topBubbleRadius * 2, y: origin.y - curvedValue)
        let segment2 = CurvedSegment(startPoint: startPoint, endPoint: endPoint, toPoint: toPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        
        startPoint = origin
        endPoint = CGPoint(x: origin.x + topBubbleRadius, y: origin.y)
        toPoint = CGPoint(x: origin.x + topBubbleRadius, y: origin.y + topBubbleRadius*1.5)
        controlPoint1 = CGPoint(x: origin.x, y: origin.y + curvedValue)
        controlPoint2 = CGPoint(x: origin.x + topBubbleRadius - curvedValue, y: origin.y + topBubbleRadius)
        let segment3 = CurvedSegment(startPoint: startPoint, endPoint: endPoint, toPoint: toPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        
        startPoint = CGPoint(x: origin.x + topBubbleRadius*2, y: origin.y)
        endPoint = CGPoint(x: origin.x + topBubbleRadius, y: origin.y)
        toPoint = CGPoint(x: origin.x + topBubbleRadius, y: origin.y + topBubbleRadius * 1.5)
        controlPoint1 = CGPoint(x: origin.x + topBubbleRadius * 2, y: origin.y + curvedValue)
        controlPoint2 = CGPoint(x: origin.x + topBubbleRadius + curvedValue, y: origin.y + topBubbleRadius)
        let segment4 = CurvedSegment(startPoint: startPoint, endPoint: endPoint, toPoint: toPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        
        return [segment1, segment2, segment3, segment4]
    }
}

struct BottomBubbleEntry {
    private let topBubbleRadius: CGFloat = 32.0
    private var curvedValue: CGFloat {
        /// This curveValue helps to create 2 control points that can be used to draw a quater of a circle using Bezier curve function
        return 0.552284749831 * topBubbleRadius
    }
    
    let origin: CGPoint
    var textValueFrame: CGRect {
        return CGRect(x: origin.x, y: origin.y - 10, width: topBubbleRadius * 2, height: 32)
    }
    
    init(bottomLeftPoint point: CGPoint, barWidth: CGFloat, barHeight: CGFloat) {
        self.origin = CGPoint(x: point.x + barWidth / 2 - topBubbleRadius, y: round(point.y - 160))
    }
    
    var curvedSegments: [CurvedSegment] {
        var startPoint, endPoint, toPoint, controlPoint1, controlPoint2: CGPoint
        
        startPoint = origin
        endPoint = CGPoint(x: origin.x + topBubbleRadius, y: origin.y)
        toPoint = CGPoint(x: origin.x + topBubbleRadius, y: origin.y - topBubbleRadius * 1.5)
        controlPoint1 = CGPoint(x: origin.x, y: origin.y - curvedValue)
        controlPoint2 = CGPoint(x: origin.x + topBubbleRadius - curvedValue, y: origin.y - topBubbleRadius)
        let segment1 = CurvedSegment(startPoint: startPoint, endPoint: endPoint, toPoint: toPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        
        startPoint = CGPoint(x: origin.x + topBubbleRadius, y: origin.y - topBubbleRadius * 1.5)
        endPoint = CGPoint(x: origin.x + topBubbleRadius, y: origin.y)
        toPoint = CGPoint(x: origin.x + topBubbleRadius*2, y: origin.y)
        controlPoint1 = CGPoint(x: origin.x + topBubbleRadius + curvedValue, y: origin.y - topBubbleRadius)
        controlPoint2 = CGPoint(x: origin.x + topBubbleRadius * 2, y: origin.y - curvedValue)
        let segment2 = CurvedSegment(startPoint: startPoint, endPoint: endPoint, toPoint: toPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        
        startPoint = origin
        endPoint = CGPoint(x: origin.x + topBubbleRadius, y: origin.y)
        toPoint = CGPoint(x: origin.x + topBubbleRadius, y: origin.y + topBubbleRadius )
        controlPoint1 = CGPoint(x: origin.x, y: origin.y + curvedValue)
        controlPoint2 = CGPoint(x: origin.x + topBubbleRadius - curvedValue, y: origin.y + topBubbleRadius)
        let segment3 = CurvedSegment(startPoint: startPoint, endPoint: endPoint, toPoint: toPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        
        startPoint = CGPoint(x: origin.x + topBubbleRadius*2, y: origin.y)
        endPoint = CGPoint(x: origin.x + topBubbleRadius, y: origin.y)
        toPoint = CGPoint(x: origin.x + topBubbleRadius, y: origin.y + topBubbleRadius )
        controlPoint1 = CGPoint(x: origin.x + topBubbleRadius * 2, y: origin.y + curvedValue)
        controlPoint2 = CGPoint(x: origin.x + topBubbleRadius + curvedValue, y: origin.y + topBubbleRadius)
        let segment4 = CurvedSegment(startPoint: startPoint, endPoint: endPoint, toPoint: toPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        
        return [segment1, segment2, segment3, segment4]
    }
}
