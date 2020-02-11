//
//  PopularVC.swift
//  movie-app
//
//  Created by IRFAN TRIHANDOKO on 04/12/19.
//  Copyright © 2019 IRFAN TRIHANDOKO. All rights reserved.
//

import UIKit

class PopularVC: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchField: UITextField!
    var refreshControl = UIRefreshControl()
    
    var data: PopularModel?
    var dataTemp: PopularModel?
    var request: MovieRequest?
    var isLoadMore: Bool?
    var page: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configTableView()
        configUITest(views: [searchField], idList: ["searchField"])
        showLoading(state: true)
        request?.doGetMovies(type: "popular", page: page)
    }
    
    @IBAction func closeAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func searchChanged(_ sender: UITextField) {
        if sender.text?.isEmpty == false {
            let data = self.data?.list?.filter({$0.title?.lowercased().contains(sender.text?.lowercased() ?? "") == true})
            dataTemp?.list = data
            if dataTemp?.list?.count ?? 0 > 0 {
                tableView.isHidden = false
                showErrorMessage(label: errorMessageLbl, message: "")
                tableView.reloadData()
            } else {
                tableView.isHidden = true
                showErrorMessage(label: errorMessageLbl, message: "No Movies")
            }
        } else {
            dataTemp = data
            tableView.isHidden = false
            showErrorMessage(label: errorMessageLbl, message: "")
            tableView.reloadData()
        }
    }
    
}

// MARK: - Configure Table View
extension PopularVC: UITableViewDelegate, UITableViewDataSource {
    
    func configTableView() {
        searchField.configFieldPadding(left: 10, right: 30)
        tableView.register(UINib(nibName: "PopularCell", bundle: nil), forCellReuseIdentifier: "PopularCell")
        tableView.register(UINib(nibName: "ProgressCell", bundle: nil), forCellReuseIdentifier: "ProgressCell")
        tableView.delegate = self
        tableView.dataSource = self
        setupPullRefresh()
    }
    
    func setupPullRefresh() {
        refreshControl.tintColor = UIColor.white
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return isLoadMore == true ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return dataTemp?.list?.count ?? 0
        } else {
            return 1
        }
        
    }
    
    func popularCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopularCell", for: indexPath) as! PopularCell
        cell.setupData(data: dataTemp?.list?[indexPath.row])
        return cell
    }
    
    func progressCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProgressCell", for: indexPath) as! ProgressCell
        cell.delegate = self
        cell.setLoadMore()
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = indexPath.section == 0 ? popularCell(tableView, cellForRowAt: indexPath) : progressCell(tableView, cellForRowAt: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if errorMessageLbl.text?.isEmpty == true {
            MovieWireframe.performToDetails(caller: self, id: dataTemp?.list?[indexPath.row].id ?? 0)
        }
    }
}

// MARK: - API Integration
extension PopularVC: MovieResponse {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configHome(vc: self)
    }
    
    func configHome(vc: PopularVC) {
        var present = MoviePresenter()
        present.output = vc
        vc.request = present
    }
    
    @objc func refreshData(_ sender: Any) {
        page = 1
        data = nil
        dataTemp = nil
        request?.doGetMovies(type: "popular", page: page)
    }
    
    func displayMovies(result: PopularModel) {
        isLoadMore = page < result.totalPage ?? 0 ? true : false
        page += 1
        if data == nil {
            data = result
            dataTemp = result
        } else {
            data?.list?.append(contentsOf: result.list ?? [])
            dataTemp?.list?.append(contentsOf: result.list ?? [])
        }
        refreshControl.endRefreshing()
        tableView.reloadData()
        showLoading(state: false)
        showErrorMessage(label: errorMessageLbl, message: "")
    }
    
    func displayError(message: String, object: Any) {
        showLoading(state: false)
        showErrorMessage(label: errorMessageLbl, message: message)
    }
    
}

// MARK: - Delegate
extension PopularVC: ProgressDelegate, UITextFieldDelegate {
    
    func loadMore() {
        isLoadMore = true
        request?.doGetMovies(type: "popular", page: page)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
}
