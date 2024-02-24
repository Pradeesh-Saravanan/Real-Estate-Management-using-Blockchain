pragma solidity ^0.8.4;
//Creating a contract
contract Realestate{
    //User defined struct
    struct Property{
        uint price;
        address owner;
        bool forsale;
        string name;
        string description;
        string location;
    }
    mapping(uint256 => Property)public properties;
    uint256[] public propertyIds;
    event PropertySold(uint256 propertyId);
    //Fucntion used to list the property for sale
    function listPropertyforsale(uint256 _propertyId,uint256 _price,string memory _name,string memory_description,string memory_location)public{
        Property memory newProperty = Property({
            price:_price,
            owner:msg.sender,
            forsale:true,
            name:_name,
            description:_description,
            location:_location
        });
    properties[_propertyId]=newProperty;
    propertyIds.push(_propertyId);
    }
    //Function for requesting to buy a property
    function buyProperty(uint256 _propertyId) public payable{
        Property storage property = properties[_propertyId];
        require(property.forsale,"Property is not for sale");
        require(property.price<=msg.value,"Insufficient funds");
        property.owner=msg.sender;
        property.forsale=false;
        payable(property.owner).transfer(property.price);

    }
}

