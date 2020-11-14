//
//  AskBidViewController.swift
//  Exschange
//
//  Created by Arman Davidoff on 27.10.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol AskBidDisplayLogic: class {
    func displayData(viewModel: AskBid.Model.ViewModel.ViewModelData)
}

class AskBidViewController: UIViewController, AskBidDisplayLogic {
    
    var interactor: AskBidBusinessLogic?
    
    // MARK: Object lifecycle
    
    
    init(selectedCurrency:CurrencyModel, vcType: VCType) {
        self.selectedCurrency = selectedCurrency
        self.vcType = vcType
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = AskBidInteractor()
        let presenter             = AskBidPresenter()
        viewController.interactor = interactor
        interactor.presenter      = presenter
        presenter.viewController  = viewController
    }
    
    var tableView: UITableView!
    var selectView: SelectView!
    
    var vcType: VCType
    var selectedCurrency: CurrencyModel
    var priceModels:[PriceModelType] = [PriceModel]()
    
    
    override func viewDidLoad() {
        overrideUserInterfaceStyle = .light
        DispatchQueue.main.async {
            self.setupSelectingView()
            self.setupTableView()
            //self.interactor?.makeRequest(request: .getData(currency: self.selectedCurrency,vcType:self.vcType))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.interactor?.makeRequest(request: .subscribeSocket(currency: self.selectedCurrency, vcType: self.vcType))
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        interactor?.makeRequest(request: .unsubscribeSockt)
    }
    
    func displayData(viewModel: AskBid.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayModel(model: let model):
            self.priceModels.insert(model, at: 0)
            self.checkArrayLimit()
        case .displayNewCurrency:
            self.priceModels = []
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

//Setup Subviews
private extension AskBidViewController {
    func setupSelectingView() {
        let viewFrame = CGRect(x: 0, y: self.topBarHeight, width: view.bounds.width, height: AskBidVCSizes.selectViewHeight.rawValue)
        selectView = SelectView(frame: viewFrame,delegate: self)
        self.view.addSubview(selectView)
        selectView.configure(currencyName: selectedCurrency)
    }
    
    func setupTableView() {
        let tableFrame = CGRect(x: 0, y: selectView.frame.maxY, width: view.bounds.width, height: view.bounds.height - selectView.frame.maxY )
        tableView = UITableView(frame: tableFrame)
        self.view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: HeaderView.identifier)
    }
}

//TableViewDataSource&DelegateMethods
extension AskBidViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.identifier) as! HeaderView
        
        header.configure(currency: selectedCurrency)
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return AskBidVCSizes.headerHeight.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return priceModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        
        let model = priceModels[indexPath.row]
        cell.configure(model: model)
        cell.backgroundColor = indexPath.row%2 != 0 ? .systemGray6 : .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AskBidVCSizes.rowHeight.rawValue
    }
}

//PresentTableViewProtocol methods
extension AskBidViewController: PresentTableViewProtocol {
    
    func didSelect(currencyModel: CurrencyModel) {
        //interactor?.makeRequest(request: .getData(currency: currencyModel, vcType: vcType))
        interactor?.makeRequest(request: .selectNewCurrency)
        interactor?.makeRequest(request: .subscribeSocket(currency: currencyModel, vcType: vcType))
        selectedCurrency = currencyModel
        tableView.reloadData()
    }
    
    func addToSubview(_ view: UIView) {
        DispatchQueue.main.async {
            self.view.addSubview(view)
            view.frame.origin.y = self.selectView.frame.maxY
        }
    }
}
//help Funcs
private extension AskBidViewController {
    func checkArrayLimit() {
        if self.priceModels.count > 100 {
            self.priceModels.removeSubrange(100..<self.priceModels.count)
        }
    }
}
