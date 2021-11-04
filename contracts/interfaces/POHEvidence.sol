/**
    Interface of the PoH Evidence API.
    This interface is defined [here](https://github.com/humanprotocol/dao-hackathon/issues/1).
 */
interface POHEvidence {
    struct ProofOfHumanity {
        address _address;
        uint256 _timestamp;
        bytes _evidence;
    }

    function addEvidenceDelegate(address newEvidenceDelegate) external;

    function submitEvidence(
        address _address,
        uint256 _timestamp,
        address _delegate,
        bytes calldata _evidence
    ) external;

    function proofs(bytes32 key)
        external
        view
        returns (ProofOfHumanity memory proof);
}
