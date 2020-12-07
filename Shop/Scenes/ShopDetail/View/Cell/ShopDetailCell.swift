//
//  ShopDetailCell.swift
//  Shop
//
//  Created by Nikolay Eckert on 07.12.2020.
//

import Foundation
import UIKit

class ShopDetailCell: UITableViewCell {
    var isOfficeHours: Bool
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        isOfficeHours = false
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
