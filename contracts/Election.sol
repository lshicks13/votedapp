pragma solidity ^0.4.2;

contract Election{
    //Model a Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }
    //Store accounts that have voted
    mapping(address => bool) public voters;
    //Store Candidates
    //Fetch Candidate from storage
    mapping(uint => Candidate) public candidates;
    //Keep track of vote counts
    uint public candidatesCount;

    // voted event
    event votedEvent(
        uint indexed _candidateId
    );

    //Constructor
    constructor() public {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }
    
    function addCandidate (string _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote (uint _candidateId) public {
        //require that they haven't voted before
        require(!voters[msg.sender]);
        //require a valid cadidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);
        //Record that the voter has voted
        voters[msg.sender] = true;
        //Update candidate vote count
        candidates[_candidateId].voteCount ++;
        //trigger voted event
        emit votedEvent(_candidateId);
    }
}