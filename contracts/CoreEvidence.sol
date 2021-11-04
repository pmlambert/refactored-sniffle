pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

import "./interfaces/POHEvidence.sol";

/**
    Receives Proof of Humanity submissions by delegates.
 */
contract CoreEvidence is POHEvidence, Ownable {
    struct DelegatedProofOfHumanity {
        uint64 timestamp;
        address delegate;
        bytes32 evidence;
    }

    mapping(address => DelegatedProofOfHumanity[]) public proofs;

    mapping(address => bool) authorizedDelegates;

    modifier onlyAuthorizedDelegate(address delegate) {
        require(
            _msgSender() == delegate && authorizedDelegates[delegate],
            "Delegate isn't authorized."
        );
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
        uint64 _timestamp,
        address _delegate,
        bytes32 _evidence
    ) external override onlyAuthorizedDelegate(_delegate) {
        proofs[_address].push(
            DelegatedProofOfHumanity(_timestamp, _delegate, _evidence)
        );
    }
}
