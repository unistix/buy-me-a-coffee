// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract BuyMeACoffee {
    //Event to emit when a Memo is created

    event NewMemo(
        address indexed from,
        uint timestamp,
        string name,
        string message


    );

    //Memo struct 
    struct Memo{
        address from;
        uint timestamp;
        string name;
        string message;

    }

    // List of all memos recieved from friends.
    Memo[] memos;


    //Address of contract deployer - where we withdraw tips from
    address payable owner;

    constructor() {
        owner = payable(msg.sender);
    }


    /*
    * Buy a coffee for contract owner
    * @param _name of the coffee buyer
    * @param _message a nice message from the coffee buyer 
    * @ note memory helps save gas buy free mem on completion
    * 
    */
    function buyCoffee(string memory _name, string memory _message) public payable{
        require(msg.value > 0, "cant buy coffee with 0 eth");

        //Add the memo storage!
        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message


        ));

        //Emit a log event when a new memo is created!
        emit NewMemo(
            msg.sender,
            block.timestamp,
            _name,
            _message

        );
    }


    /*
    * Send Balance in contract to owner 
    *
    */

    function withdrawTips() public {
        //address(this).getBalance;
        require(owner.send(address(this).balance));


    }


     /*
    * Retrievall the memos received and stored on the blockchain
    *
    */
    function getMemos() public view returns(Memo[] memory) {
        return memos;

    }
    
}
