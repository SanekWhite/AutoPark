//
//  newAutoPark.swift
//  AutoPark
//
//  Created by Александр Белый on 30.09.2024.
//
//Вроде готово





class Vehicle {
    let make: String//строка, обозначающая марку транспортного средства.
    let model: String //строка, обозначающая модель транспортного средства.
    let year: Int //целое число, обозначающее год выпуска.
    let capacity: Int //целое число, обозначающее грузоподъемность в килограммах.
    var types: [CargoType]? //опциональный массив типов грузов CargoType, если пустой,
    var currentLoad: Int? //целое число, обозначающее текущую нагрузку на машину.
    var fuel: Int
    
    init(make: String, model: String, year: Int, capacity: Int, types: [CargoType]? = nil, fuel: Int) {
        self.make = make
        self.model = model
        self.year = year
        self.capacity = capacity
        self.types = types
        self.fuel = fuel
    }
    
    func loadCargo(cargo: Cargo) { //метод для загрузки груза
        if let supportedTypes = types {
            if supportedTypes .contains(where: { supportedTypes  in
                switch (supportedTypes , cargo.type) {
                case (.fragile, .fragile), (.bulk, .bulk):
                    return true
                case (.perishable, .perishable):
                    return true
                default:
                    return false
                }
            }) {
                print("\(make) \(model) не поддерживает груз типа: \(cargo.type).")
                return
            }
        }
        
        if currentLoad == nil {
            currentLoad = 0
        }
        
        if let load = currentLoad, load + cargo.weight <= capacity { //грузим
            currentLoad = load + cargo.weight
            print ("Груз \(cargo.description) загрузили в \(make) \(model) Текущая нагрузка \(currentLoad!)")
        } else {
            print ("Превышение грузаподьемности \(make) \(model) Нагрузка \(currentLoad!)")
        }
            
    }
    
    func unloadCargo() {
        print ("Груз выгружен из \(make) \(model)")
        currentLoad = nil
        
    }
    
    func canGo(cargo: [Cargo], path: Int) -> Bool {
        var totalCargoWeight = 0
        for item in cargo {
            totalCargoWeight += item.weight
        }
        
        if totalCargoWeight > capacity {
            print("\(make) \(model) не может перевозить грузы весом \(totalCargoWeight) кг. Максимальная грузоподъемность: \(capacity) кг.")
            return false
        }
        
        
        if fuel < path {
            print("\(make) \(model) не может проехать \(path) км. Недостаточно топлива: \(fuel) литров.")
            return false
        }
        
        print("\(make) \(model) может перевезти груз весом \(totalCargoWeight) кг и проехать \(path) км.")
        return true
    }
}



class Truck: Vehicle {
var trailerAttached: Bool  //булево значение, обозначающее наличие прицепа.
var trailerCapacity: Int?  //целое число, представляющее грузоподъемность прицепа
var trailerTypes: [CargoType]?

    init(make: String, model: String, year: Int, capacity: Int, types: [CargoType]? = nil, trailerAttached: Bool, trailerCapacity: Int? = nil, trailerTypes: [CargoType]? = nil, fuel: Int) {
        self.trailerAttached = trailerAttached
        self.trailerCapacity = trailerCapacity
        self.trailerTypes = trailerTypes
        super .init(make: make, model: model, year: year, capacity: capacity, types: types, fuel: fuel)
    }
    override func loadCargo(cargo: Cargo) { //метод для загрузки груза
        if let supportedTypes = types {
            if supportedTypes .contains(where: { supportedTypes  in //xcode заставил свитч испол
                switch (supportedTypes , cargo.type) {
                case (.fragile, .fragile), (.bulk, .bulk):
                    return true
                case (.perishable, .perishable):
                    return true
                default:
                    return false
                }
            }) {
                print("\(make) \(model) не поддерживает груз типа: \(cargo.type).")
                return
            }
        }
    
        if currentLoad == nil {
            currentLoad = 0
        }
        
        let totalCapacity = capacity + (trailerCapacity ?? 0)
        
        if let load = currentLoad, load + cargo.weight <= totalCapacity  {
            currentLoad = load + cargo.weight
            print ("Груз \(cargo.description) загрузили в кузов и прицеп \(make) \(model) Текущая нагрузка \(currentLoad!)")
        } else {
            print ("Превышение грузаподьемности \(make) \(model) Нагрузка \(currentLoad!)")
        }
            
    }

}

struct Cargo { //(Груз):
    
    let description: String //строка с описанием груза.
    let weight: Int //целое число, обозначающее вес груза.
    var type: CargoType //тип груза.
    
    init?(description: String, weight: Int, type: CargoType) {
        if weight < 0 {
            print ("Вес отрицательный")
            return nil
        }
        self.description = description
        self.weight = weight
        self.type = type
    }
    
}

enum CargoType {
    case fragile //хрупкий груз.
    case perishable(temperature: Int)//скоропортящийся груз.
    case bulk //сыпучий груз.
    }


class Fleet {
    
    var vehicles: [Vehicle] = []
    func addVehicle(_ vehicle: Vehicle) {
        vehicles.append(vehicle)
    }
    
    func totalCapacity() -> Int { //метод, возвращающий общую грузоподъемность всех тачек
        var totalCapacity = 0
        for vehicle in vehicles {
            totalCapacity += vehicle.capacity
        }
        return totalCapacity
    }
    
        func totalCurrentLoad() -> Int { //метод, возвращающий текущую суммарную нагруз авто
            var totalLoad = 0
            for vehicle in vehicles {
                if let load = vehicle.currentLoad {
                    totalLoad += load
                }
            }
            return totalLoad
    }
    
    func info () {
        print("Общая грузоподъемность автопарка: \(totalCapacity()) кг.")
        print("Текущая суммарная нагрузка: \(totalCurrentLoad()) кг.")
        for vehicle in vehicles {
            print("\(vehicle.make) \(vehicle.model) - Грузоподъемность: \(vehicle.capacity) кг, Текущая нагрузка: \(vehicle.currentLoad ?? 0) кг")
        }
    }
   
}
// Создание примеров и выполнение операций в функции
func runExample() {
    let vehicle = Vehicle(make: "Газель", model: "ГАЗ 33023", year: 1995, capacity: 1545, fuel: 20)
    let truck = Truck(make: "Камаз", model: "4308-69", year: 2007, capacity: 5000, types: [.perishable(temperature: 17)], trailerAttached: true, trailerCapacity: 1500, fuel: 30)

    let cargoTruck = Cargo(description: "сыпучий груз", weight: 1000, type: .bulk)
    let fragileCargo = Cargo(description: "хрупкий груз", weight: 1000, type: .fragile)
    let perishableCargo = Cargo(description: "скоропортящийся груз", weight: 500, type: .perishable(temperature: 17))

    let fleet = Fleet()
    fleet.addVehicle(vehicle)
    fleet.addVehicle(truck)

    if let cargoTruck = cargoTruck {
        vehicle.loadCargo(cargo: cargoTruck) // Грузим "сыпучий груз" в Камаз
    }
    if let fragileCargo = fragileCargo {
        truck.loadCargo(cargo: fragileCargo) // Пытаемся загрузить хрупкий груз в Газель
    }
    if let perishableCargo = perishableCargo {
        vehicle.loadCargo(cargo: perishableCargo) // Грузим "скоропортящийся груз" в камаз
    }
    let cargoArray = [cargoTruck!, fragileCargo!, perishableCargo!]
      
      
      let canVehicleGo = vehicle.canGo(cargo: cargoArray, path: 30)
      print("Камаз может проехать: \(canVehicleGo)")

      // Проверяем, может ли Газель проехать 15 км с указанными грузами
      let canTruckGo = truck.canGo(cargo: cargoArray, path: 15)
      print("Газель может проехать: \(canTruckGo)")

    
    vehicle.unloadCargo()

    // Печатаем информацию об автопарке
    fleet.info()
}

//run example в viewController
