import SwiftUI
import Combine
import Darwin

struct ContentView: View {
    @State private var potentialString: String = "10 * x * x" // default potential
    @State private var step: Double = 0.01
    @State private var range: Double = 5.0
    @State private var eigenEnergy: Double = 0.0
    @State private var wavefunction: [Double] = []
    @State private var probabilityDensity: [Double] = []
    @State private var isSolving: Bool = false

    var body: some View {
        VStack {
            Text("1D Schrodinger Equation Solver")
                .font(.title)
                .padding()
            HStack {
                Text("Potential (in x):")
                TextField("", text: $potentialString)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 150)
            }
            .padding()
            HStack {
                Text("Step Size:")
                TextField("", value: $step, formatter: NumberFormatter())
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 100)
            }
            .padding()
            HStack {
                Text("Range:")
                TextField("", value: $range, formatter: NumberFormatter())
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 100)
            }
            .padding()
            Button("Solve Schrodinger Equation") {
                isSolving = true
                solveSchrodingerEquation(potentialString: potentialString, step: step, range: range)
            }
            .padding()
            if isSolving {
                VStack {
                    Text("Eigen Energy: \(eigenEnergy, specifier: "%.4f")")
                        .padding()
                    HStack {
                        ZStack {
                            Path { path in
                                path.move(to: CGPoint(x: 0, y: 150))
                                for i in 0..<wavefunction.count {
                                    let x = Double(i) * step
                                    let y = 150 - wavefunction[i] * 50
                                    path.addLine(to: CGPoint(x: x * 100, y: y))
                                }
                            }
                            .stroke(Color.blue, lineWidth: 2)
                            Text("Wavefunction")
                                .foregroundColor(.blue)
                        }
                        ZStack {
                            Path { path in
                                path.move(to: CGPoint(x: 0, y: 150))
                                for i in 0..<probabilityDensity.count {
                                    let x = Double(i) * step
                                    let y = 150 - probabilityDensity[i] * 500
                                    path.addLine(to: CGPoint(x: x * 100, y: y))
                                }
                            }
                            .stroke(Color.red, lineWidth: 2)
                            Text("Probability Density")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            Spacer()
        }
        .padding()
    }

    func solveSchrodingerEquation(potentialString: String, step: Double, range: Double) {
        var potential = parsePotential(potentialString: potentialString)
        let n = Int(range / step)
        let x = Array(stride(from: 0, to: range, by: step))
        var wavefunction = Array(repeating: 0.0, count: n)
        wavefunction[0] = 0.0
        wavefunction[1] = 0.0001 // small initial value to avoid division by zero
        var probabilityDensity = Array(repeating: 0, count: <#Int#>)
        }
                                       }
