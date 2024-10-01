//
//  newAutoPark.swift
//  AutoPark
//
//  Created by Александр Белый on 30.09.2024.
//
//НЕ ДОДЕЛАННОЕ
import Foundation
import UIKit

import Darwin


class Vehicle {
    let make: String
    let model: String
    let year: Int
    let capacity: Int
    var currentLoad: Int
    var types: [CargoType]?
    
    init(make: String,
         model: String,
         year: Int,
         capacity: Int,
         currentLoad: Int,
         types: [CargoType]? = nil)
    {
        self.make = make
        self.model = model
        self.year = year
        self.capacity = capacity //целое число, обозначающее грузоподъемность в килограммах.
        self.currentLoad = currentLoad //целое число, обозначающее текущую нагрузку на машину.
        self.types = types
    }

func loadCargo(cargo: Cargo) {
    if  currentLoad + cargo.weight <= capacity {
        currentLoad += cargo.weight
        print ("Груз" .)
    }
    }

 
func unloadCargo(){
    
}
}
class Truck:Vehicle{
var trailerAttached: Bool //булево значение, обозначающее наличие прицепа.
var trailerCapacity: Int? //целое число, представляющее грузоподъемность прицепа (может быть opt.
var trailerTypes: [CargoType]?
    //типы грузов которые может перевозиться (может быть опциональным).
    init(make: String, model: String, year: Int, capacity: Int, trailerAttached: Bool, trailerCapacity: Int? = nil, trailerTypes: [CargoType]? = nil, types: [CargoType]? = nil)
    {
        self.trailerAttached = trailerAttached
        self.trailerCapacity = trailerCapacity
        self.trailerTypes = trailerTypes
        super.init(make: String, model: String, year: 1995, capacity: 1545, currentLoad: 20)
}
    
struct Cargo {
let description: String //строка с описанием груза.
let weight: Int //целое число, обозначающее вес груза.
let type: CargoType //тип груза.
    
    init?(description: String, weight: Int, type: CargoType) {
        if weight <= 0 {
            print ("Вес груза не может быть отрицательным")
            return nil
        }
        self.description = description
        self.weight = weight
        self.type = type
    }
}

enum CargoType {
 case fragile //хрупкий груз.
 case perishable //скоропортящийся груз.
 case bulk //сыпучий груз.
}

class Fleet {
    var vehicles: [Vehicle] = []
    
    func addVehicle(_ vehicle: Vehicle) {
        vehicles.append(vehicle)
        print("\(vehicle.make) \(vehicle.model) добавлен в автопарк.")
    }

    let fragile1 = Cargo(description: "Ваза", weight: 10, type: .fragile)
let perishable1 = Cargo(description: <#T##String#>, weight: <#T##Int#>, type: <#T##Int#>)
let bulk1 = Cargo(description: <#T##String#>, weight: <#T##Int#>, type: <#T##Int#>)
    
let vehicle1 = Vehicle(make: "audi", model: "r8", year: 2015, capacity: 365, currentLoad: 20)
let truck1 = Truck.init(make: "Газель", model:  "ГАЗ 33023", year: 1995, capacity: 1545, trailerAttached: true, trailerCapacity: 1000, trailerTypes: [.bulk])
