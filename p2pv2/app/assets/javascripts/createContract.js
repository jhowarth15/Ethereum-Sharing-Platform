var Web3 = require('web3');
var web3 = new Web3();
web3.setProvider(new web3.providers.HttpProvider("http://146.169.46.150:9500"));

//source must be on one line for the solidity compiler
var source = "contract Loan { /* Define variable owner of the type address*/ address borrower; address lender; uint loan_amount; uint time_created; uint expiry; /* Constructor - this runs when the contract is executed */ function Loan(address _lender, uint _loan_amount, uint _expiry) public { borrower = msg.sender; lender = _lender; loan_amount = _loan_amount; time_created = now; expiry = _expiry; } /* Getter function for borrower */ function getBorrower() returns(address){ return borrower; } /* Getter function for loan amount */ function getLoanAmount() returns(uint){ return loan_amount; } /* Getter function for borrower */ function getLender() returns(address){ return lender; } /* Termination #1: return item within time. */ function returnLoan() { if (msg.sender == lender) { lender.send(loan_amount); suicide(borrower); } } /* Termination #2: item not returned within time. */ function depositToLender() { if ((msg.sender == lender) && (now - time_created > expiry)) { suicide(lender); } } }"

//compile and create contract Shell
var compiled = web3.eth.compile.solidity(source);
var code = compiled.Loan.code;
var abi = compiled.Loan.info.abiDefinition;
var myContract;

global.createExampleContract = function() {

    //Set Parameters for the contract
    //var borrower = web3.eth.accounts[1];
    //var lender = web3.eth.accounts[2];
    var expiry = 300;
    var loan_amount = 1190476190400000000;
    var deposit = 2380952380950000000;
    var lender = document.getElementById('ethLendNo').innerHTML;
    var borrower = document.getElementById('accNo').innerHTML;
    

    // Create contract instance and include function for asyncronous calls
    document.getElementById('status').innerText = "transaction sent, waiting for confirmation";
    window.alert( "Transaction sent, waiting for confirmation....");
    web3.eth.contract(abi).new(lender, loan_amount, expiry,{from:borrower, data: code, gas:300000, value:deposit}, function (err, contract) {
        if(err) {
            console.error(err);
            return;
            // callback fires twice, we only want the second call when the contract is deployed
        } else if(contract.address){
            myContract = contract;
	    document.getElementById('status').innerText = 'Mined!';
	    window.alert( "Contract has been mined!\n\nContract Address:"+myContract.address);
	    document.getElementById('contractAddress').value = myContract.address;
	}
    });	   
}
