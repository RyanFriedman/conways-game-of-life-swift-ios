//
//  Grid.swift
//  GameOfLife
//
//  Created by Ryan Friedman on 5/24/16.
//  Copyright © 2016 vibrantlight. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

struct Cell {
    var x: Int
    var y: Int
}

struct Grid {
    var rows: Int
    var cols: Int
    
    var cells: [Cell] {
        get {
            var cellArray: [Cell] = []
            for row in 0..<rows {
                for col in 0..<cols {
                    cellArray.append(Cell.init(x: row, y: col))
                }
            }
            return cellArray
        }
    }
    
    
    
}
