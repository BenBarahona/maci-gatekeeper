# MACI Gatekeeper Challenge 🚪

Welcome to the **MACI Gatekeeper Challenge**! This repository is your starting point for implementing a custom Gatekeeper for voter sign-ups on a [MACI](https://github.com/privacy-scaling-explorations/maci) instance.

---

## 🏁 Challenge Overview

Your task is to:  
1. **Implement** the ERC20Gatekeeper Solidity contract logic.  
2. **Deploy** the contract to a blockchain network.  
3. **Integrate** it as the Gatekeeper for a MACI instance.  

To get started, refer to this guide:  
[Getting Started with MACI](https://medium.com/@bbaraona/getting-started-with-maci-5cc145d00e04)  

### Example Reference: WhitelistGatekeeper  
For inspiration, you can check out the **WhitelistGatekeeper**, which implements a simple logic for managing voter access.  
- After deploying the WhitelistGatekeeper, the deployer must call the `addToWhitelist` method to add addresses to the whitelist.

---