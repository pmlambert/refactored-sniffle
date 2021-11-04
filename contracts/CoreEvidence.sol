pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

import "./interfaces/POHEvidence.sol";

/**
    Receives Proof of Humanity submissions by delegates.
 */
contract CoreEvidence is POHEvidence, Ownable {
    mapping(address => ProofOfHumanity) public proofs;

    mapping(address => bool) authorizedDelegates;

    modifier onlyAuthorizedDelegate(address delegate) {
        require(authorizedDelegates[delegate], "Delegate isn't authorized.");
        _;
    }

    /**
        Allows the owner to add an evidence delegate.
     */
    function addEvidenceDelegate(address newEvidenceDelegate)
        external
        override
        onlyOwner
    {
        authorizedDelegates[newEvidenceDelegate] = true;
    }

    /**
        Allows a delegate to submit evidence for a proof of humanity.
        @dev The key for the proof is the Keccak-256 hash of the evidence bytes.
     */
    function submitEvidence(
        address _address,
        uint256 _timestamp,
        address _delegate,
        bytes calldata _evidence
    )
        external
        override
        onlyAuthorizedDelegate(_msgSender() & submission.delegate)
    {
        proofs[keccak256(evidence)] = ProofOfHumanity(
            _address,
            _timestamp,
            _delegate
        );
    }
}
