// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract upload{
    struct Record{
        string recordType;
        string recordIPFSFilePath;
    }

    mapping(address => Record[]) public records;

    address immutable onwer;

    constructor(){
        onwer = msg.sender;
    }

    function push(string memory _recordType, string memory _recordIPFSFilePath) public {
        bool isMedical = keccak256(abi.encodePacked(_recordType)) == keccak256(abi.encodePacked("medical"));
        bool isProperty = keccak256(abi.encodePacked(_recordType)) == keccak256(abi.encodePacked("property"));

        require(isMedical || isProperty, "File type not medical or property record");
        require(bytes(_recordIPFSFilePath).length != 0, "File path is empty");

        records[msg.sender].push(Record(_recordType, _recordIPFSFilePath));
    }

    function get() public view returns(Record[] memory){
        return records[msg.sender];
    }
}