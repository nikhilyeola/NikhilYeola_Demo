//
//  NikhilYeola_DemoTests.swift
//  NikhilYeola_DemoTests
//
//  Created by Nikhil Yeola on 24/11/24.
//

import XCTest
@testable import NikhilYeola_Demo

final class NikhilYeola_DemoTests: XCTestCase {
    
    var viewModel: CryptoViewModel!
    var mockCoins: [CryptoCoin]!
    
    override func setUp() {
        super.setUp()
        viewModel = CryptoViewModel()
        mockCoins = [
            CryptoCoin(name: "Bitcoin", symbol: "BTC", type: "coin", isActive: true, isNew: false),
            CryptoCoin(name: "Ethereum", symbol: "ETH", type: "token", isActive: true, isNew: true),
            CryptoCoin(name: "Litecoin", symbol: "LTC", type: "coin", isActive: false, isNew: false)
        ]
        viewModel.allCoins = mockCoins
    }
    
    func testApplyFilterActiveCoins() {
        viewModel.applyFilter(index: 0, isFromSearch: false)
        print(viewModel.filteredCoins.count)
        XCTAssertEqual(viewModel.filteredCoins.count, 2)
    }
    
    func testSearchFilter() {
        let searchText = "BTC"
        viewModel.searchText = searchText
        viewModel.applyFilter(index: -1, isFromSearch: true, query: searchText)
        print(viewModel.filteredCoins.count)
        XCTAssertEqual(viewModel.filteredCoins.count, 1)
    }
}
