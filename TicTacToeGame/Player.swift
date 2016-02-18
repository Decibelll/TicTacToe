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
/** Property keeps all player's moves */
	var moves = [Move]()
    
/** Method converts all moved to array of integer tags
- returns: array of integer tags */
    func allMovesToArray() -> [Int]
    {
        var movesArray = [Int]()
        for move in moves {
            movesArray.append( move.tag )
        }
        return movesArray
    }
}
