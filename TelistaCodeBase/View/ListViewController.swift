//
//  ListViewController.swift
//  TelistaCodeBase
//
//  Created by Kameswararao on 26/06/20.
//  Copyright © 2020 VamsiKrishna. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, FetchJsonObjectDelegate {
    
    fileprivate var canadafactsList: ListModel!
    private let tableView: UITableView = UITableView()
    private var spinner: UIView?

    //Initial load of a viewcontroller
    override func viewDidLoad() {
        super.viewDidLoad()
        addTableView()
        pullToRefresh()
        setConstraintsForTableView()
        
        //fetcjing data from service class to populate the table view
        fetchJsonData()

        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.rowHeight = UITableView.automaticDimension
        //addidng table view constraints to main view
    }
    
    //Adding delegate and datsource to presennt data on table view
    func addTableView() {
        tableView.frame = self.view.frame
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView.init()
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        
        //tableView programaticall added to main view
        self.view.addSubview(tableView)
    }
    
    //creating 'Pull down to refresh' functionalty using refreshController
    func pullToRefresh() {
        let factsRefreshControl: UIRefreshControl = UIRefreshControl()
        tableView.refreshControl = factsRefreshControl
        tableView.refreshControl?.addTarget(self, action: #selector(refreshTableView), for: UIControl.Event.valueChanged)
    }
    
    //we hide the status bar as is overlaps with the table view because of tranparancy
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //Fetching the jsondata
    func fetchJsonData() {
        let service: ListService = ListService()
        service.delegate = self
        showSpinner(onView: self.view)
        /*Service call Using Alomofire */
        service.fetchJsonObjectWithAlomofire()
        
        /*Service call without Using Alomofire
        service.fetchJsonObjectWithoutAlomofire()
            */
    }
    
    //Refreshing the view controller
    @objc func refreshTableView() {
        if((tableView.refreshControl) != nil) {
            fetchJsonData()
            tableView.reloadData()
            tableView.refreshControl?.endRefreshing()
        }
    }
    
    //Setting Constraints to Tableview to superview
    func setConstraintsForTableView() {
        let width = NSLayoutConstraint(item: self.tableView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1.0, constant: 0)
        let height = NSLayoutConstraint(item: self.tableView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1.0, constant: 0)
        let top = NSLayoutConstraint(item: self.tableView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0)
        let leading = NSLayoutConstraint(item: self.tableView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0)
        self.view.addConstraints([width, height, top, leading])
    }
}

//Tableview Delegate methods
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard self.canadafactsList == nil else {
            return (self.canadafactsList.rows?.count)!
        }
        return 0
    }
    
   func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

//Tableview DataSource methods
extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         guard self.canadafactsList == nil else {
             let title =  self.canadafactsList.title
             
             return title
         }
         return nil
     }
    
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         44
     }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let identifier: String = "FactsCell"
         var cell: DataTableViewCell? = tableView.dequeueReusableCell(withIdentifier: identifier) as? DataTableViewCell

         if (cell == nil) {
             cell = DataTableViewCell(style: UITableViewCell.CellStyle.value2, reuseIdentifier: identifier)
         }
         cell?.tag = indexPath.row
         if(canadafactsList != nil) {
             cell?.labelTitle.text = self.canadafactsList.rows![indexPath.row].title
             cell?.labelDescription.text = self.canadafactsList.rows![indexPath.row].description
             cell?.imageFact.image = UIImage(named: "noImage")

             DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                 let urlString: String? = self?.canadafactsList.rows![indexPath.row].imageHref
                 guard  urlString == nil else {
                     let url: URL? = URL(string: urlString!)
                     do {
                         let imageData: Data = try Data(contentsOf: url!)
                         guard UIImage(data: imageData) == nil else {
                             let image: UIImage? = UIImage(data: imageData)!
                             if(image != nil) {
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
                     } catch {
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

extension ListViewController {
    
    //Showing Loader
    private func showSpinner(onView: UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let activityIndicator = UIActivityIndicatorView.init(style: .gray)
        activityIndicator.startAnimating()
        activityIndicator.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(activityIndicator)
            onView.addSubview(spinnerView)
        }
        
        spinner = spinnerView
    }
    
    //Removing Loader
    private func removeSpinner() {
        DispatchQueue.main.async {
            self.spinner?.removeFromSuperview()
            self.spinner = nil
        }
    }
    
    //Updating UI
    internal func UpdateFactsDataInUI(factsData: ListModel) {
        //we should remove any cell which does not have any data
        self.canadafactsList = factsData
        //removing cells with nil content
        self.canadafactsList.rows = self.canadafactsList.rows?.filter { !($0.title == nil && $0.description == nil && $0.imageHref == nil) }
        self.removeSpinner()
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    //Displayig error alert if network is failed
    internal func networkfailureAlert(message: String) {
          DispatchQueue.main.async { [weak self] in
              let alert: UIAlertController = UIAlertController(title: "Error Fetching Facts Data", message: message, preferredStyle: UIAlertController.Style.alert)
              self?.present(alert, animated: true, completion: nil)        }

      }
    
      //Displaying error alert if service is failed
    internal func serviceFailedWithError(error: Error) {
          let alert: UIAlertController = UIAlertController(title: "Error Fetching Facts Data", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
          self.present(alert, animated: true, completion: nil)
      }
}
