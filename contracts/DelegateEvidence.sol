pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

import "./CoreEvidence.sol";

/**
    Allows delegate submissions.
 */
contract DelegateEvidence is Ownable {
    address immutable coreEvidence;

    constructor(address _coreEvidence) {
        coreEvidence = _coreEvidence;
    }

    function submitEvidence(
        address _address,
        uint64 _timestamp,
        bytes calldata _evidence
    ) external onlyOwner {
        CoreEvidence(coreEvidence).submitEvidence(
            _address,
            _timestamp,
            address(this),
            keccak256(_evidence)
        );
    }
}
