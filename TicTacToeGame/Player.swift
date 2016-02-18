//
//  Player.swift
//  TicTacToeGame
//
//  Created by Sergey on 17.02.16.
//  Copyright © 2016 greenerpastures. All rights reserved.
//

import UIKit

class Player
{
	var moves = [Move]()
    
    func allMovesToArray() -> [Int]
    {
        var movesArray = [Int]()
        for move in moves {
            movesArray.append( move.tag )
        }
        return movesArray
    }
}
