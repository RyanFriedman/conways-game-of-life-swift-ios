//
//  Cell.swift
//  GameOfLife
//
//  Created by Ryan Friedman on 5/25/16.
//  Copyright © 2016 vibrantlight. All rights reserved.
//

import UIKit

class Cell: UIView {

    var row: Int!
    var col: Int!
    var alive: Bool = Bool.random()
    
    // Need neighboring cells in grid
    var neighbors: [Cell] = []
    
    init(_ frame: CGRect, row: Int, col: Int){
        super.init(frame: frame)
        
        self.row = row
        self.col = col
        
        manageBackgroundColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func die() {
        self.alive = false
        manageBackgroundColor()
    }
    
    func birth() {
        self.alive = true
        manageBackgroundColor()
    }
    
    func manageBackgroundColor() {
        let color = self.alive ? UIColor.blackColor() : UIColor.whiteColor()
        self.backgroundColor = color
    }

    // We return a function to be exectued at a later time,
    // this ensures a cell doesn't die or birth before it's neighbors
    // have had a change to evalute themselves
    func fate() -> () -> () {
        
        var livingNeighbors = 0
        for cell in self.neighbors {
            if cell.alive { livingNeighbors += 1 }
        }
        
        // Condition 1 Any live cell with fewer than two live neighbours dies, as if caused by under-population.
        // Condition 2 Any live cell with two or three live neighbours lives on to the next generation.
        // Condition 3 Any live cell with more than three live neighbours dies, as if by over-population.

        if self.alive {

            if livingNeighbors < 2 {
                return self.die
            }
            
            if livingNeighbors == 2 || livingNeighbors == 3 {
                return self.birth
            }
            
            if livingNeighbors > 3 {
                return self.die
            }
        }
        
        // Condition 4 Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

        if self.alive == false {
            
            if livingNeighbors == 3 {
                return self.birth
            }
        }

        return {}
        
    }
}

extension Bool {
    static func random() -> Bool {
        return arc4random_uniform(2) == 0
    }
}