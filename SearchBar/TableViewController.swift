//
//  TableViewController.swift
//  SearchBar
//
//  Created by Duc on 3/27/19.
//  Copyright © 2019 Duc. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet var table: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var canabisArray = [Canabis]() // to setup table
    
    var currentCanabisArray = [Canabis]() // update table
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCanabis()
        setUpSearchBar()
        alterLayout()
    }

    private func setUpCanabis() {
        //khong doc hai
        canabisArray.append(Canabis(name: "AK-47", doPhe: .khongDocHai, image: "1"))
        canabisArray.append(Canabis(name: "BC GOD CUD", doPhe: .khongDocHai, image: "2"))
        canabisArray.append(Canabis(name: "BC BIG BUD", doPhe: .khongDocHai, image: "3"))
        
        //doc hai
        canabisArray.append(Canabis(name: "BIGDDY EARLY", doPhe: .docHai, image: "4"))
        canabisArray.append(Canabis(name: "BIG BUD", doPhe: .docHai, image: "5"))
        canabisArray.append(Canabis(name: "BIG BANG", doPhe: .docHai, image: "6"))
        
        currentCanabisArray = canabisArray
    }
    
    
    private func setUpSearchBar() {
        searchBar.delegate = self
    }
    
    func alterLayout() {
        table.tableHeaderView = UIView()
        
        //search bar in section header
        table.estimatedSectionHeaderHeight = 50
        
        //search bar in navigation bar
        navigationItem.titleView = searchBar
        
        searchBar.showsScopeBar = false
        searchBar.placeholder = "Search Canibis by Name"
    }
    class Canabis {
        let name: String
        let image: String
        let doPhe: CanabisPhe
        
        init(name: String, doPhe: CanabisPhe, image: String) {
            self.name = name
            self.doPhe = doPhe
            self.image = image

        }
    }
    enum CanabisPhe: String {
        case docHai = "Độc hại"
        case khongDocHai = "Không độc hại"
    }

    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currentCanabisArray.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        
        
        cell.nameLbl.text = currentCanabisArray[indexPath.row].name
        cell.pheLbl.text = currentCanabisArray[indexPath.row].doPhe.rawValue
        cell.imgView.image = UIImage(named: currentCanabisArray[indexPath.row].image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return searchBar
//    }
    
    
//    //search bar in section header
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    
    // Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentCanabisArray = canabisArray
            table.reloadData()
            return}
        currentCanabisArray = canabisArray.filter({ canabis -> Bool in
            canabis.name.lowercased().contains(searchText.lowercased())
        })
        table.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            currentCanabisArray = canabisArray
        case 1:
            currentCanabisArray = canabisArray.filter({ canabis -> Bool in
                canabis.doPhe == CanabisPhe.docHai
                })
        case 2:
            currentCanabisArray = canabisArray.filter({ canabis -> Bool in
                canabis.doPhe == CanabisPhe.khongDocHai
            })
        default:
            break
        }
        table.reloadData()
    }

    
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
