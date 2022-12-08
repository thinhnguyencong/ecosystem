// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract DMS is ERC721URIStorage,Ownable{
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // Adminlist - Blacklist
    mapping(address => uint256) private adminlist;
    mapping(address => uint256) private blacklist;
    mapping(uint256 => address) private owner_address;

    // Signer List
    mapping(address => mapping(uint256 => mapping(address => uint256))) private _reviewerList;
    mapping(address => mapping(uint256 => mapping(address => uint256))) private _signerList;

    mapping(address => mapping(uint256 => mapping(uint256 => address))) private reviewerPriority;
    mapping(address => mapping(uint256 => mapping(address => uint256))) private reviewerPriorityIdx;

    mapping(address => mapping(uint256 => mapping(uint256 => address))) private signerPriority;
    mapping(address => mapping(uint256 => mapping(address => uint256))) private signerPriorityIdx;

    //Sign Status
    mapping(uint256 => mapping(address => uint256)) private userSignedStatus;
    mapping(uint256 => mapping(address => uint256)) private userSignedTime;
    

    // User's Doc List
    mapping(address => mapping(address => uint256[])) public userDocList;
    mapping(address => mapping(uint256 => uint256)) public userDocIdx;

    mapping(address => mapping(address => uint256[])) public userSignedDoc;
    mapping(address => mapping(uint256 => uint256)) public userSignedDocIdx;

    mapping(address => mapping(address => uint256[])) public userRejectedDoc;
    mapping(address => mapping(uint256 => uint256)) public userRejectedDocIdx;
    
    //User's Not Signed Doc List
    mapping(address => mapping(address => uint256[])) public userNotSignedList;
    mapping(address => mapping(uint256 => uint256)) public notSignedIdx;

    //User's Signed Doc List
    mapping(address => mapping(address => uint256[])) public userSignedList;
    mapping(address => mapping(uint256 => uint256)) public signedIdx;

    //User's Rejected Doc List
    mapping(address => mapping(address => uint256[])) public userRejectedList;
    mapping(address => mapping(uint256 => uint256)) public rejectedIdx;
    
    //All DocList
    mapping(address => mapping(uint256 => address[])) public signerListOfDoc;
    mapping(address => mapping(uint256 => address[])) public reviewerListOfDoc;

    mapping(address => mapping(uint256 => uint256)) public count;
    mapping(uint256 => uint256) public docIndex;

    //Other
    mapping(address => uint256) public userNumberNFT;
    mapping(address => mapping(uint256 => string)) public tokenURI;
    constructor() public ERC721("Grooo", "Doc") {
        adminlist[msg.sender] = 1;
    }
    modifier onlyAdmin() {
        require(adminlist[msg.sender] == 1, "OnlyAdmin");
        _;
    }

    modifier onlySigner(address nft, uint256 id) {
        require(_signerList[nft][id][msg.sender] == 1, "OnlySigner");
        _;
    }

    modifier onlyReviewer(address nft, uint256 id) {
        require(_reviewerList[nft][id][msg.sender] == 1, "OnlyReviewer");
        _;
    }

    modifier isNotSigned( uint256 tokenId) {
        require(userSignedStatus[tokenId][msg.sender] == 0, "Signed/Rejected!");
        _;
    }
    modifier isYourRvTurn(uint256 tokenId, address user_add) {
        uint256 idx = reviewerPriorityIdx[address(this)][tokenId][user_add];
        uint256 rs = 0;
        if (idx ==0){
            rs = 1;
        } else {
            address user;
            uint256 st;
            for (uint256 i = 0; i < idx; i++) {
                user = reviewerPriority[address(this)][tokenId][i];
                st = userSignedStatus[tokenId][user];
                if (st ==0 || st ==3){
                    rs = 0;
                    break;
                } else {
                    rs = 1;
                }
            }
        }
        require(rs == 1, "Not Your Turn / Be Rejected");
        _;
    }

    modifier isYourSignTurn(uint256 tokenId, address user_add) {
        uint256 idx = signerPriorityIdx[address(this)][tokenId][user_add];
        uint256 rs = 0;
        if (idx ==0){
            rs = 1;
        } else {
            address user;
            uint256 st;
            for (uint256 i = 0; i < idx; i++) {
                user = signerPriority[address(this)][tokenId][i];
                st = userSignedStatus[tokenId][user];
                if (st ==0 || st ==3){
                    rs = 0;
                    break;
                } else {
                    rs = 1;
                }
            }
        }
        require(rs == 1, "Not Your Turn / Be Rejected");
        _;
    }

    function totalSupply() public view returns (uint256) {
        return _tokenIds.current();
    }

    function checkAdmin(address account) public view returns (bool) {
        return adminlist[account] > 0;
    }

    function checkReviewer(
        address nft,
        uint256 id,
        address account
    ) public view returns (bool) {
        return _reviewerList[nft][id][account] > 0;
    }

    function checkSigner(
        address nft,
        uint256 id,
        address account
    ) public view returns (bool) {
        return _signerList[nft][id][account] > 0;
    }

    function checkBlackList(address account) public view returns (bool) {
        return blacklist[account] > 0;
    }

    function mintNFT(
        address recipient,
        string memory _tokenURI,
        address[] memory reviewerList,
        address[] memory signerList
    ) public returns (uint256) {
        //Create new NFT
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(recipient, newItemId);
        _setTokenURI(newItemId, _tokenURI);
        owner_address[newItemId] = msg.sender;

        //Add to User Doc List
        uint256 arrayLength = userDocList[recipient][address(this)].length;
        userDocIdx[address(this)][newItemId] = arrayLength;
        userDocList[recipient][address(this)].push(newItemId);
        userNumberNFT[recipient] += 1;
        tokenURI[address(this)][newItemId] =_tokenURI;

        signerListOfDoc[address(this)][newItemId] = signerList;
        reviewerListOfDoc[address(this)][newItemId] = reviewerList;
        //Reviewer Priority
        for (uint256 i = 0; i < reviewerList.length; i++) {
            _reviewerList[address(this)][newItemId][reviewerList[i]] = 1;
            reviewerPriority[address(this)][newItemId][i]= reviewerList[i];
            reviewerPriorityIdx[address(this)][newItemId][reviewerList[i]]= i;
            uint256 len = userNotSignedList[signerList[i]][address(this)].length;
            notSignedIdx[signerList[i]][newItemId] = len;
            userNotSignedList[signerList[i]][address(this)].push(newItemId);
        }
        //Signer Priority
        for (uint256 i = 0; i < signerList.length; i++) {
            _signerList[address(this)][newItemId][signerList[i]] = 1;
            signerPriority[address(this)][newItemId][i]= signerList[i];
            signerPriorityIdx[address(this)][newItemId][signerList[i]]= i;
            uint256 len = userNotSignedList[signerList[i]][address(this)].length;
            notSignedIdx[signerList[i]][newItemId] = len;
            userNotSignedList[signerList[i]][address(this)].push(newItemId);
        }
        return newItemId;
    }

    function review(address nft, uint256 tokenId, uint256 status)
        public
        onlyReviewer(nft, tokenId)
        isNotSigned(tokenId)
        isYourRvTurn(tokenId, msg.sender)
    {
        userSignedTime[tokenId][msg.sender] = block.timestamp;
        uint256 index = notSignedIdx[msg.sender][tokenId];
        userNotSignedList[msg.sender][address(this)][index] = userNotSignedList[msg.sender][address(this)][userNotSignedList[msg.sender][address(this)].length - 1];
        userNotSignedList[msg.sender][address(this)].pop();
        notSignedIdx[msg.sender][userNotSignedList[msg.sender][address(this)][userNotSignedList[msg.sender][address(this)].length - 1]] = index;
        if (status ==0) {
            userSignedStatus[tokenId][msg.sender] = 3;
            
            uint256 length = userRejectedList[msg.sender][address(this)].length;
            rejectedIdx[msg.sender][tokenId] = length;
            userRejectedList[msg.sender][address(this)].push(tokenId);

            length = userRejectedDoc[getOwnerAdd(tokenId)][address(this)].length;
            userRejectedDocIdx[address(this)][tokenId] = length;
            userRejectedDoc[getOwnerAdd(tokenId)][address(this)].push(tokenId);
        } else {
            userSignedStatus[tokenId][msg.sender] = 1;

            uint256 length = userSignedList[msg.sender][address(this)].length;
            signedIdx[msg.sender][tokenId] = length;
            userSignedList[msg.sender][address(this)].push(tokenId);

            length = userSignedDoc[getOwnerAdd(tokenId)][address(this)].length;
            userSignedDocIdx[address(this)][tokenId] = length;
            userSignedDoc[getOwnerAdd(tokenId)][address(this)].push(tokenId);
        }
    }
    
    function sign(address nft, uint256 tokenId, uint256 status)
        public
        onlySigner(nft, tokenId)
        isNotSigned(tokenId)
        isYourSignTurn(tokenId, msg.sender)

    {
        userSignedTime[tokenId][msg.sender] = block.timestamp;
        uint256 index = notSignedIdx[msg.sender][tokenId];
        userNotSignedList[msg.sender][address(this)][index] = userNotSignedList[msg.sender][address(this)][userNotSignedList[msg.sender][address(this)].length - 1];
        userNotSignedList[msg.sender][address(this)].pop();
        notSignedIdx[msg.sender][userNotSignedList[msg.sender][address(this)][userNotSignedList[msg.sender][address(this)].length - 1]] = index;
        if (status ==0) {
            userSignedStatus[tokenId][msg.sender] = 3;

            uint256 length = userRejectedList[msg.sender][address(this)].length;
            rejectedIdx[msg.sender][tokenId] = length;
            userRejectedList[msg.sender][address(this)].push(tokenId);

            length = userRejectedDoc[getOwnerAdd(tokenId)][address(this)].length;
            userRejectedDocIdx[address(this)][tokenId] = length;
            userRejectedDoc[getOwnerAdd(tokenId)][address(this)].push(tokenId);
        } else {
            userSignedStatus[tokenId][msg.sender] = 2;
    
            uint256 length = userSignedList[msg.sender][address(this)].length;
            signedIdx[msg.sender][tokenId] = length;
            userSignedList[msg.sender][address(this)].push(tokenId);

            length = userSignedDoc[getOwnerAdd(tokenId)][address(this)].length;
            userSignedDocIdx[address(this)][tokenId] = length;
            userSignedDoc[getOwnerAdd(tokenId)][address(this)].push(tokenId);
        }
    }

    function getUserCollectionList(address user, address nft)
        public
        view
        returns (uint256[] memory)
    {
        return userDocList[user][nft];
    }

    function getUserNumberNFT(address user) public view returns (uint256) {
        return userNumberNFT[user];
    }

    function checkuserDocIdx(address nft, uint256 tokenId) public view returns (uint256) {
        return userDocIdx[nft][tokenId];
    }

    function checkUserSignedStatus ( uint256 tokenId, address user) public view returns (uint256) {        
        return userSignedStatus[tokenId][user];
    }

    function checkUserSignedTime ( uint256 tokenId, address user) public view returns (uint256) {        
        return userSignedTime[tokenId][user];
    }

    function getCurrentId () external view returns (uint256){        
        uint256 tokenIDNow = _tokenIds.current();
        return tokenIDNow;
    }

    function getOwnerAdd (uint256 tokenId) public view returns (address){        
        address _owner_address= owner_address[tokenId];
        return _owner_address;
    }
    function getDocInfo (uint256 tokenId) public view returns (string memory, address[] memory, address[] memory) {        
        string memory uri = tokenURI[address(this)][tokenId];
        address[] memory reviewer_list = reviewerListOfDoc[address(this)][tokenId];
        address[] memory signer_list = signerListOfDoc[address(this)][tokenId];
        return (uri, reviewer_list, signer_list);
    }

     function getUserNotSignedList() public view returns (uint256[] memory) {        
        address user = msg.sender;
        return userNotSignedList[user][address(this)];
    }    
    function getUserSignedList() public view returns (uint256[] memory) {        
        address user = msg.sender;
        return userSignedList[user][address(this)];
    }

    function getUserRejectedList() public view returns (uint256[] memory) {        
        address user = msg.sender;
        return userRejectedList[user][address(this)];
    }

    // văn bản đã được ký của người tạo
    function getUserSignedDoc() public view returns (uint256[] memory) {        
        address user = msg.sender;
        return userSignedDoc[user][address(this)];
    }

    function getUserRejectedDoc() public view returns (uint256[] memory) {        
        address user = msg.sender;
        return userRejectedDoc[user][address(this)];
    }
    function _transfer(
        address from,
        address to,
        uint256 tokenId0
    ) internal virtual override {
        require(1 == 0, "Can not transfer!");
    }
}
