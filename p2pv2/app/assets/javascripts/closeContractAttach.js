var Web3 = require('web3');
var web3 = new Web3();
web3.setProvider(new web3.providers.HttpProvider("http://146.169.46.150:9500"));


//set parameters
//var borrower = web3.eth.accounts[1];
//var lender = web3.eth.accounts[2];
var expiry = 300;
var loan_amount = 1190476190400000000;
var deposit = 2380952380950000000;



// FUNCTION TO CLOSE THE CONTRACT IN AN ASYNCRONOUS WAY
global.closeContract = function() {

    // get loan address from HTML
    var contrAddr = document.getElementById('contractAddr').innerHTML;
    // get borrower address
    var lender = document.getElementById('accNo').innerHTML; 
    var borrower = document.getElementById('ethBorrNo').innerHTML; 

  
    //create empty contract shell
    var source = "contract Loan { /* Define variable owner of the type address*/ address borrower; address lender; uint loan_amount; uint time_created; uint expiry; /* Constructor - this runs when the contract is executed */ function Loan(address _lender, uint _loan_amount, uint _expiry) public { borrower = msg.sender; lender = _lender; loan_amount = _loan_amount; time_created = now; expiry = _expiry; } /* Getter function for borrower */ function getBorrower() returns(address){ return borrower; } /* Getter function for loan amount */ function getLoanAmount() returns(uint){ return loan_amount; } /* Getter function for borrower */ function getLender() returns(address){ return lender; } /* Termination #1: return item within time. */ function returnLoan() { if (msg.sender == lender) { lender.send(loan_amount); suicide(borrower); } } /* Termination #2: item not returned within time. */ function depositToLender() { if ((msg.sender == lender) && (now - time_created > expiry)) { suicide(lender); } } }";

    var compiled = web3.eth.compile.solidity(source);
    var code = compiled.Loan.code;
    var abi = compiled.Loan.info.abiDefinition;
    var LoanContract = web3.eth.contract(abi);

    //Attach the shell to correct loan instance
    var myContract = LoanContract.at(contrAddr);
    
    //close the contract - anynchronous call
    document.getElementById('status').innerText = "transaction sent";
    myContract.returnLoan.sendTransaction({from:lender}, function (err, thash) {
        if(err) {
            console.error(err);
            return;
            // callback fires twice, we only want the second call when the contract is deployed
        } //else if (thash) {
            //document.getElementById('status').innerText = 'Mined!' + thash;
        //}
    });

//TO UNCOMMENT !!!!!!!!!!!!!!!!!!!!!!!!!!!
    // can be 'latest' or 'pending'
//    var filter = web3.eth.filter(contrAddr);

    // watch for changes
  //  filter.watch(function(error, result){
//	if (!error){
//	    console.log(result);
//	    filter.stopWatching();
  //          document.getElementById('status').innerText = 'Mined!';
//	}
  //  });


    //web3.eth.watch({altered: web3.eth.accounts[1]}).changed(function(){
//	web3.eth.balanceAt(web3.eth.accounts[1]).then(function(result){
//	    document.getElementById('status').innerText = 'Mined!';
//	});
  //  });
    
    web3.eth.watch().changed(function(){
	web3.eth.block(web3.eth.number).then(function(result){
	    document.getElementById('status').innerText = 'Mined!';
//	    document.getElementById('latestBlock').innerText = web3.eth.number._result;
//	    document.getElementById('latestBlockHash').innerText = result.hash;
//	    document.getElementById('latestBlockTimestamp').innerText = Date(result.timestamp);
	})
    });

    //myContract.getBorrower.call(function(err,code){
//	if (code){
//	    document.getElementById('status').innerText = 'Mined!';
//	}
  //  });

}
