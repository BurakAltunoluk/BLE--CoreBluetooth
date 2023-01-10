//
//  ViewController.swift
//  ArduinoBlue
//
//  Created by Burak Altunoluk on 09/01/2023.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var choosedUUID = ""
    var nameBleServices = [String]()
    var uuidServices = [String]()
    var centralManager: CBCentralManager!
    var peripheral : CBPeripheral?

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
  
        centralManager.cancelPeripheralConnection(peripheral!)
        choosedUUID = ""
    }
    
    @IBAction func Refresh(_ sender: UIButton) {
        nameBleServices = [String]()
        uuidServices = [String]()
        tableView.reloadData()
        centralManager = CBCentralManager(delegate: self, queue: nil)
       
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        print("Bulunanlar \(peripheral)")
        guard peripheral.name != nil else {return}
        
        nameBleServices.append(peripheral.name ?? "empty")
        uuidServices.append(peripheral.identifier.uuidString)
        tableView.reloadData()
        
  
        if choosedUUID != "" {
        if peripheral.identifier == UUID(uuidString: choosedUUID)  {

            print("Sensor Found!")
            centralManager.stopScan()

            //connect
            centralManager.connect(peripheral, options: nil)
            self.peripheral = peripheral
        }
    }
        

    }
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
      
      //discover all service
      peripheral.discoverServices(nil)
      peripheral.delegate = self

    }
    }


extension ViewController: CBCentralManagerDelegate {

  func centralManagerDidUpdateState(_ central: CBCentralManager) {
    
     switch central.state {
          case .poweredOff:
              print("Is Powered Off.")
          case .poweredOn:
              print("Is Powered On.")
         centralManager.scanForPeripherals(withServices: nil, options: nil)
          case .unsupported:
              print("Is Unsupported.")
          case .unauthorized:
          print("Is Unauthorized.")
          case .unknown:
              print("Unknown")
          case .resetting:
              print("Resetting")
          @unknown default:
            print("Error")
          }
  }
    
}

extension ViewController: CBPeripheralDelegate {
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameBleServices.count    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = nameBleServices[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        choosedUUID = uuidServices[indexPath.row]
        centralManager = CBCentralManager(delegate: self, queue: nil)
        
    }
    
    
    
}
