// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract DMS is ERC721URIStorage{
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    mapping(uint256 => address) private own_add;
    mapping(uint256 => mapping(address => uint256)) private rvList;
    mapping(uint256 => mapping(address => uint256)) private sigList;
    mapping(uint256 => mapping(uint256 => address)) private rvPrior;
    mapping(uint256 => mapping(address => uint256)) private rvPriorIdx;
    mapping(uint256 => mapping(uint256 => address)) private sigPrior;
    mapping(uint256 => mapping(address => uint256)) private sigPriorIdx;
    mapping(uint256 => mapping(address => uint256)) private sigSt;
    mapping(uint256 => mapping(address => uint256)) private sigTime;
    mapping(address =>  uint256[]) public docList;
    mapping(uint256 => uint256) public docIdx;
    mapping(address => uint256[]) public usSigDoc;
    mapping(uint256 => uint256) public usSigDocIdx;
    mapping(address => uint256[]) public usRejDoc;
    mapping(uint256 => uint256) public usRejDocIdx;
    mapping(address => uint256[]) public usNotSig;
    mapping(address => mapping(uint256 => uint256)) public notSigIdx;
    mapping(address => uint256[]) public usSig;
    mapping(address => mapping(uint256 => uint256)) public sigIdx;
    mapping(address => uint256[]) public usRej;
    mapping(address => mapping(uint256 => uint256)) public rejIdx;
    mapping(uint256 => address[]) public docSig;
    mapping(uint256 => address[]) public docRv;
    mapping(uint256 => string) public tkURI;

    constructor() public ERC721("Grooo", "Doc") {
    }
    modifier onlySigner( uint256 id) {
        require(sigList[id][msg.sender] == 1, "OnlySigner");
        _;
    }

    modifier onlyReviewer(uint256 id) {
        require(rvList[id][msg.sender] == 1, "OnlyReviewer");
        _;
    }

    modifier isNotSigned( uint256 tokenId) {
        require(sigSt[tokenId][msg.sender] == 0, "Signed/Rejected!");
        _;
    }
    modifier isYourRvTurn(uint256 tokenId, address user_add) {
        uint256 idx = rvPriorIdx[tokenId][user_add];
        uint256 rs = 0;
        if (idx ==0){
            rs = 1;
        } else {
            address user;
            uint256 st;
            for (uint256 i = 0; i < idx; i++) {
                user = rvPrior[tokenId][i];
                st = sigSt[tokenId][user];
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
        uint256 idx = sigPriorIdx[tokenId][user_add];
        uint256 rs = 0;
        if (idx ==0){
            rs = 1;
        } else {
            address user;
            uint256 st;
            for (uint256 i = 0; i < idx; i++) {
                user = sigPrior[tokenId][i];
                st = sigSt[tokenId][user];
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
        own_add[newItemId] = msg.sender;

        uint256 arrayLength = docList[recipient].length;
        docIdx[newItemId] = arrayLength;
        docList[recipient].push(newItemId);
        tkURI[newItemId] =_tokenURI;

        docSig[newItemId] = signerList;
        docRv[newItemId] = reviewerList;
        //Reviewer Priority
        for (uint256 i = 0; i < reviewerList.length; i++) {
            rvList[newItemId][reviewerList[i]] = 1;
            rvPrior[newItemId][i]= reviewerList[i];
            rvPriorIdx[newItemId][reviewerList[i]]= i;
            notSigIdx[signerList[i]][newItemId] = usNotSig[signerList[i]].length;
            usNotSig[signerList[i]].push(newItemId);
        }
        //Signer Priority
        for (uint256 i = 0; i < signerList.length; i++) {
            sigList[newItemId][signerList[i]] = 1;
            sigPrior[newItemId][i]= signerList[i];
            sigPriorIdx[newItemId][signerList[i]]= i;
            notSigIdx[signerList[i]][newItemId] = usNotSig[signerList[i]].length;
            usNotSig[signerList[i]].push(newItemId);
        }
        return newItemId;
    }

    function review(uint256 tokenId, uint256 status)
        public
        onlyReviewer(tokenId)
        isNotSigned(tokenId)
        isYourRvTurn(tokenId, msg.sender)
    {
        sigTime[tokenId][msg.sender] = block.timestamp;
        uint256 index = notSigIdx[msg.sender][tokenId];
        usNotSig[msg.sender][index] = usNotSig[msg.sender][usNotSig[msg.sender].length - 1];
        usNotSig[msg.sender].pop();
        notSigIdx[msg.sender][usNotSig[msg.sender][usNotSig[msg.sender].length - 1]] = index;
        if (status ==0) {
            sigSt[tokenId][msg.sender] = 3;
            
            rejIdx[msg.sender][tokenId] = usRej[msg.sender].length;
            usRej[msg.sender].push(tokenId);

            usRejDocIdx[tokenId] = usRejDoc[getOwnerAdd(tokenId)].length;
            usRejDoc[getOwnerAdd(tokenId)].push(tokenId);
        } else {
            sigSt[tokenId][msg.sender] = 1;

            sigIdx[msg.sender][tokenId] = usSig[msg.sender].length;
            usSig[msg.sender].push(tokenId);

            usSigDocIdx[tokenId] = usSigDoc[getOwnerAdd(tokenId)].length;
            usSigDoc[getOwnerAdd(tokenId)].push(tokenId);
        }
    }
    
    function sign(uint256 tokenId, uint256 status)
        public
        onlySigner(tokenId)
        isNotSigned(tokenId)
        isYourSignTurn(tokenId, msg.sender)

    {
        sigTime[tokenId][msg.sender] = block.timestamp;
        uint256 index = notSigIdx[msg.sender][tokenId];
        usNotSig[msg.sender][index] = usNotSig[msg.sender][usNotSig[msg.sender].length - 1];
        usNotSig[msg.sender].pop();
        notSigIdx[msg.sender][usNotSig[msg.sender][usNotSig[msg.sender].length - 1]] = index;
        if (status ==0) {
            sigSt[tokenId][msg.sender] = 3;

            rejIdx[msg.sender][tokenId] = usRej[msg.sender].length;
            usRej[msg.sender].push(tokenId);

            usRejDocIdx[tokenId] = usRejDoc[getOwnerAdd(tokenId)].length;
            usRejDoc[getOwnerAdd(tokenId)].push(tokenId);
        } else {
            sigSt[tokenId][msg.sender] = 2;
    
            sigIdx[msg.sender][tokenId] = usSig[msg.sender].length;
            usSig[msg.sender].push(tokenId);

            usSigDocIdx[tokenId] = usSigDoc[getOwnerAdd(tokenId)].length;
            usSigDoc[getOwnerAdd(tokenId)].push(tokenId);
        }
    }

    function getUserCollectionList(address user)
        public
        view
        returns (uint256[] memory)
    {
        return docList[user];
    }

    function checkuserDocIdx(uint256 tokenId) public view returns (uint256) {
        return docIdx[tokenId];
    }

    function checkUserSignedStatus ( uint256 tokenId, address user) public view returns (uint256) {        
        return sigSt[tokenId][user];
    }

    function checkUserSignedTime ( uint256 tokenId, address user) public view returns (uint256) {        
        return sigTime[tokenId][user];
    }

    function getCurrentId () external view returns (uint256){        
        return _tokenIds.current();
    }

    function getOwnerAdd (uint256 tokenId) public view returns (address){        
        return own_add[tokenId];
    }
    function getDocInfo (uint256 tokenId) public view returns (string memory, address[] memory, address[] memory) {        
        return (tkURI[tokenId], docRv[tokenId], docSig[tokenId]);
    }


     function getUserNotSignedList() public view returns (uint256[] memory) {        
        return usNotSig[msg.sender];
    }    
    function getUserSignedList() public view returns (uint256[] memory) {        
        return usSig[msg.sender];
    }

    function getUserRejectedList() public view returns (uint256[] memory) {        
        return usRej[msg.sender];
    }

    function getUserSignedDoc() public view returns (uint256[] memory) {        
        return usSigDoc[msg.sender];
    }

    function getUserRejectedDoc() public view returns (uint256[] memory) {        
        return usRejDoc[msg.sender];
    }
    function _transfer(
        address from,
        address to,
        uint256 tokenId0
    ) internal virtual override {
        require(1 == 0, "Can not transfer!");
    }
}
