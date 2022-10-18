import React, { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import {loadNftAuctionList, settleAuction} from "../../services/auction/auctionSlice";

import * as dayjs from 'dayjs';

function AuctionList(props) {
    const user = useSelector((state) => state.user)
    const auction = useSelector((state) => state.auction)
    const [state, setState] = useState({
        openPasswordModal: false,
        nftAddress: "",
        tokenId: ""
    })
	const dispatch = useDispatch()
    const [auctionList, setAuctionList] = useState([])
    useEffect(() => {
        dispatch(loadNftAuctionList());
    }, [])

    useEffect(() => {
        handleData()
    }, [auction?.auctionList?.length])

    useEffect(() => {
        const timer = setTimeout(() => {
            let newArr = auctionList.map((x) => ({...x, auctionEndDisplay: calculateTimeLeft(x.auctionEnd)}))
            setAuctionList(newArr)
        }, 1000);
      
        return () => clearTimeout(timer);
    });

    function calculateTimeLeft(date) {
        if(date === '') {
            return ["00", "00", "00", "00"];
        }
        // let day = dayjs(date, "YYYY-MM-DD HH:mm:ss");
        let day = dayjs.unix(date)
        let now = dayjs();
        let diff = day.diff(now)
        if (diff > 0) {
            let timeLeft = [
                Math.floor(diff / (1000 * 60 * 60 * 24)),
                Math.floor((diff / (1000 * 60 * 60)) % 24),
                Math.floor((diff / 1000 / 60) % 60),
                Math.floor((diff / 1000) % 60)
            ]
            let result = timeLeft.map(
                myNumber => myNumber.toLocaleString( 'en-US', { minimumIntegerDigits: 2, useGrouping: false }))
            return result
        }
        else {
            return ["00", "00", "00", "00"];
        }
        
    }
    const handleData = () => {
        if (auction.auctionList && auctionList.length === 0) {
            let arr3 = auction.auctionList
            let arr4 = arr3.map((x) => ({...x, auctionEndDisplay: calculateTimeLeft(x.auctionEnd)}))
            console.log("auctionList", arr3);
            console.log("result", arr4);
            setAuctionList(arr4)
        }
    }
    const handleSettleAuction = (address, id) => {
        dispatch(settleAuction({nftAddress: address, tokenId: id}));
    }

    return ( 
        <div className="max-w-full bg-cover bg-center bg-page-5 min-h-screen">
        {!auction.isLoading ? 
            <div className="container-fluid pt-24 pb-3">
                <div className='title-auction flex items-center pl-6 pt-6 '>
                    <div className='flex flex-row absolute ripple items-center'><i style={{color:"red"}} className="fa-lg bi bi-record-circle-fill"></i></div>
                    <div className="flex flex-row pl-10 text-white font-exo-2 text-3xl font-bold">Live Auction</div>
                </div>
                
                <div className="row text-center card-nft m-3">
                    {auctionList?.filter(x=> x.status == "auction-on-going").map((NFT, key) => {
                        return(
                            <div key={key} className="card border-secondary bg-black-light">
                                <div className={"mx-auto pt-3"}>   
                                    <div className="bg-clock-counter min-width-200px min-height-70px">
                                        <table className='mx-auto'>
                                            <tbody className=''>
                                                <tr className="">
                                                    <td className="text-2xl uppercase text-white font-digital">{NFT?.auctionEndDisplay[0] + ":"}</td>
                                                    <td className="text-2xl uppercase text-white font-digital">{NFT?.auctionEndDisplay[1] + ":"}</td>
                                                    <td className="text-2xl uppercase text-white font-digital">{NFT?.auctionEndDisplay[2] + ":"}</td>
                                                    <td className="text-2xl uppercase text-white font-digital">{NFT?.auctionEndDisplay[3]}</td>
                                                </tr>
                                                <tr className="">
                                                    <td className="text-xl uppercase text-white font-bold font-digital  uppercase text-white font-digital">{"Day"}&nbsp;</td>
                                                    <td className="text-xl uppercase text-white font-bold font-digital  uppercase text-white font-digital">{"Hrs"}&nbsp;</td>
                                                    <td className="text-xl uppercase text-white font-bold font-digital  uppercase text-white font-digital">{"Min"}&nbsp;</td>
                                                    <td className="text-xl uppercase text-white font-bold font-digital  uppercase text-white font-digital">{"Sec"}&nbsp;</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>    
                                </div>
                                <a href={"/token/"+NFT.id} target="_blank" rel="noopener noreferrer">
                                    <img src={`${NFT.img}`} className="card-img-bottom" alt={`NFT ${key}`} />
                                </a>  
                                {NFT.owner == user.publicAddress ? 
                                    <p className="fw-light fs-6 text-white">Owner: &nbsp; You </p>
                                    :
                                    <p className="fw-light fs-6 text-white">Owner: &nbsp;{NFT.owner ? `${NFT.owner.substr(0,7)}...${NFT.owner.substr(NFT.owner.length - 7)}` : "abc"}</p>
                                }                 
                            </div>
                        );
                    })}
                </div>
                <div className='title-auction flex items-center pl-6 pt-6 '>
                    <div className='flex flex-row absolute items-center'><i style={{color:"grey"}} className="fa-lg bi bi-record-circle-fill"></i></div>
                    <div className="flex flex-row pl-10 text-white font-exo-2 text-3xl font-bold">Auction has ended</div>
                </div>
                
                <div className="row text-center card-nft m-3">
                    {auctionList?.filter(x=> x.status == "auction-ended").map((NFT, key) => {
                        return(
                            <div key={key} className="card border-secondary bg-black-light">
                                <div className={"mx-auto pt-4"}>   
                                    <div className="min-width-200px min-height-70px">
                                        <div className='mx-auto'>
                                            <button onClick={() => handleSettleAuction(NFT.collectionAddress, NFT.id)} className="bg-lightBlue-500 px-4 py-2 border-solid-3 focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent"                              >
                                                <p className="text-black font-evil text-xl uppercase">settle auction</p>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <a href={"/token/"+NFT.id} target="_blank" rel="noopener noreferrer">
                                    <img src={`${NFT.img}`} className="card-img-bottom" alt={`NFT ${key}`} />
                                </a>  
                                {NFT.owner == user.publicAddress ? 
                                    <p className="fw-light fs-6 text-white">Owner: &nbsp; You </p>
                                    :
                                    <p className="fw-light fs-6 text-white">Owner: &nbsp;{NFT.owner ? `${NFT.owner.substr(0,7)}...${NFT.owner.substr(NFT.owner.length - 7)}` : "abc"}</p>
                                }                 
                            </div>
                        );
                    })}
                </div>
            </div>
            
            
            :
            <p>Loading.....</p>
        }
        
    </div>
        
    );
}

export default AuctionList;