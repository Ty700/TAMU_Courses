## Computer and Network Security

### Why is it important?
#### Our computers are quite vulnerable:
- **Poor design or after-the-fact design**
- **Lack of awareness and education**
- **Weak threat model and underestimation of attacker capabilities**
- **Buggy software**

### Threats, Vulnerabilities, and Attacks
- **A threat** to a system is any potential occurrence, malicious or otherwise, that can have an adverse effect on the assets and resources associated with the system.
- **A vulnerability** of a system is some characteristic that makes it possible for a threat to occur.
- **An attack** on a system is some action that involves exploitation of some vulnerability in order to cause an existing threat to occur.

## Types of Threats
### Threats can be classified into four broad categories:
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

## Primary Issues
### Confidentiality
- Prevention of unauthorized disclosure of information.

### Integrity
- Prevention of unauthorized modification of information.

### Availability
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

### Active Attacks

#### 1. Masquerade
**Scenario**:
- Bob and Alice have an ongoing conversation.
- Darth sends Alice a message that appears to be from Bob.

**Consequence**:
- Alice is deceived and might release critical information to Darth, thinking they're Bob.

#### 2. Replay
**Scenario**:
- Bob sends Alice a message; however, Darth intercepts it.
- Darth captures the message going from Bob to Alice and later replays the message to Alice.

**Consequence**:
- The messages are delayed.

#### 3. Modification of Messages
**Scenario**:
- Bob sends Alice a message.
- Darth not only captures but also modifies the message.

**Consequence**:
- Bob's message is altered and changed.
- Alice thinks Bob is sending the message, but it's really Darth.

#### 4. Denial of Service
**Scenario**:
- The server that is required for Alice and Bob to communicate is being attacked by bots.
- Darth is sending bots to overload the server Alice and Bob are using to communicate.

**Consequence**:
- Darth disrupts the service provided by the server. Thus, Alice and Bob cannot communicate.

#### Final Notes on Active Attacks
- Active attacks are more powerful, yet are easier to spot than passive attacks.

## Network Security
Basically, a class of security techniques that help address the different vulnerabilities of network communications.

### There are other issues that arise in the design of secure systems besides confidentiality, availability, and integrity:
- Accountability
- Reliability
- Access Control
- Authentication
- Non-repudiation
- Privacy and Anonymity

### A security policy is a statement of what is, and is not, allowed:
- Expressed mathematically.
- List of allowed and disallowed actions.

### A security mechanism is a procedure, tool, or method of enforcing security policy.

## Security Policy
A security policy is a set of rules stating which actions are permitted and which are not. It can be informal or highly mathematical.

### If we consider a computer system to be a finite state automaton with state transitions, then:
- A security policy is a statement that partitions the states of a system into a set of authorized or secure states and a set of unauthorized or non-secure states.
- A secure system is a system that starts in an authorized state and cannot enter an unauthorized state.
- A breach of security occurs when a system enters an unauthorized state.

We expect a trusted system to enforce the required security policies.

### Elements of a Security Policy:
- A security policy considers all relevant aspects of confidentiality, integrity, and availability.

#### Confidentiality policy:
- Identifies information leakage and controls information flow.

#### Integrity policy:
- Identifies authorized ways in which information may be altered. Enforces separation of duties.

#### Availability policy:
- Describes what services must be provided.
    - **Example**: A browser may download pages but no Java applets.

## Security Mechanism
A security mechanism is a procedure that enforces some part of a security policy. We will learn many network security mechanisms.

### Goals of Security Mechanism:
Given a policy that specifies what is "secure" and what is "non-secure," the goal of security is to put in place mechanisms that provide:

#### Prevention
- Involves implementing mechanisms that users cannot override and are trusted to be implemented in correct and unalterable ways.

#### Detection
- Goal is to determine that an attack is underway, or has occurred, and report it.

#### Recovery
- Resuming correct operation either after an attack or even while an attack is underway.

## Trust
Security policies and mechanisms are based on assumptions, and one trusts that these assumptions hold.

### Other real-world examples:
- Aspirin from a drugstore is considered trustworthy. 
    - The basis of trust is:
        - Testing and certification by the FDA.
        - Manufacturing standard of the company and regulatory mechanism that ensures it.
        - Safety seal on the bottle.

Similarly, for a secure system to achieve trust, specific steps need to be taken and specific parties need to be trusted.
