var Web3 = require('web3');
var web3 = new Web3();
web3.setProvider(new web3.providers.HttpProvider("http://146.169.46.150:9500"));

global.watchBalance = function() {
    //var coinbase = web3.eth.coinbase;
    //var coinbaseBalance = web3.fromWei(web3.eth.getBalance(coinbase),'ether').toFixed(2);
    //var borrower = web3.eth.accounts[1];
    //var borrowerBalance = web3.fromWei(web3.eth.getBalance(borrower),'ether').toFixed(2);
    //var lender = web3.eth.accounts[2];
    //var lenderBalance = web3.fromWei(web3.eth.getBalance(lender),'ether').toFixed(2);
    

    //document.getElementById('coinbaseAcc').innerText = 'Coinbase: ' + coinbase;
    //document.getElementById('amountCoinbase').innerText = ' Balance: ' + coinbaseBalance + ' ether';
    //document.getElementById('accNo').innerText = 'Account Number: ' + borrower;
    //document.getElementById('amountBorrower').innerText = ' Balance: ' + borrowerBalance + ' ether';
    //document.getElementById('lenderAcc').innerText = 'Lender: ' + lender;
    //document.getElementById('amountLender').innerText = ' Balance: ' + lenderBalance + ' ether';


    //check balance of a selected account
    var accToCheck = document.getElementById('accNo').innerHTML;
    var balToCheck = web3.fromWei(web3.eth.getBalance(accToCheck),'ether').toFixed(2);
    var gbpBal = (balToCheck*8.4).toFixed(2);
    document.getElementById('accBal').innerText = ' Balance: ' + balToCheck + ' ether';
    document.getElementById('accBalGBP').innerText = ' Balance: ' + gbpBal + ' GBP';
    


}

