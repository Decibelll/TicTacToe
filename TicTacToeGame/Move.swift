//
//  Move.swift
//  TicTacToeGame
//
//  Created by Sergey on 17.02.16.
//  Copyright © 2016 greenerpastures. All rights reserved.
//

import UIKit

class Move
{
	var tag: Int
	
    class func movesFromArray( movesArray: [Int] ) -> [Move]
    {
        var moves = [Move]()
        for rawMove in movesArray {
            moves.append(Move(rawMove))
        }
        return moves
    }
    
	init( _ tag: Int )
	{
		self.tag = tag
	}
}
