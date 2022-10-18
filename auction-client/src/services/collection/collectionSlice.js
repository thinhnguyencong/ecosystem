import { createSlice, createAsyncThunk } from '@reduxjs/toolkit'
import { toast } from '../../helpers/snackbarUtils';
import { sendRequest } from '../../helpers/sendRequest';

export const url = process.env.REACT_APP_SERVER_URL + '/api/collection/';

const initialState = {
	collection: [],
	status: "idle",
	item: null,
};

export const getNftById = createAsyncThunk(
	'GET_NFT_BY_ID',
	async (data, thunkAPI) => {
		try {
			return await sendRequest({
				url: url+"get-nft-by-id",
				method: "GET",
				params: {id: data},
			})
		} catch (error) {
			return thunkAPI.rejectWithValue(error.response.data.msg ?? "Internal server error!");
		}
	}
);

export const loadCollection = createAsyncThunk(
	'LOAD_COLLECTION',
	async (data, thunkAPI) => {
		try {
			return await sendRequest({
				url: url+"get-collection",
				method: "GET",
				params: {},
			})
		} catch (error) {
			return thunkAPI.rejectWithValue(error.response.data.msg ?? "Internal server error!");
		}
	}
);

export const collectionSlice = createSlice({
	name: 'collection',
	initialState,
	extraReducers: {
		[getNftById.pending]: (state, action) => {
			//console.log(action);
			state.isLoading = true;
		},
		[getNftById.fulfilled]: (state, action) => {
			console.log(action);
			state.isLoading = false;
            state.item = action.payload
		},
		[getNftById.rejected]: (state, action) => {
			//console.log(action);
			state.isLoading = false;
			toast.error(action.payload)
		},
		[loadCollection.pending]: (state, action) => {
			//console.log(action);
			state.status = "loading";
		},
		[loadCollection.fulfilled]: (state, action) => {
			console.log(action);
			state.status = "succeeded";
            state.collection = action.payload
		},
		[loadCollection.rejected]: (state, action) => {
			//console.log(action);
			state.status = "failed";
			toast.error(action.payload)
		},
	},
})

export default collectionSlice.reducer
