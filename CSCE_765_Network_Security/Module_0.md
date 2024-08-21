# Computer and Network Security

## Why is it important?
#### Our computers are quite vulnerable:
- **Poor design or after-the-fact design**
- **Lack of awareness and education**
- **Weak threat model and underestimation of attacker capabilities**
- **Buggy software**

### Threats, Vulnerabilities, and Attacks
- **A threat** to a system is any potential occurrence, malicious or otherwise, that can have an adverse effect on the assets and resources associated with the system.
- **A vulnerability** of a system is some characteristic that makes it possible for a threat to occur.
- **An attack** on a system is some action that involves exploitation of some vulnerability in order to cause an existing threat to occur.

### Types of Threats
#### Threats can be classified into four broad categories:
- **Disclosure**: unauthorized access to information.
- **Deception**: acceptance of false data.
- **Disruption**: interruption or prevention of correct operation.
- **Usurpation**: unauthorized control of some part of a system.

#### Examples:
- Snooping
- Sniffing
- Spoofing
- Delaying
- Denial of Service
- Malware
- Theft of Computational Resources

### Primary Issues
#### Confidentiality
- Prevention of unauthorized disclosure of information.

#### Integrity
- Prevention of unauthorized modification of information.

#### Availability
- Ability to withstand unauthorized withholding of information or resources.

## Network Attacks

### Passive Attacks

#### 1. Release of Message Contents
**Scenario**:
- Bob sends Alice a message over a network or the internet.
- Darth can read Bob's message to Alice.

**Consequence**:
- Essentially, it reveals what Bob is saying to Alice.

**Fun Note**:
- An MIT Technology Report in '79 used "Alice" and "Bob." Thus, it became a tradition.

#### 2. Traffic Analysis
**Scenario**:
- Bob sends Alice a message over a network or the internet.
- Darth can observe the pattern of messages from Bob to Alice.

**Consequence**:
- Essentially, it ONLY reveals the fact that Bob is talking to Alice.

#### Final Notes on Passive Attacks
- Passive attacks are VERY difficult to detect as there aren't any noticeable consequences since they are passive in nature...
- To avoid these, focus on prevention.
