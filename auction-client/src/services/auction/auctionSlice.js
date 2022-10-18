import { createSlice, createAsyncThunk } from '@reduxjs/toolkit'
import { toast } from '../../helpers/snackbarUtils';
import { sendRequest } from '../../helpers/sendRequest';

export const url = process.env.REACT_APP_SERVER_URL + '/api/auction/';

const initialState = {
    seller: null,
    minPrice: null,
    buyPrice: null,
    bidPeriod: null,
    highestBid: null,
    highestBidder: null,
    bidIncreasePercentage: null,
    auctionStart: null,
    auctionEnd: null,

	auctionList: null,
    bidHistory: null,
   
    isLoadingRefresh: false,
    status: null,
    isLoading: "idle",
};

export const createAuction = createAsyncThunk(
	'CREATE_AUCTION',
	async (data, thunkAPI) => {
		try {
			return await sendRequest({
				url: url+"create-auction",
				method: "POST",
				data: data
			})
		} catch (error) {
			return thunkAPI.rejectWithValue(error.response.data.msg ?? "Internal server error!");
		}
	}
);

export const loadNftAuctionList = createAsyncThunk(
	'LOAD_NFT_AUCTION_LIST',
	async (data, thunkAPI) => {
		try {
			return await sendRequest({
				url: url+"auction-list",
				method: "GET",
			})
		} catch (error) {
			return thunkAPI.rejectWithValue(error.response.data.msg ?? "Internal server error!");
		}
	}
);

export const loadNftAuctionById = createAsyncThunk(
	'LOAD_NFT_AUCTION_BY_ID',
	async (data, thunkAPI) => {
		try {
			return await sendRequest({
				url: url+"auction-by-id",
				method: "GET",
				params: {id: data},
			})
		} catch (error) {
			return thunkAPI.rejectWithValue(error.response.data.msg ?? "Internal server error!");
		}
	}
);

export const settleAuction = createAsyncThunk(
	'SETTLE_AUCTION',
	async (data, thunkAPI) => {
		try {
			console.log(data);
			return await sendRequest({
				url: url+"settle-auction",
				method: "POST",
				data: data
			})
		} catch (error) {
			return thunkAPI.rejectWithValue(error.response.data.msg ?? "Internal server error!");
		}
	}
);

export const placeBid = createAsyncThunk(
	'PLACE_BID',
	async (data, thunkAPI) => {
		try {
			return await sendRequest({
				url: url+"place-bid",
				method: "POST",
				data: data
			})
		} catch (error) {
			return thunkAPI.rejectWithValue(error.response.data.msg ?? "Internal server error!");
		}
	}
);

export const withdrawAuction = createAsyncThunk(
	'WITHDRAW_AUCTION',
	async (data, thunkAPI) => {
		try {
			return await sendRequest({
				url: url+"withdraw-auction",
				method: "POST",
				data: data
			})
		} catch (error) {
			return thunkAPI.rejectWithValue(error.response.data.msg ?? "Internal server error!");
		}
	}
);

export const loadBidHistory = createAsyncThunk(
	'LOAD_BID_HISTORY',
	async (data, thunkAPI) => {
		try {
			return await sendRequest({
				url: url+"bid-history",
				method: "GET",
				params: {id: data},
			})
		} catch (error) {
			return thunkAPI.rejectWithValue(error.response.data.msg ?? "Internal server error!");
		}
	}
);

export const auctionSlice = createSlice({
	name: 'auction',
	initialState,
	extraReducers: {
		[loadNftAuctionList.pending]: (state, action) => {
			//console.log(action);
			state.isLoading = true;
		},
		[loadNftAuctionList.fulfilled]: (state, action) => {
			console.log(action);
			state.isLoading = false;
            state.auctionList = action.payload
		},
		[loadNftAuctionList.rejected]: (state, action) => {
			//console.log(action);
			state.isLoading = false;
			toast.error(action.payload)
		},

        [loadNftAuctionById.pending]: (state, action) => {
			//console.log(action);
			state.isLoading = true;
		},
		[loadNftAuctionById.fulfilled]: (state, action) => {
			console.log(action);
			state.isLoading = false;
            state.seller = action.payload.seller
            state.minPrice= action.payload.minPrice
            state.buyPrice= action.payload.buyPrice
            state.bidPeriod= action.payload.bidPeriod
            state.bidIncreasePercentage= action.payload.bidIncreasePercentage
            state.highestBid= action.payload.highestBid
            state.highestBidder= action.payload.highestBidder
            state.auctionStart= action.payload.auctionStart
            state.auctionEnd= action.payload.auctionEnd
            state.status= action.payload.status
		},
		[loadNftAuctionById.rejected]: (state, action) => {
			//console.log(action);
			state.isLoading = false;
			toast.error(action.payload)
		},

        [loadBidHistory.pending]: (state, action) => {
			//console.log(action);
			state.isLoading = true;
		},
		[loadBidHistory.fulfilled]: (state, action) => {
			console.log(action);
			state.isLoading = false;
            state.bidHistory = action.payload
		},
		[loadBidHistory.rejected]: (state, action) => {
			//console.log(action);
			state.isLoading = false;
			toast.error(action.payload)
		},

		[createAuction.pending]: (state, action) => {
			//console.log(action);
			state.isLoading = true;
		},
		[createAuction.fulfilled]: (state, action) => {
			console.log(action);
			state.isLoading = false;
			toast.success(action.payload.msg)
			window.location.reload()
		},
		[createAuction.rejected]: (state, action) => {
			//console.log(action);
			state.isLoading = false;
			toast.error(action.payload)
		},

		[placeBid.pending]: (state, action) => {
			//console.log(action);
			state.isLoading = true;
		},
		[placeBid.fulfilled]: (state, action) => {
			console.log(action);
			state.isLoading = false;
			toast.success(action.payload.msg)
		},
		[placeBid.rejected]: (state, action) => {
			//console.log(action);
			state.isLoading = false;
			toast.error(action.payload)
		},

		[settleAuction.pending]: (state, action) => {
			//console.log(action);
			state.isLoading = true;
		},
		[settleAuction.fulfilled]: (state, action) => {
			console.log(action);
			state.isLoading = false;
			toast.success(action.payload.msg)
		},
		[settleAuction.rejected]: (state, action) => {
			//console.log(action);
			state.isLoading = false;
			toast.error(action.payload)
		},

		[withdrawAuction.pending]: (state, action) => {
			//console.log(action);
			state.isLoading = true;
		},
		[withdrawAuction.fulfilled]: (state, action) => {
			console.log(action);
			state.isLoading = false;
			toast.success(action.payload.msg)
		},
		[withdrawAuction.rejected]: (state, action) => {
			//console.log(action);
			state.isLoading = false;
			toast.error(action.payload)
		},
	},
})

export default auctionSlice.reducer
