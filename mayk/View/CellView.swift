//
//  CellView.swift
//  mayk
//
//  Created by Yura on 10/23/20.
//

import UIKit

class CellView: UITableViewCell {

    var photoView = UIImageView(frame: CGRect(origin: .zero, size: .zero))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup() {
        contentView.addSubview(photoView)
        
        photoView.translatesAutoresizingMaskIntoConstraints = false
        photoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        photoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        photoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        photoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        photoView.contentMode = .scaleAspectFit
    }

}
