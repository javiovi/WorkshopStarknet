["protostar.contracts"]
ERC721_original = [
    "src/ERC721MintableBurnable.cairo",
]
[profile.devnet.protostar.deploy]
gateway-url="http://127.0.0.1:5050/"
chain-id="1"

[profile.testnet.protostar.deploy]
network="testnet"

protostar -p testnet deploy build/ERC721_original.json --inputs 27424471826656371 4279885 1268012686959018685956609106358567178896598707960497706446056576062850827536


%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_caller_address
from starkware.cairo.common.math import assert_not_zero

from openzeppelin.access.ownable.library import Ownable
from openzeppelin.security.pausable.library import Pausable

// ------
// Structs
// ------

// struct that carries the status of the vote
struct VoteCounting{
    votes_yes : felt,
    votes_no : felt,
}

// struct indicating whether a voter is allowed to vote
struct VoterInfo{
    allowed : felt,
}

// ------
// Storage
// ------

// storage variable that takes no arguments and returns the current status of the vote
@storage_var
func voting_status() -> (res : VoteCounting){
}
 
// storage variable that receives an address and returns the information of that voter
@storage_var
func voter_info(user_address: felt) -> (res : VoterInfo){
}

// storage variable that receives an address and returns if an address is registered as a voter
@storage_var
func registered_voter(address: felt) -> (is_registered: felt) {
}

func _register_voters{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
    }(registered_addresses_len: felt, registered_addresses : felt*){
    
    // No more voters, recursion ends
    if (registered_addresses_len == 0){
        return ();
    }
    
    // Assign the voter at address 'registered_addresses[registered_addresses_len - 1]' a VoterInfo struct
    // indicating that they have not yet voted and can do so
    let votante_info = VoterInfo(
        allowed=1,
    );
    registered_voter.write(registered_addresses[registered_addresses_len - 1], 1);
    voter_info.write(registered_addresses[registered_addresses_len - 1], votante_info);
    
    // Go to next voter, we use recursion
    return _register_voters(registered_addresses_len - 1, registered_addresses);
}

