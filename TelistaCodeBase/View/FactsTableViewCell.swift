//
//  FactsTableViewCell.swift
//  TelistaCodeBase
//
//  Created by Kameswararao on 26/06/20.
//  Copyright © 2020 VamsiKrishna. All rights reserved.
//

import UIKit

class FactsTableViewCell: UITableViewCell {
    let labelTitle : UILabel! = UILabel()
    let labelDescription : UILabel! = UILabel()
    let imageFact : UIImageView! = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createTitleLabel()
        createDescLabel()
        createImageView()
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FactsTableViewCell{
    
// creating the title label programatically and adding to conatiner view
    func createTitleLabel(){
          labelTitle.font = UIFont(name: "Arial-BoldMT", size: 17)
          labelTitle.tag = 1
          labelTitle.textColor = UIColor.black
          labelTitle.backgroundColor = UIColor.clear
          labelTitle.numberOfLines = 0
          labelTitle.translatesAutoresizingMaskIntoConstraints = false;
          labelTitle.preferredMaxLayoutWidth = self.frame.size.width;// assumes the parent view has its frame already set.
          labelTitle.text = "No title available"
          labelTitle.sizeToFit()
          labelTitle.setNeedsDisplay()
          self.contentView.addSubview(labelTitle)
    }
    
// creating the title label programatically and adding to conatiner view
    func createDescLabel(){
        labelDescription.font = UIFont(name: "Arial", size: 15)
        labelDescription.tag = 1
        labelDescription.textColor = UIColor.darkText
        labelDescription.numberOfLines = 0
        labelDescription.translatesAutoresizingMaskIntoConstraints = false;
        labelDescription.preferredMaxLayoutWidth = self.frame.size.width;// assumes the parent view has its frame already set.
        labelTitle.text = "No description available"
        labelDescription.sizeToFit()
        labelDescription.setNeedsDisplay()
        self.contentView.addSubview(labelDescription)
    }
    
// creating the UIImage programatically and adding to conatiner view
    func createImageView(){
        imageFact.translatesAutoresizingMaskIntoConstraints = false
        imageFact.backgroundColor = UIColor.darkGray
        self.contentView.addSubview(imageFact)
    }
    
//setting up layout constrains to fit the title, description and image into the cell
    func setConstraints(){
        let left : NSLayoutConstraint = NSLayoutConstraint.init(item: self.labelTitle as Any, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.contentView, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 5)
        let top : NSLayoutConstraint = NSLayoutConstraint.init(item: self.labelTitle as Any, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.contentView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 5)
        let right : NSLayoutConstraint = NSLayoutConstraint.init(item: self.labelTitle as Any, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.contentView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 5)
        self.contentView.addConstraints([top, left,right])
        
        let topDescription : NSLayoutConstraint = NSLayoutConstraint.init(item: self.labelDescription as Any, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.labelTitle, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 5)
        let leftDescription : NSLayoutConstraint = NSLayoutConstraint.init(item: self.labelDescription as Any, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.contentView, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 10)
        let rightDescription : NSLayoutConstraint = NSLayoutConstraint.init(item: self.labelDescription as Any, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.contentView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: -10)
        self.contentView.addConstraints([topDescription, leftDescription,rightDescription])
        
        let topImage : NSLayoutConstraint = NSLayoutConstraint.init(item: self.imageFact as Any, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.labelDescription, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 5)
        let leftImage : NSLayoutConstraint = NSLayoutConstraint.init(item: self.imageFact as Any, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.contentView, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 10)
        let heightImage : NSLayoutConstraint = NSLayoutConstraint.init(item: self.imageFact as Any, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 150)
        let widthImage : NSLayoutConstraint = NSLayoutConstraint.init(item: self.imageFact as Any, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 150)
        let bottomImage : NSLayoutConstraint = NSLayoutConstraint.init(item: self.imageFact as Any, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.contentView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: -10)
        NSLayoutConstraint.activate([topImage, leftImage, heightImage,widthImage,bottomImage])
        self.contentView.addConstraints([topImage, leftImage, heightImage,widthImage,bottomImage])
    }
}
