// IncomeListView.swift
import SwiftUI

struct IncomeListView: View {
    @StateObject var viewState: IncomeListViewState

    var body: some View {
        NavigationView {
            List {
                ForEach(viewState.sections) { yearSec in
                    Section(header: yearHeader(yearSec), footer: yearFooter(yearSec)) {
                        ForEach(yearSec.months) { monthSec in
                            Section(header: monthHeader(monthSec)) {
                                ForEach(monthSec.items, id: \.id) { item in
                                    itemRow(item)
                                }
                                .onDelete { offsets in
                                    viewState.deleteItems(at: offsets, in: monthSec, yearId: yearSec.id)
                                }
                            }
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationBarTitle("Incomes", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        viewState.didTapSettings()
                    }) {
                        Image(systemName: "gearshape.fill")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewState.didTapAddIncome()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .onAppear {
            viewState.onAppear()
        }
    }
}

// MARK: - Приватные хелперы

private extension IncomeListView {
    func yearHeader(_ yearSec: YearSection) -> some View {
        Text("\(yearSec.id)")
            .font(.title2)
            .foregroundColor(.blue)
    }
    
    func yearFooter(_ yearSec: YearSection) -> some View {
        let yearTax = yearSec.months.reduce(0.0) { $0 + $1.totalTax }
        let yearIncome = yearSec.months.flatMap{$0.items}.reduce(0.0) { $0 + $1.income }
        
        return HStack {
            Text("Tax for year: \(yearTax, specifier: "%.2f") ₾")
            Spacer()
            Text("Incomes for year: \(yearIncome, specifier: "%.2f") $")
        }
    }
    
    func monthHeader(_ monthSec: MonthSection) -> some View {
        HStack {
            Text("\(monthName(monthSec.id))")
                .font(.headline)
            Spacer()
            Text("\(monthSec.totalTax, specifier: "%.2f") ₾")
                .foregroundColor(.red)
        }
    }
    
    func itemRow(_ item: IncomeItem) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(item.name)
                    .font(.body)
                    .fontWeight(.medium)
                Spacer()
                Text("\(dayOfMonth(item.date))")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            HStack {
                Text(String(format: "$%.2f → %.2f ₾", item.income, item.totalInSelectedCurrency))
                Spacer()
                Text("rate: \(item.selectedCurrencyRate, specifier: "%.2f")")
                    .foregroundColor(.secondary)
            }
            .font(.footnote)
        }
        .padding(.vertical, 4)
    }
    
    func monthName(_ monthNumber: Int) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        let index = max(0, min(monthNumber - 1, 11))
        return formatter.monthSymbols[index]
    }
    
    func dayOfMonth(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: date).uppercased()
    }
}
