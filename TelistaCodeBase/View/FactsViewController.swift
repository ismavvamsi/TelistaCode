//
//  FactsViewController.swift
//  TelistaCodeBase
//
//  Created by Kameswararao on 26/06/20.
//  Copyright © 2020 VamsiKrishna. All rights reserved.
//

import UIKit

class FactsViewController: UIViewController, UITableViewDelegate,UITableViewDataSource ,FetchJsonObjectDelegate{
    var canadafactsList : FactsModel!
    let tableView: UITableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        //Adding delegate and datsource to presennt data on table view
        tableView.frame = self.view.frame
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView.init()
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        
        //tableView programaticall added to main view
        self.view.addSubview(tableView)
        
        //creating 'Pull down to refresh' functionalty using refreshController
        let factsRefreshControl : UIRefreshControl = UIRefreshControl()
        tableView.refreshControl = factsRefreshControl;
        tableView.refreshControl?.addTarget(self, action: #selector(refreshTableView), for: UIControl.Event.valueChanged)
        
        //fetcjing data from service class to populate the table view
        fetchJsonData()
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.rowHeight = UITableView.automaticDimension
        //addidng table view constraints to main view
        setConstraintsForTableView()
    }
    
    //we hide the sttus bar as is overlaps with the table view because of tranparancy
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func fetchJsonData(){
        let service : FactsService = FactsService()
        service.delegate = self
        
        /*Service call Using Alomofire */
        service.fetchJsonObjectWithAlomofire()
        
        /*Service call without Using Alomofire
        service.fetchJsonObjectWithoutAlomofire()
            */
    }
    
    @objc func refreshTableView(){
        if((tableView.refreshControl) != nil){
            fetchJsonData()
            tableView.reloadData()
            tableView.refreshControl?.endRefreshing()
        }
    }
    
    func setConstraintsForTableView(){
        let width = NSLayoutConstraint(item: self.tableView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation(rawValue: 0)!, toItem: self.view, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1.0, constant: 0)
        let height = NSLayoutConstraint(item: self.tableView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation(rawValue: 0)!, toItem: self.view, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1.0, constant: 0)
        let top = NSLayoutConstraint(item: self.tableView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0 , constant: 0)
        let leading = NSLayoutConstraint(item: self.tableView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 0)
        self.view.addConstraints([width, height, top, leading])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func UpdateFactsDataInUI(factsData: FactsModel) {
        //we should remove any cell which does not have any data
        self.canadafactsList = factsData
        //removing cells with nil content
        self.canadafactsList.rows = self.canadafactsList.rows?.filter { !($0.title == nil && $0.description == nil && $0.imageHref == nil) }
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func networkfailureAlert(message: String) {
        DispatchQueue.main.async { [weak self] in
            let alert : UIAlertController = UIAlertController(title: "Error Fetching Facts Data", message: message, preferredStyle: UIAlertController.Style.alert)
            self?.present(alert, animated: true, completion: nil)        }

    }
    
    func serviceFailedWithError(error: Error) {
        let alert : UIAlertController = UIAlertController(title: "Error Fetching Facts Data", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard self.canadafactsList == nil else{
            let title =  self.canadafactsList.title
            
            return title
        }
        return nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        44
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard self.canadafactsList == nil else{
            return (self.canadafactsList.rows?.count)!
        }
        return 0
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier : String = "FactsCell"
        var cell : FactsTableViewCell? = tableView.dequeueReusableCell(withIdentifier: identifier) as? FactsTableViewCell

        if (cell == nil) {
            cell = FactsTableViewCell(style: UITableViewCell.CellStyle.value2, reuseIdentifier: identifier)
        }
        cell?.tag = indexPath.row
        if(canadafactsList != nil){
            cell?.labelTitle.text = self.canadafactsList.rows![indexPath.row].title
            cell?.labelDescription.text = self.canadafactsList.rows![indexPath.row].description
            cell?.imageFact.image = UIImage(named: "noImage");

            DispatchQueue.global(qos: .userInteractive).async{ [weak self] in
                let urlString : String? = self?.canadafactsList.rows![indexPath.row].imageHref
                guard  urlString == nil else{
                    let url : URL? = URL(string: urlString!)
                    do{
                        let imageData : Data = try Data(contentsOf: url!)
                        guard UIImage(data: imageData) == nil else{
                            let image : UIImage? = UIImage(data: imageData)!
                            if(image != nil){
                                DispatchQueue.main.async {
                                    if (cell?.tag == indexPath.row) {
                                        cell?.imageFact.image = image
                                        cell?.setNeedsLayout()
                                    }
                                }
                            }
                            return
                        }
                            return
                    }
                    catch{
                     print("Unable to find image from server")
                    }
                    return
                }
            }
        }
        cell?.layoutIfNeeded()
        cell?.contentView.backgroundColor = UIColor.clear
       
        return cell!
    }
    

}
