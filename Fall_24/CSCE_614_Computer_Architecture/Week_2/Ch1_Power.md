# Chapter 1: Fundamentals of Quantitative Design and Analysis

## Power/Energy, Cost, and Reliability

### Power and Energy

#### Problem:
- Get power in, get power out

#### Thermal Design Power (TDP)
- Characterizes sustained power consumption
- Used as a target for power supply and cooling system
- Lower than peak power (1.5x higher), higher than average power consumption

- Clock rate can be reduced dynamically to limit power consumption
- Reducing power consumption is important; however, energy per task is often a better measurement
  - Big difference

### Dynamic Energy and Power vs Static Energy and Power

#### Dynamic Energy
- Switching power
  - Transistor switching from 0 to 1 or 1 to 0
  - 1/2 * Capacitive load * voltage^2

#### Dynamic Power
- 1/2 * Capacitive load * voltage^2 * Frequency switched = C*V^3
- Reducing clock rate reduces power, not energy

#### Example of Quantifying Power
    Suppose 15% reduction in voltage results in a 15% reduction in frequency. 
    What is impact of dynamic power?

    Power(dyn) = 1/2 * CapacitiveLoad * voltage^2 * frequency_switched

                = 1/2 * 0.85 * CapacitiveLoad * (0.85xVoltage)^2 * frequency_switched
                = (0.85)^3 * Oldpower(dynamic)
                = 0.6 * Oldpower

### Power Trend

- **Intel 80386 (1985)**: 2W
- **Intel Skylake (2017)**: 130W

- Heat must be dissipated from the chip, which can be expensive due to the limit of what can be cooled by air.

### Reducing Power

#### Techniques for reducing power:
- Do nothing well... which is lower efficiency
- Dynamic Voltage-Frequency Scaling
- Low power state for DRAM, disks
- Overclocking one core and turning off other cores

### Static Power

- **Static power consumption:**
  - 25 to 50% of total power
  - Current(static) * Voltage
  - Scales with the number of transistors    Example of Quantifying Power
        Suppose 15% reduction in voltage results in a 15% reduction in frequency. 
        What is impact of dynamic power?

        Power(dyn) = 1/2 * CapacitiveLoad * voltage^2 * frequency_switched

                    = 1/2 * 0.85 * CapacitiveLoad * (0.85xVoltage)^2 * frequency_switched
                    = (0.85)^3 * Oldpower(dynamic)
                    = 0.6 * Oldpower
  - To reduce:
    - **Power gating**: Turning the machine off
    - The same amount of power will be consumed even if there are no tasks running

## Trends in Cost

- **Cost driven down by learning curve:**
  - Yield

- **DRAM:**
  - Price closely tracks cost

- **Microprocessors:**
  - Price depends on volume
  - 10% less for each doubling of volume

## Dependability

### Module reliability:
- **Mean Time to Failure (MTTF):**
  - How often failures happen
  - The reciprocal of MTTF is the rate of failure

- **Mean Time to Repair (MTTR):**
  - How long it takes to recover from failure

- **Mean Time Between Failures (MTBF):** 
  - MTBF = MTTR + MTTF
  - Uptime between failures

- **Availability:** 
  - Availability = MTFF/MTBF