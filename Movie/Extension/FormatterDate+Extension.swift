//
//  FormatterDate+Extension.swift
//  Movie
//
//  Created by Raline Maria da Silva on 20/11/22.
//

import Foundation

extension String {
    func formatterDate() -> Self {
        let getDateFormatter = DateFormatter()
        getDateFormatter.dateFormat = "yyyy-MM-dd"
        let setDateFormatter = getDateFormatter.date(from: self)
        guard let setDateFormatter = setDateFormatter else {
            return "nao foi possivel obter a data desejada"
        }
        getDateFormatter.dateFormat = "dd/MM/yy"
        return getDateFormatter.string(from: setDateFormatter)
    }
}
