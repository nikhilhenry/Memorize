//
//  Pie.swift
//  Memorize
//
//  Created by Nikhil Henry on 14/02/22.
//

import SwiftUI

struct Pie:Shape{
  
  var startAngle:Angle
  var endAngle:Angle
  var clockwise:Bool = false
  
  func path(in rect: CGRect) -> Path {
    let center = CGPoint(x:rect.midX,y:rect.midY)
    let radius = min(rect.size.width,rect.size.height)/2
    let start = CGPoint(
      x:center.x + radius * CGFloat(cos(startAngle.radians)),
      y:center.y + radius * CGFloat(sin(startAngle.radians))
    )
    var p = Path()
    
    p.move(to: center)
    p.addLine(to: start)
    p.addArc(
      center: center,
      radius: radius,
      startAngle: startAngle,
      endAngle: endAngle,
      clockwise: !clockwise)
    p.addLine(to: center)
    
    return p
  }
}
