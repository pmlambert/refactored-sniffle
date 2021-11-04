pragma solidity ^0.8.0;

/**
    Interface of the PoH Evidence API.
    This interface is defined [here](https://github.com/humanprotocol/dao-hackathon/issues/1).
 */
interface POHEvidence {
    function addEvidenceDelegate(address newEvidenceDelegate) external;

    function submitEvidence(
        address _address,
        uint64 _timestamp,
        address _delegate,
        bytes32 _evidence
    ) external;
}
