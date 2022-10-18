import React, {useEffect, useState, useRef, createRef} from 'react';
import { useParams } from 'react-router-dom';
import { useDispatch, useSelector } from 'react-redux';
import * as dayjs from 'dayjs';
import relativeTime from "dayjs/plugin/relativeTime"
import DatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";
import { loadNftAuctionById, loadBidHistory, createAuction, settleAuction, placeBid, withdrawAuction } from "../../services/auction/auctionSlice"
import { getNftById} from "../../services/collection/collectionSlice";

dayjs.extend(relativeTime)

function TokenDetail(props) {
    const rate = 0.8
    const auth = useSelector((state) => state.auth)
    const auction = useSelector((state) => state.auction)
    const collection = useSelector((state) => state.collection)
	const dispatch = useDispatch()
    const [time, setTime] = useState({
        timeLeft: ["00", "00", "00", "00"],
        startDate: new Date(),
    }) 
    const [state, setState] = useState({
        minPrice: 0,
        buyPrice: 0,
        endDate: new Date(new Date().getTime() + (24 * 60 * 60 * 1000)),
        isCustomAuction: false,
        bidIncrease: 1,
        bidPeriod: 20,
        newMinPrice: 0,
        newBuyPrice: 0,
        bidPrice: 0,
        errorMinPrice: "",
        errorBuyPrice: "",
        errorEndDate: "",
        errorBidIncrease: "",
        errorBidPeriod: "",
        bidEqualBuyPriceMsg: null,
    })
    const [isLoadingRefresh, setIsLoadingRefresh] = useState(false)
    const {id} = useParams();

    const {minPrice, buyPrice, endDate, isCustomAuction, bidIncrease, bidPeriod,
        newMinPrice, newBuyPrice, bidPrice,bidEqualBuyPriceMsg,
        errorMinPrice ,errorBuyPrice, errorEndDate, errorBidIncrease, errorBidPeriod
        } = state
    const {timeLeft, startDate } = time 
    useEffect(() => {
        if(id) {
            console.log(id);
            dispatch(getNftById(id))
            dispatch(loadNftAuctionById(id))
            dispatch(loadBidHistory(id))
        }
    }, [])

    useEffect(() => {
        setIsLoadingRefresh(auction.isLoadingRefresh)
    }, [auction.isLoadingRefresh])
    useEffect(() => {
        const timer = setTimeout(() => {
            setTime({
                ...time,
                timeLeft: calculateTimeLeft(auction?.auctionEnd),
                startDate: new Date(),
            })
        }, 1000);
        return () => clearTimeout(timer);
    }, [JSON.stringify(timeLeft),  JSON.stringify(auction?.auctionEnd)]);

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
    
    const handleChangeMinPrice = (event) => {
        if(event.target.value <= 0) {
            setState({
                ...state,
                minPrice: event.target.value,
                errorMinPrice: "Min price must greater than 0"
            })
        } else {
            setState({
                ...state,
                minPrice: event.target.value,
                errorMinPrice: null
            })
        }
        
    }

    const handleWithdrawAuction = (id) => {    
        if(auction.highestBid > auction.minPrice) {
            alert("Cannot withdraw auction because there exists a valid bid!")
        }else {
            dispatch(withdrawAuction({tokenId: id}))
        }
    };

    const handleChangeEndDate = (date) => {
        let end = dayjs(date)
        let diff = end.diff(startDate)
        console.log("endDate", dayjs(date).unix())
        if (diff < 0){
            setState({
                ...state, 
                endDate: date,
                errorEndDate: "End Date must come after Start Date(now)"
            })
        }else {
            setState({
                ...state, 
                endDate: date,
                errorEndDate: null
            })
        }
        
    }

    const handleSetNewMinPrice = () => {

    }

    const handleChangeNewBuyPrice = (event) => {
        setState({
            ...state,
            newBuyPrice: event.target.value,
        })
    }

    const handleSetNewBuyPrice = (tokenId) => {
        props.updateBuyPrice(newBuyPrice, tokenId);
    }
    const handleChangeBidPrice = (event) => {
        if(parseInt(event.target.value) < parseInt(auction.buyPrice)){
            setState({
                ...state,
                bidPrice: event.target.value,
                bidEqualBuyPriceMsg: null
            })
        }
        else {
            setState({
                ...state,
                bidPrice: event.target.value,
                bidEqualBuyPriceMsg: "You can buy this item now!"
            })
        }
        
    }

    const handlePlaceBid = (id) => {
        if (auction.status == "auction-on-going" ){
            if(parseInt(bidPrice) < parseInt(auction.minPrice)) {
                alert(`Bid must equal or greater than minimum price (${auction.minPrice})`)
                return;
            }
            // nếu highest bid là B thì bid tiếp theo phải lớn hơn hoặc bằng (1+x)B
            if(bidPrice >= (auction.highestBid)*(1+auction.bidIncreasePercentage/10000)) {
                let data = {
                    bidPrice: bidPrice,
                    tokenId: parseInt(id),

                }
                dispatch(placeBid(data))
            }
            else {
                alert(`Minimum bid must greater than ${1+auction.bidIncreasePercentage/10000} times highest bid (${(1+auction.bidIncreasePercentage/10000)*parseInt(auction.highestBid)})`)
            } 
        }
        else {
            alert("Auction has ended")
        }
        
    }
    
    const handleBuyNowNFT = () => {

    }

    const handleChangeBuyPrice = (event) => {
        if(event.target.value <= 0) {
            setState({
                ...state,
                buyPrice: event.target.value,
                errorBuyPrice: "Buy price must greater than 0"
            })
        } else {
            setState({
                ...state,
                buyPrice: event.target.value,
                errorBuyPrice: null
            })
        }
    }

    const handleCheckCustomAuction = (event) => {
        console.log(event.target.checked)
        setState({
            ...state,
            isCustomAuction: event.target.checked
        })
    }

    const handleChangeBidIncrease = (event) => {
        console.log("bidIncrease", event.target.value)

        setState({
            ...state,
            bidIncrease: event.target.value
        })
    }

    const handleChangeBidPeriod = (event) => {
        console.log("bidPeriod", event.target.value)

        setState({
            ...state,
            bidPeriod: event.target.value
        })
    }
    const handleRefreshBidList = () => {
        setIsLoadingRefresh(true)
        setTimeout(() => {
            dispatch(loadBidHistory(parseInt(item.id)))
            setIsLoadingRefresh(false)
        }, 3000)
        
    }
    const customTime = (time) => {
        return dayjs.unix(time).fromNow();
    }

    const handleMakeAuction = (tokenId) => {
        console.log(minPrice)
        let data = {
            endDate: dayjs(endDate).unix(),
            tokenId: parseInt(tokenId),
            minPrice: minPrice,
            buyPrice: buyPrice,
            auctionBidPeriod: Math.round((dayjs(endDate) - dayjs(startDate))/1000),
        }
        let data2 = {
            ...data,
            bidIncrease: bidIncrease*100,
            bidPeriod: bidPeriod*60
        }
        console.log(isFormValidated())
        if(isCustomAuction) {
            if(isFormValidated()) {
                dispatch(createAuction({type: "custom", data: data2}))
            } else {
                alert("You must fill all the infomations")
            }
            
        }else {
            if(isFormValidated()) {
                dispatch(createAuction({type: "default", data: data }))
            } else {
                alert("You must fill all the infomations")
            }
        }
    }
    const hasError = (error) => {
        if(error) {
            return 'has-error'
        } else return ""
    }
    const hasMsg = (msg) => {
        if(msg) {
            return 'green-border'
        } else return ""
    }
    const hasErrorLabel = (error) => {
        if(error) {
            return true
        } else return false
    }
    const isFormValidated = () => {
        if(errorMinPrice == "" && errorBuyPrice == "" && errorEndDate == "" && errorBidIncrease == "" && errorBidPeriod == ""){
            return false
        }
        if(!errorMinPrice && !errorBuyPrice && !errorEndDate && !errorBidIncrease && !errorBidPeriod){
            return true
        }
        else {
            return false
        }
       
    }
    const isHighestBid = (amount) => {
        if (Math.max(...bids.map(o => o.amount)) == amount){
            return true
        }else return false
    }
    const checkPrice = (minPrice, buyPrice) => {
        if(minPrice >= rate*buyPrice) {
            setState({ ...state, errorMinPrice: `Min price must smaller than ${rate*100}% of buy price` })
        } else {
            setState({ ...state, errorMinPrice: null })
        }
    }
    const handleSettleAuction = (address, id) => {
       dispatch(settleAuction({nftAddress: address, tokenId: id}));
    }
    const getStatus = (status) => {
        if (status) {
            if(status === "auction-on-going") return "auction-on-going"
            else if (status === "auction-ended") return "auction-ended"
            else return "not-on-auction"
        }else return ""
    }
    
    const sortByTimeBid = (bidHistory) => {
        let arrayForSort = [...bidHistory]
        console.log("arrayForSort", arrayForSort)
        return arrayForSort.sort((a, b) => parseInt(b.time) - parseInt(a.time));
    }

    const getBidList = (bidHistory) => {
        // chỉ lấy những bid của auction hiện tại, không lấy trong quá khứ
        return bidHistory.filter(x => parseInt(x.time) > parseInt(auction?.auctionStart))
    }
    const item = collection?.item
    const owner = auction?.seller === "0x0000000000000000000000000000000000000000" ? item?.owner?.toLowerCase() : auction?.seller?.toLowerCase()
    const status = getStatus(auction?.status)
    const highestBid = auction?.highestBid ? auction?.highestBid : null
    const highestBidder = auction?.highestBidder ? auction?.highestBidder : ""
    const bidHistory = auction?.bidHistory ? sortByTimeBid(auction.bidHistory) : []
    const bids =  auction?.bidHistory ? getBidList(auction.bidHistory) : []
    return (
        <div>
            <div>
                {item?.id && !collection.isLoading && !auction.isLoading
                ? 
                    <div className="max-w-full bg-cover bg-center bg-page-6 min-h-screen">
                        <div className="pt-24 h-full">
                            <div className="container w-full h-full">
                                <div className="row w-full h-full">
                                    <div className="col-lg-7">
                                        <div className="container">
                                            <div className="row">
                                                <div className="col"></div>
                                                <div className="col-6">
                                                    <div className="pb-3 pl-6 bg-clock-counter ">
                                                        <table className='items-center'>
                                                            <tbody>
                                                            <tr className="lg:ml-4">
                                                                <td className="text-4xl lg:text-4xl xl:text-5xl uppercase text-white font-digital mb:clock-text-format lg:clock-text-format xl:clock-text-format">{timeLeft[0] + ":"}</td>
                                                                <td className="text-4xl lg:text-4xl xl:text-5xl uppercase text-white font-digital mb:clock-text-format lg:clock-text-format xl:clock-text-format">{timeLeft[1] + ":"}</td>
                                                                <td className="text-4xl lg:text-4xl xl:text-5xl uppercase text-white font-digital mb:clock-text-format lg:clock-text-format xl:clock-text-format">{timeLeft[2] + ":"}</td>
                                                                <td className="text-4xl lg:text-4xl xl:text-5xl uppercase text-white font-digital mb:clock-text-format lg:clock-text-format xl:clock-text-format">{timeLeft[3]}</td>
                                                            </tr>
                                                            <tr className="">
                                                                <td className="text-3xl mb:text-xl lg:text-2xl xl:text-3xl uppercase text-white font-bold font-digital  uppercase text-white font-digital mb:clock-text-format-2 lg:clock-text-format-2 xl:clock-text-format-2">{"Day   "}</td>
                                                                <td className="text-3xl mb:text-xl lg:text-2xl xl:text-3xl uppercase text-white font-bold font-digital  uppercase text-white font-digital mb:clock-text-format-2 lg:clock-text-format-2 xl:clock-text-format-2">{"Hrs   "}</td>
                                                                <td className="text-3xl mb:text-xl lg:text-2xl xl:text-3xl uppercase text-white font-bold font-digital  uppercase text-white font-digital mb:clock-text-format-2 lg:clock-text-format-2 xl:clock-text-format-2">{"Min   "}</td>
                                                                <td className="text-3xl mb:text-xl lg:text-2xl xl:text-3xl uppercase text-white font-bold font-digital  uppercase text-white font-digital mb:clock-text-format-2 lg:clock-text-format-2 xl:clock-text-format-2">{"   Sec"}</td>
                                                            </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                                <div className="col"></div>
                                            </div>
                                            <div className="row">
                                                <div className="col"></div>
                                                <div className="col-6 min-h-screen-65">
                                                    <img src={item?.img} className="md:min-h-full mx-auto"></img>
                                                </div>
                                                <div className="col"></div>
                                                
                                            </div>
                                        </div>
                                    </div>
                                    <div className="col-lg-5 blurry">
                                        <div className="row">
                                            <div className="col-md-12 offset-md-12">
                                                <div className="px-2 py-2">
                                                    {owner == auth.publicAddress ?
                                                        <p data-bs-toggle="tooltip" data-bs-placement="bottom" title={owner} className="text-xl text-white letter-spacing-base font-bold font-evil uppercase text-center mb-2">NFT own by:&nbsp;you</p>
                                                        : 
                                                        <p data-bs-toggle="tooltip" data-bs-placement="bottom" title={owner} className="text-xl text-white letter-spacing-base font-bold font-evil uppercase text-center mb-2">NFT own by:&nbsp;{`${owner?.substr(0,7)}...${owner?.substr(owner?.length - 7)}`}</p>
                                                    }
                                                </div>
                                            </div>
                                        </div>
                                        <div className="row pl-3">
                                            {status === "auction-on-going" &&
                                                <p className="mb:text-xs sm:text-base lg:text-base text-justify font-exo-2 text-white font-medium">
                                                Minimum price:&nbsp;&nbsp;
                                                    <span className="mb:text-xs sm:text-base lg:text-base text-justify font-exo-2 text-white font-bold">
                                                        {auction.minPrice} ETH
                                                    </span>
                                                &nbsp; or buy now at <span className="mb:text-xs sm:text-base lg:text-base text-justify font-exo-2 text-white font-bold">
                                                        {auction.buyPrice} ETH
                                                    </span>
                                                </p>
                                            }
                                            {status === "auction-ended" && 
                                                <p className="mb:text-xs sm:text-base lg:text-base text-justify font-exo-2 text-white font-medium">
                                                    Auction ended&nbsp; {customTime(auction?.auctionEnd)}
                                                </p> 
                                            }
                                            {status === "not-on-auction"  && 
                                                <p className="mb:text-xs sm:text-base lg:text-base text-justify font-exo-2 text-white font-medium">
                                                    Item is not for sale
                                                </p> 
                                            }
                                        </div>
                                        <br/>
                                        <div className="row">
                                            <div className="tab-card-header pb-3">
                                                <ul className="nav nav-tabs" id="myTab" role="tablist">
                                                    <li className="nav-item active">
                                                        <a className="nav-link active" id="details-tab" data-bs-toggle="tab" href="#details" role="tab" aria-controls="One" aria-selected="true">Details</a>
                                                    </li>
                                                    <li className="nav-item">
                                                        <a className="nav-link" id="bids-tab" data-bs-toggle="tab" href="#bids" role="tab" aria-controls="Two" aria-selected="false">Bids</a>
                                                    </li>
                                                    <li className="nav-item">
                                                        <a className="nav-link" id="history-tab" data-bs-toggle="tab" href="#history" role="tab" aria-controls="Three" aria-selected="false">History</a>
                                                    </li>
                                                </ul>
                                            </div>
                                            <div className="w-full overflow-auto h-350-px ">
                                                <div className="tab-content" id="myTabContent">
                                                    <div className="tab-pane fade show active p-3" id="details" role="tabpanel" aria-labelledby="details-tab">
                                                        <h5 className="card-title">Tab Card One</h5>
                                                        <p className="card-text text-white">
                                                            Some quick example text to build on the card title and make up the bulk of the card's content.Some quick example text to build on the card title and make up the bulk of the card's contentSome quick example text to build on the card title and make up the bulk of the card's contentSome quick example text to build on the card title and make up the bulk of the card's contentSome quick example text to build on the card title and make up the bulk of the card's contentSome quick example text to build on the card title and make up the bulk of the card's contentSome quick example text to build on the card title and make up the bulk of the card's contentSome quick example text to build on the card title and make up the bulk of the card's contentSome quick example text to build on the card title and make up the bulk of the card's contentSome quick example text to build on the card title and make up the bulk of the card's contentSome quick example text to build on the card title and make up the bulk of the card's contentSome quick example text to build on the card title and make up the bulk of the card's contentSome quick example text to build on the card title and make up the bulk of the card's contentSome quick example text to build on the card title and make up the bulk of the card's contentSome quick example text to build on the card title and make up the bulk of the card's contentSome quick example text to build on the card title and make up the bulk of the card's contentSome quick example text to build on the card title and make up the bulk of the card's contentSome quick example text to build on the card title and make up the bulk of the card's contentSome quick example text to build on the card title and make up the bulk of the card's contentSome quick example text to build on the card title and make up the bulk of the card's contentSome quick example text to build on the card title and make up the bulk of the card's contentSome quick example text to build on the card title and make up the bulk of the card's contentSome quick example text to build on the card title and make up the bulk of the card's contentSome quick example text to build on the card title and make up the bulk of the card's contentSome quick example text to build on the card title and make up the bulk of the card's contentSome quick example text to build on the card title and make up the bulk of the card's content</p>  
                                                        
                                                    </div>
                                                    <div className="tab-pane fade p-3" id="bids" role="tabpanel" aria-labelledby="bids-tab">
                                                        <ul>
                                                            <li>
                                                                <div className="bg-transparent pb-3">
                                                                    <div className="flex justify-between items-center">
                                                                        <div className="flex flex-row items-center"> 
                                                                            <div className="flex flex-col"> 
                                                                                {isLoadingRefresh ? 
                                                                                    <div className="spinner-border text-light mt-2" role="status">
                                                                                        <span className="sr-only">Loading...</span>
                                                                                    </div>
                                                                                    : 
                                                                                    <button onClick={handleRefreshBidList}> <i style={{color:"white"}} className="fa-2x bi bi-arrow-clockwise"></i></button>
                                                                                }
                                                                            </div>
                                                                        </div> 
                                                                    </div>
                                                                </div>
                                                            </li>
                                                            {bids.length > 0 && auction.auctionStart > 0 ? 
                                                                bids?.map((bid,index) => {
                                                                    return(
                                                                        <li key={index}>
                                                                            <div className="bg-transparent pb-3">
                                                                                <div className="flex justify-between items-center">
                                                                                    <div className="flex flex-row items-center"> 
                                                                                        <img src="https://i.imgur.com/hczKIze.jpg" width="40" className="user-img rounded-circle mr-2"></img> 
                                                                                        <div className="flex flex-col"> 
                                                                                            <span>
                                                                                                <span className="font-bold text-white">{bid.amount} ETH&nbsp;</span> 
                                                                                                <span className="font-medium text-gray-500"> by </span>
                                                                                                {bid.user == auth.publicAddress 
                                                                                                    ? 
                                                                                                    <span data-bs-toggle="tooltip" data-bs-placement="bottom" title={bid.user} className="font-bold text-white">&nbsp;you &nbsp;&nbsp;</span>
                                                                                                    :
                                                                                                    <span data-bs-toggle="tooltip" data-bs-placement="bottom" title={bid.user} className="font-bold text-white">&nbsp;{`${bid.user.substr(0,7)}...${bid.user.substr(bid.user.length - 7)}`} &nbsp;&nbsp;</span>
                                                                                                }
                                                                                                {isHighestBid(bid.amount) ? <span className="badge rounded-pill bg-success">Highest Bid</span> : ""}
                                                                                                
                                                                                            </span> 
                                                                                            <small className="font-medium text-gray-500">{customTime(bid.time)}</small> 
                                                                                        </div>
                                                                                        
                                                                                    </div> 
                                                                                </div>
                                                                            </div>
                                                                        </li> 
                                                                    )
                                                                })
                                                            :
                                                            <li>
                                                                <div className="bg-transparent pb-3">
                                                                    <div className="flex justify-between items-center">
                                                                        <div className="flex flex-row items-center"> 
                                                                            <div className="flex flex-col"> 
                                                                                <span className="font-bold text-white">There are currently no bids yet.</span> 
                                                                            </div>
                                                                        </div> 
                                                                    </div>
                                                                </div>
                                                            </li>
                                                            } 
                                                        </ul>            
                                                    </div>
                                                    <div className="tab-pane fade p-3" id="history" role="tabpanel" aria-labelledby="history-tab">
                                                        <ul>
                                                            {bidHistory.length > 0 ? 
                                                                bidHistory?.map((bid,index) => {
                                                                    return(
                                                                        <li key={index}>
                                                                            <div className="bg-transparent pb-3">
                                                                                <div className="flex justify-between items-center">
                                                                                    <div className="flex flex-row items-center"> 
                                                                                        <img src="https://i.imgur.com/hczKIze.jpg" width="40" className="user-img rounded-circle mr-2"></img> 
                                                                                        <div className="flex flex-col"> 
                                                                                            <span>
                                                                                                <span className="font-bold text-white">{bid.amount} ETH&nbsp;</span> 
                                                                                                <span className="font-medium text-gray-500"> by </span>
                                                                                                {bid.user?.toLowerCase() === auth.publicAddress
                                                                                                    ? 
                                                                                                    <span data-bs-toggle="tooltip" data-bs-placement="bottom" title={bid.user} className="font-bold text-white">&nbsp;you &nbsp;&nbsp;</span>
                                                                                                    :
                                                                                                    <span data-bs-toggle="tooltip" data-bs-placement="bottom" title={bid.user} className="font-bold text-white">&nbsp;{`${bid.user.substr(0,7)}...${bid.user.substr(bid.user.length - 7)}`} &nbsp;&nbsp;</span>
                                                                                                }
                                                                                                
                                                                                            </span> 
                                                                                            <small className="font-medium text-gray-500">{customTime(bid.time)}</small> 
                                                                                        </div>
                                                                                        
                                                                                    </div> 
                                                                                </div>
                                                                            </div>
                                                                        </li> 
                                                                    )
                                                                })
                                                            :
                                                            <li>
                                                                <div className="bg-transparent pb-3">
                                                                    <div className="flex justify-between items-center">
                                                                        <div className="flex flex-row items-center"> 
                                                                            <div className="flex flex-col"> 
                                                                                <span className="font-bold text-white">There are currently no bids yet.</span> 
                                                                            </div>
                                                                        </div> 
                                                                    </div>
                                                                </div>
                                                            </li>
                                                            }
                                                            
                                                            
                                                        </ul>            
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        {(status === "auction-on-going" && owner === auth.publicAddress ) &&
                                            <div className="row pl-3 pt-4">
                                                <button className="bg-red-500 px-12 py-2 border-solid-3 focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent" 
                                                        data-bs-toggle="modal" data-bs-target="#modalWithdrawAuction">
                                                    <p className="text-black font-evil text-3xl">Withdraw Auction</p>
                                                </button>
                                            </div>
                                        }
                                        {(status === "auction-on-going" && owner !== auth.publicAddress)  && 
                                            <div className="row pl-3 pt-4">
                                                <button className="bg-white px-12 py-2 border-solid-3 focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent" 
                                                        data-bs-toggle="modal" data-bs-target="#modalPlaceBid">
                                                    <p className="text-black font-evil text-3xl">Place Bid</p>
                                                </button>
                                            </div>
                                        }
                                        {(owner === auth.publicAddress && (status === "not-on-auction")) &&
                                            <div className="row pl-3 pt-4">
                                                <div className="flex justify-between items-center">
                                                    <div className="flex-row">
                                                        <button className="bg-white px-12 py-2 border-solid-3 focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent"
                                                                data-bs-toggle="modal" data-bs-target="#modalPutOnSale" >
                                                            <p className="text-black font-evil text-3xl">Put on sale</p>
                                                        </button>
                                                        <button className="bg-white px-12 py-2 border-solid-3 focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent" >
                                                            <div>
                                                                <p className="text-black font-evil text-3xl"> 
                                                                    Edit
                                                                    <span>
                                                                    <i className="bi bi-pencil-fill"></i>
                                                                </span> 
                                                                </p>
                                                            </div>
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        }
                                        {(owner !== auth.publicAddress && (status === "not-on-auction" )) &&
                                            <div className="row pl-3 pt-4"></div>
                                        }
                                        {(status === "auction-ended")  && 
                                            <div className="row pl-3 pt-4">
                                                <button className="bg-white px-12 py-2 border-solid-3 focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent" 
                                                        data-bs-toggle="modal" data-bs-target="#modalSettleAuction"                              >
                                                    <p className="text-black font-evil text-3xl">Settle Auction</p>
                                                </button>
                                            </div>
                                        }
                                    </div>
                                </div>
                            </div>
                        </div>
                        {/* Modal place bid */}
                        <div className="modal fade" id="modalPlaceBid" tabIndex="-1" role="dialog" aria-hidden="true">
                        <div className="modal-dialog modal-dialog-centered" role="document">
                            <div className="modal-content bg-page-6">
                                    <div className="modal-header">
                                    <p className="modal-title w-100 text-center text-white text-xl letter-spacing-base font-bold font-evil uppercase"> Place a bid</p>
                                        <button type="button" className="close" data-bs-dismiss="modal" aria-label="Close">
                                        <span className="text-white font-digital text-3xl font-bold">&times;</span>
                                        </button>
                                    </div>
                                    <div className="modal-body bg-page-6">
                                        <div className="container">
                                            <div className="row">
                                                <div className="col-md-5">
                                                    <div className="flex mr-7">
                                                        <p className="text-white font-exo-2 text-base font-bold xl:text-xl">Price</p>
                                                    </div>
                                                </div>
                                                <div className="col-md-7">
                                                    <div className="items-center" data-placeholder="ETH">
                                                        <div className="col-9">
                                                            <input
                                                            className={`${hasMsg(bidEqualBuyPriceMsg)} input-icon-ethereum shadow  rounded-lg w-full py-2 pl-10 text-gray-700 leading-tight focus:outline-none focus:shadow-outline`}
                                                            id="bidPrice" type="number" step="0.01" value={bidPrice} min="0" onChange={(e) => handleChangeBidPrice(e)} />
                                                        </div>
                                                    </div>       
                                                    <div className="items-center" data-placeholder="ETH">
                                                        {hasErrorLabel(bidEqualBuyPriceMsg) && <span className="text-green">{bidEqualBuyPriceMsg}</span>}
                                                    </div>                        
                                                </div>
                                            </div>
                                        </div> 
                                    </div>
                                    <div className="modal-footer">
                                        <button className="bg-blueGray-400 px-6 py-2 border-solid-3 focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent" >
                                            <p className="text-white font-evil text-2xl" data-bs-dismiss="modal">Cancel</p>
                                        </button>
                                        <button className="bg-lightBlue-500 px-8 py-2 border-solid-3 focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent" 
                                                onClick={() => handlePlaceBid(item.id)}>
                                            <p className="text-white font-evil text-2xl">Place Bid</p>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        {/* Modal put on sale */}
                        <div className="modal fade" id="modalPutOnSale" tabIndex="-1" role="dialog" aria-hidden="true">
                            <div className="modal-dialog modal-dialog-centered" role="document">
                                <div className="modal-content bg-page-6">
                                    <div className="modal-header">
                                        <p className="modal-title w-100 text-center text-white text-xl letter-spacing-base font-bold font-evil uppercase">Put item on sale</p>
                                        <button type="button" className="close" data-bs-dismiss="modal" aria-label="Close">
                                        <span className="text-white font-digital text-3xl font-bold">&times;</span>
                                        </button>
                                    </div>
                                    <div className="modal-body bg-page-6">
                                        <div className="container form">
                                            <form className="needs-validation">
                                                <div className="row">
                                                    <div className="col-md-5">
                                                        <div className="">
                                                            <p className="text-white font-exo-2 text-base font-bold xl:text-xl">Minimum price</p>
                                                        </div>
                                                    </div>
                                                    <div className="col-md-7">
                                                        <div className="mb:ml-4">
                                                            <div className="items-center" data-placeholder="ETH">
                                                                <div className="col-8">
                                                                    <input onBlur={() => checkPrice(minPrice, buyPrice)} 
                                                                    required className={`${hasError(errorMinPrice)} form-control input-icon-ethereum shadow  rounded-lg w-full py-2 pl-10 text-gray-700 leading-tight focus:outline-none focus:shadow-outline`}
                                                                    id="minPrice" type="number" step="0.01" value={minPrice} min="0" onChange={handleChangeMinPrice} />
                                                                </div>
                                                                
                                                                {/* <div className="col-4">
                                                                    <span class="text-white font-exo-2 text-base font-bold xl:text-xl pl-4">ETH</span>
                                                                </div> */}
                                                                {/* <div className="col-4">
                                                                    <select class="form-select shadow appearance-none border rounded-lg w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" aria-label="Default select example">
                                                                        <optgroup className="font-exo-2 font-bold text-gray-500">
                                                                            <option value="1">ETH</option>
                                                                            <option value="2">Two</option>
                                                                            <option value="3">Three</option>
                                                                        </optgroup>
                                                                    </select>
                                                                </div> */}
                                                            </div>   
                                                            {/* <div class="invalid-feedback">
                                                                Please choose a username.
                                                            </div> */}
                                                            <div className=" items-center" data-placeholder="ETH">
                                                                {hasErrorLabel(errorMinPrice) && <span className="text-red-500">{errorMinPrice}</span>}
                                                            </div>   
                                                        </div>
                                                    </div>
                                                </div>
                                                <div className="row mt-4">
                                                    <div className="col-md-5">
                                                        <div className="">
                                                            <p className="text-white font-exo-2 text-base font-bold xl:text-xl">Buy price</p>
                                                        </div>
                                                    </div>
                                                    <div className="col-md-7">
                                                        <div className="mb:ml-4">
                                                            <div className="items-center" data-placeholder="ETH">
                                                                <div className="col-8">
                                                                    <input onBlur={() => checkPrice(minPrice, buyPrice)}
                                                                    required className={`${hasError(errorBuyPrice)} form-control input-icon-ethereum shadow  rounded-lg w-full py-2 pl-10 text-gray-700 leading-tight focus:outline-none focus:shadow-outline`}
                                                                    id="buyPrice" type="number" step="0.01" value={buyPrice} min="0" onChange={handleChangeBuyPrice} />
                                                                </div>
                                                            </div>  
                                                            <div className="items-center" data-placeholder="ETH">
                                                                {hasErrorLabel(errorBuyPrice) && <span className="text-red-500">{errorBuyPrice}</span>}
                                                            </div>                            
                                                        </div>
                                                    </div>
                                                </div>
                                                <div className="row mt-4 items-center">
                                                    <div className="col-md-5">
                                                        <div className="">
                                                            <p className="text-white font-exo-2 text-base font-bold xl:text-xl">End Time</p>
                                                        </div>
                                                    </div>
                                                    <div className="col-md-7">
                                                        <div className="mb:ml-4">
                                                            <div className="items-center" data-placeholder="ETH">
                                                                <div className="col-9">
                                                                    {/* <span className="text-white font-exo-2 text-base font-bold">Ending</span> */}
                                                                    <DatePicker
                                                                    className={`${hasError(errorEndDate)} rounded-lg form-control`}
                                                                    selected={endDate}
                                                                    onChange={handleChangeEndDate}
                                                                    timeInputLabel="Time:"
                                                                    dateFormat="MM/dd/yyyy h:mm aa"
                                                                    showTimeInput
                                                                    />
                                                                    <div className="flex flex-row items-center" data-placeholder="ETH">
                                                                        {hasErrorLabel(errorEndDate) && <span className="text-red-500">{errorEndDate}</span>}
                                                                    </div> 
                                                                </div>
                                                            </div>                              
                                                        </div>
                                                    </div>
                                                </div>
                                                <div className="row mt-4 items-center">
                                                    <div className="col-md-5">
                                                    <div className="">
                                                            <p className="text-white font-exo-2 text-base font-bold xl:text-xl">Custom auction</p>
                                                        </div>
                                                    </div>
                                                    <div className="col-md-7">
                                                        <label className="switch">
                                                            <input type="checkbox" onChange={handleCheckCustomAuction} checked={isCustomAuction} data-bs-toggle="collapse" href="#collapseCustomAuction" role="button" aria-expanded="false" aria-controls="collapseCustomAuction"></input>
                                                            <span className="slider round"></span>
                                                        </label>
                                                    </div>
                                                </div>
                                                <br />
                                                <hr style={{borderTop: "3px solid white"}}/>
                                                <div className="collapse" id="collapseCustomAuction">
                                                    <div className="row mt-4">
                                                        <div className="col-md-5">
                                                            <div className="">
                                                                <p className="text-white font-exo-2 text-base font-bold xl:text-xl">Bid increase %</p>
                                                            </div>
                                                        </div>
                                                        <div className="col-md-7">
                                                            <div className="flex items-center">
                                                                <div className="flex flex-row">
                                                                    <div className="col-8">
                                                                        <input
                                                                        className="shadow rounded-lg pl-8 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                                                        id="bidIncrease" type="number" step="0.01" value={bidIncrease} min="0" max="100" onChange={handleChangeBidIncrease} />
                                                                    </div>
                                                                </div>
                                                                <div className="flex flex-row ">
                                                                    <p className="text-white font-exo-2 text-base font-bold xl:text-xl">&nbsp;(%)</p>
                                                                </div>                            
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div className="row mt-4">
                                                        <div className="col-md-5">
                                                            <div className="">
                                                                <p className="text-white font-exo-2 text-base font-bold xl:text-xl">Bid period</p>
                                                            </div>
                                                        </div>
                                                        <div className="col-md-7">
                                                            <div className="flex items-center">
                                                                <div className="flex flex-row">
                                                                    <input
                                                                    className="shadow rounded-lg pl-8 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                                                    id="bidPeriod" type="number" step="1" value={bidPeriod} min="0" max="100000" onChange={handleChangeBidPeriod} />
                                                                    
                                                                </div>
                                                                <div className="flex flex-row ">
                                                                    <p className="text-white font-exo-2 text-base font-bold xl:text-xl">&nbsp;(minutes)</p>
                                                                </div> 
                                                            </div>
                                                                                      
                                                        </div>
                                                    </div>
                                                </div>
                                                
                                                <br />
                                            </form>
                                        </div> 
                                        
                                    </div>
                                    <div className="modal-footer">
                                        <button className="bg-blueGray-400 px-6 py-2 border-solid-3 focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent">
                                            <p className="text-white font-evil text-2xl" data-bs-dismiss="modal">Close</p>
                                        </button>
                                        <button type="submit" className="bg-lightBlue-500 px-12 py-2 border-solid-3 focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent"
                                                 onClick={() => handleMakeAuction(item?.id)}>
                                            <p className="text-white font-evil text-2xl">Sell</p>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        {/* Modal withdraw auction */}
                        <div className="modal fade" id="modalWithdrawAuction" tabIndex="-1" role="dialog" aria-hidden="true">
                            <div className="modal-dialog modal-dialog-centered modal-lg" role="document">
                            <div className="modal-content bg-page-6">
                                    <div className="modal-header">
                                        <p className="modal-title w-100 text-center text-white text-xl letter-spacing-base font-bold font-evil uppercase"> Are you sure you want to cancel your listing?</p>
                                        <button type="button" className="close" data-bs-dismiss="modal" aria-label="Close">
                                        <span className="text-white font-digital text-3xl font-bold">&times;</span>
                                        </button>
                                    </div>
                                    <div className="modal-body bg-page-6">
                                        <div className="container">
                                        <p className="text-white font-exo-2 text-base font-bold xl:text-xl"> Canceling your listing will unpublish this sale from the marketplace and requires a transaction to make sure it will never be fulfillable.</p>
                                        </div> 
                                    </div>
                                    <div className="modal-footer">
                                        <button className="bg-blueGray-400 px-6 py-2 border-solid-3 focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent">
                                            <p className="text-white font-evil text-2xl" data-bs-dismiss="modal">No</p>
                                        </button>
                                        <button className="bg-lightBlue-500 px-8 py-2 border-solid-3 focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent" onClick={() => handleWithdrawAuction(item?.id)}>
                                            <p className="text-white font-evil text-2xl">Yes</p>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        {/** Modal settle auction */}
                        <div className="modal fade" id="modalSettleAuction" tabIndex="-1" role="dialog" aria-hidden="true">
                            <div className="modal-dialog modal-dialog-centered modal-lg" role="document">
                            <div className="modal-content bg-page-6">
                                    <div className="modal-header">
                                        <p className="modal-title w-100 text-center text-white text-xl letter-spacing-base font-bold font-evil uppercase"> Are you sure you want to settle the auction?</p>
                                        <button type="button" className="close" data-bs-dismiss="modal" aria-label="Close">
                                        <span className="text-white font-digital text-3xl font-bold">&times;</span>
                                        </button>
                                    </div>
                                    <div className="modal-body bg-page-6">
                                        <div className="container">
                                        <p className="text-white font-exo-2 text-base font-bold xl:text-xl"> Settling your auction will close this sale from the auction list and requires a transaction to make sure it will never be fulfillable.</p>
                                        </div> 
                                    </div>
                                    <div className="modal-footer">
                                        <button className="bg-blueGray-400 px-6 py-2 border-solid-3 focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent">
                                            <p className="text-white font-evil text-2xl" data-bs-dismiss="modal">No</p>
                                        </button>
                                        <button className="bg-lightBlue-500 px-8 py-2 border-solid-3 focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent" onClick={() => handleSettleAuction("0xb8262489b64477E88619DE37C6bA6a116a2ADcb7", item?.id)}>
                                            <p className="text-white font-evil text-2xl">Yes</p>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        {/* Modal lower price */}
                        <div className="modal fade" id="modalLowerPrice" tabIndex="-1" role="dialog" aria-hidden="true">
                            <div className="modal-dialog modal-dialog-centered" role="document">
                            <div className="modal-content bg-page-6">
                                    <div className="modal-header">
                                    <p className="modal-title w-100 text-center text-white text-xl letter-spacing-base font-bold font-evil uppercase"> Lower the listing price</p>
                                        <button type="button" className="close" data-bs-dismiss="modal" aria-label="Close">
                                        <span className="text-white font-digital text-3xl font-bold">&times;</span>
                                        </button>
                                    </div>
                                    <div className="modal-body bg-page-6">
                                        <div className="container">
                                            <div className="row">
                                                <div className="col-md-5">
                                                    <div className="flex mr-7">
                                                        <p className="text-white font-exo-2 text-base font-bold xl:text-xl">New price</p>
                                                    </div>
                                                </div>
                                                <div className="col-md-7">
                                                    <div className="items-center" data-placeholder="ETH">
                                                        <div className="col-9">
                                                            <input
                                                            className="input-icon-ethereum shadow  rounded-lg w-full py-2 pl-10 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                                            id="newMinPrice" type="number" step="0.01" max={newMinPrice} min="0" onChange={handleSetNewMinPrice} />
                                                        </div>
                                                    </div>                              
                                                </div>
                                            </div>
                                        </div> 
                                    </div>
                                    <div className="modal-footer">
                                        <button className="bg-blueGray-400 px-6 py-2 border-solid-3 focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent">
                                            <p className="text-white font-evil text-2xl" data-bs-dismiss="modal">Cancel</p>
                                        </button>
                                        <button className="bg-lightBlue-500 px-8 py-2 border-solid-3 focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent">
                                            <p className="text-white font-evil text-2xl" data-bs-dismiss="modal" onClick={handleSetNewMinPrice}>Set new price</p>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                : 
                <p>Loading........</p>
                }
            </div>
        
        
    </div>
    );
}

export default TokenDetail;