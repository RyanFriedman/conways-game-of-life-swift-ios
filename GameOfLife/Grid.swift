//
//  Grid.swift
//  GameOfLife
//
//  Created by Ryan Friedman on 5/24/16.
//  Copyright © 2016 vibrantlight. All rights reserved.
//

import UIKit

class Grid: UIViewController {
    
    var rows: Int! = 50
    var cols: Int! = 50
    var cells: [[Cell]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.buildGridView()
        
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self,
                                                  selector: #selector(tick),
                                                  userInfo: nil,
                                                   repeats: true)
    }
    
    func buildGridView() {
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        
        // Cells are square, i.e. width = height
        let cellWidth = screenWidth / CGFloat(cols)
        let cellHeight = cellWidth
        
        for row in 0..<rows {
            var rowArray: [Cell] = []
            for col in 0..<cols {
                
                let xOrigin = ((screenWidth / CGFloat(cols)) * CGFloat(col))
                let yOrigin = ((screenWidth / CGFloat(rows)) * CGFloat(row))
                
                let frame = CGRect(x: xOrigin, y: yOrigin, width: cellWidth, height: cellHeight)
                
                let cell = Cell.init(frame, row: row, col: col)
                rowArray.append(cell)
                
                self.view.addSubview(cell)
            }
            cells.append(rowArray)
        }
        
    }
    
    func tick() {
        var fates = Array<dispatch_block_t>()
        for row in cells {
            for cell in row {
                self.findNeighbors(cell)
                let fate = cell.fate()
                fates.append(fate)
            }
        }
        
        for fate in fates {
            fate()
        }
    }
    
    func findNeighbors(cell: Cell) {
        cell.neighbors = []
        
        // Find top neighbors
        if (cell.row > 0) {
            let topCell = cells[cell.row - 1][cell.col]
            cell.neighbors.append(topCell)
            
            if (cell.col > 0) {
                let topLeftCell = cells[cell.row - 1][cell.col - 1]
                cell.neighbors.append(topLeftCell)
            }
            
            if (cell.col < (self.cols - 1)) {
                let topRightCell = cells[cell.row - 1][cell.col + 1]
                cell.neighbors.append(topRightCell)
            }
        }
        
        // Find neighbors side by side
        if (cell.col < (self.cols - 1)) {
            let rightCell = cells[cell.row][cell.col + 1]
            cell.neighbors.append(rightCell)
        }
        
        if (cell.col > 0) {
            let leftCell = cells[cell.row][cell.col - 1]
            cell.neighbors.append(leftCell)
        }
        
        // Find bottom neighbors
        if (cell.row < (self.rows - 1)) {
            let bottomCell = cells[cell.row + 1][cell.col]
            cell.neighbors.append(bottomCell)
            
            if (cell.col > 0) {
                let bottomLeftCell = cells[cell.row + 1][cell.col - 1]
                cell.neighbors.append(bottomLeftCell)
            }
            
            if (cell.col < (self.cols - 1)) {
                let bottomRightCell = cells[cell.row + 1][cell.col + 1]
                cell.neighbors.append(bottomRightCell)
            }
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}