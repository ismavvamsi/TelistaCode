//
//  DataTableViewCell.swift
//  TelistaCodeBase
//
//  Created by Kameswararao on 26/06/20.
//  Copyright © 2020 VamsiKrishna. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {
    public let labelTitle : UILabel! = UILabel()
    public let labelDescription : UILabel! = UILabel()
    public let imageFact : UIImageView! = UIImageView()

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

extension DataTableViewCell{
    
// creating the title label programatically and adding to conatiner view
    private func createTitleLabel(){
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
    private func createDescLabel(){
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
    private func createImageView(){
        imageFact.translatesAutoresizingMaskIntoConstraints = false
        imageFact.backgroundColor = UIColor.darkGray
        self.contentView.addSubview(imageFact)
    }
    
//setting up layout constrains to fit the title, description and image into the cell
    private func setConstraints(){
        let left : NSLayoutConstraint = NSLayoutConstraint.init(item: self.labelTitle as Any, attribute: .left, relatedBy: .equal, toItem: self.contentView, attribute: .left, multiplier: 1, constant: 5)
        let top : NSLayoutConstraint = NSLayoutConstraint.init(item: self.labelTitle as Any, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .top, multiplier: 1, constant: 5)
        let right : NSLayoutConstraint = NSLayoutConstraint.init(item: self.labelTitle as Any, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1, constant: 5)
        self.contentView.addConstraints([top, left,right])
        
        let topDescription : NSLayoutConstraint = NSLayoutConstraint.init(item: self.labelDescription as Any, attribute:.top, relatedBy: .equal, toItem: self.labelTitle, attribute: .bottom, multiplier: 1, constant: 5)
        let leftDescription : NSLayoutConstraint = NSLayoutConstraint.init(item: self.labelDescription as Any, attribute: .left, relatedBy: .equal, toItem: self.contentView, attribute: .left, multiplier: 1, constant: 10)
        let rightDescription : NSLayoutConstraint = NSLayoutConstraint.init(item: self.labelDescription as Any, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1, constant: -10)
        self.contentView.addConstraints([topDescription, leftDescription,rightDescription])
        
        let topImage : NSLayoutConstraint = NSLayoutConstraint.init(item: self.imageFact as Any, attribute: .top, relatedBy: .equal, toItem: self.labelDescription, attribute: .bottom, multiplier: 1, constant: 5)
        let leftImage : NSLayoutConstraint = NSLayoutConstraint.init(item: self.imageFact as Any, attribute: .left, relatedBy: .equal, toItem: self.contentView, attribute: .left, multiplier: 1, constant: 10)
        let heightImage : NSLayoutConstraint = NSLayoutConstraint.init(item: self.imageFact as Any, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 150)
        let widthImage : NSLayoutConstraint = NSLayoutConstraint.init(item: self.imageFact as Any, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 150)
        let bottomImage : NSLayoutConstraint = NSLayoutConstraint.init(item: self.imageFact as Any, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1, constant: -10)
        NSLayoutConstraint.activate([topImage, leftImage, heightImage,widthImage,bottomImage])
        self.contentView.addConstraints([topImage, leftImage, heightImage,widthImage,bottomImage])
    }
}
