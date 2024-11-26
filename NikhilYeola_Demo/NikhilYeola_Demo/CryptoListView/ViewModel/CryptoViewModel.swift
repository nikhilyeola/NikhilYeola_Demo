//
//  CryptoViewModel.swift
//  NikhilYeola_Demo
//
//  Created by Nikhil Yeola on 24/11/24.
//

import Foundation

class CryptoViewModel {
    var allCoins: [CryptoCoin] = []
    var searchText = ""
    var filteredCoins: [CryptoCoin] = []
    var filterTags: [FilterTag] = [
        FilterTag(title: " Active Coins ", isSelected: false),
        FilterTag(title: " Inactive Coins ", isSelected: false),
        FilterTag(title: " Only Tokens ", isSelected: false),
        FilterTag(title: " Only Coins ", isSelected: false),
        FilterTag(title: " New Coins ", isSelected: false)
    ]
    var isLoadingData: Observable<Bool> = Observable(false)
    var errorText = ""
    var isErrorOccured = false
    func getFilterTags() -> [FilterTag]{
        return filterTags
    }
    func loadCoins(completion: @escaping () -> Void) {
        if isLoadingData.value ?? true {
            return
        }
        
        isLoadingData.value = true
        CryptoService().fetchCryptoCoins { [weak self] result in
            self?.isLoadingData.value = false
            switch result {
            case .success(let coins):
                self?.allCoins = coins
                self?.filteredCoins = coins
                completion()
            case .failure(let error):
                self?.isErrorOccured = true
                self?.errorText = error.localizedDescription
            }
        }
    }
    
    func applyFilter(index : Int, isFromSearch : Bool, query : String? = nil){
        filteredCoins.removeAll()
        if isFromSearch == false{
            filterTags[index].isSelected.toggle()
        }
        
        if index == 0{
            if filterTags[1].isSelected == true{
                filterTags[1].isSelected.toggle()
            }
        }
        if index == 1{
            if filterTags[0].isSelected == true{
                filterTags[0].isSelected.toggle()
            }
        }
        if index == 2{
            if filterTags[3].isSelected == true{
                filterTags[3].isSelected.toggle()
            }
        }
        if index == 3{
            if filterTags[2].isSelected == true{
                filterTags[2].isSelected.toggle()
            }
        }
        let isFilterOn = isAnyFilterApplied()
        for currCoin in allCoins{
            var isNeedToAppend = false
            if isFilterOn{
                if filterTags[0].isSelected == true{
                    if currCoin.isActive == true{
                        isNeedToAppend = true
                    }else{
                        continue
                    }
                }
                if filterTags[1].isSelected == true{
                    if currCoin.isActive == false{
                        isNeedToAppend = true
                    }else{
                        continue
                    }
                }
                if filterTags[2].isSelected == true {
                    if currCoin.type.lowercased().contains("token"){
                        isNeedToAppend = true
                    }else{
                        continue
                    }
                }
                if filterTags[3].isSelected == true {
                    if currCoin.type.lowercased().contains("coin"){
                        isNeedToAppend = true
                    }else{
                        continue
                    }
                }
                if filterTags[4].isSelected == true {
                    if currCoin.isNew == true{
                        isNeedToAppend = true
                    }else{
                        continue
                    }
                }
            }else{
                isNeedToAppend = true
            }
            if searchText.isEmpty == false{
                if currCoin.name.localizedCaseInsensitiveContains(query ?? searchText) || currCoin.symbol.localizedCaseInsensitiveContains(query ?? searchText){
                    isNeedToAppend = true
                }else{
                    isNeedToAppend = false
                }
            }
            if isNeedToAppend == true{
                filteredCoins.append(currCoin)
            }
        }
    }
    func isAnyFilterApplied() -> Bool{
        for currFilter in filterTags{
            if currFilter.isSelected == true{
                return true
            }
        }
        return false
    }
    
    func isNewCoin(cryptoCoin : CryptoCoin) -> Bool{
        return cryptoCoin.isNew
    }
}
