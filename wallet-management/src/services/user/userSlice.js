import { createSlice, createAsyncThunk } from '@reduxjs/toolkit'
import { toast } from '../../helpers/snackbarUtils';
import { sendRequest } from '../../helpers/sendRequest';

export const url = process.env.REACT_APP_SERVER_URL + '/api/user/';

const NATIVE_TOKEN = {
	name: "tBNB",
	address: "0x0000000000000000000000000000000000000000",
	type: "native"
}

const initialState = {
	publicAddress: null,
	balance: null,
	assets: [],
	tokenList: {},
	isLoading: "idle",
	privateKey: null
	
};

export const getUserInfo = createAsyncThunk(
	'GET_USER_INFO',
	async (data, thunkAPI) => {
		try {
			return await sendRequest({
				url: url+"info",
				method: "GET",
				params: { tokens: localStorage.getItem("tokenList") }
			})
		} catch (error) {
			return thunkAPI.rejectWithValue(error.response.data.msg ?? "Internal server error!");
		}
	}
);

export const transferToken = createAsyncThunk(
	'TRANSFER_TOKEN',
	async (data, thunkAPI) => {
		try {
			return await sendRequest({
				url: url+"transfer-token",
				method: "POST",
				data: data
			})
		} catch (error) {
			return thunkAPI.rejectWithValue(error.response.data.msg ?? "Internal server error!");
		}
	}
);

export const exportPrivateKey = createAsyncThunk(
	'EXPORT_PRIVATE_KEY',
	async (data, thunkAPI) => {
		try {
			return await sendRequest({
				url: url+"export-private-key",
				method: "GET",
			})
		} catch (error) {
			return thunkAPI.rejectWithValue(error.response.data.msg ?? "Internal server error!");
		}
	}
);

export const userSlice = createSlice({
	name: 'user',
	initialState,
	reducers: {
		getAsset: (state, action) => {
			let tokenList = JSON.parse(localStorage.getItem('tokenList'))
			if(!tokenList) {
				localStorage.setItem('tokenList', JSON.stringify({
					[NATIVE_TOKEN.address]:  {
						name: NATIVE_TOKEN.name,
						type: NATIVE_TOKEN.type
					}
				}));
				
			}
		},
		addAsset: (state, action) => {
			let data = action.payload
			let tokenList = JSON.parse(localStorage.getItem('tokenList'))
			let newList = {
				...tokenList,
				[data.address]: {
					name: data.name,
					type: "utility"
				}
			}
			localStorage.setItem('tokenList', JSON.stringify(newList));
		},
		removeAsset: (state, action) => {
			console.log(action.payload)
			let tokenList = JSON.parse(localStorage.getItem('tokenList'))
			delete tokenList[action.payload]
			localStorage.setItem('tokenList', JSON.stringify(tokenList));
		},
	 
	},
	extraReducers: {
		[getUserInfo.pending]: (state, action) => {
			//console.log(action);
			state.isLoading = true;
		},
		[getUserInfo.fulfilled]: (state, action) => {
			console.log(action);
			state.isLoading = false;
			state.publicAddress = action.payload.publicAddress;
			state.balance = action.payload.balance
			state.assets = action.payload.assets
		},
		[getUserInfo.rejected]: (state, action) => {
			//console.log(action);
			state.isLoading = false;
			toast.error(action.payload)
		},
		[transferToken.pending]: (state) => {
			//console.log(state);
			state.isLoading = true;
		},
		[transferToken.fulfilled]: (state, action) => {
			//console.log(action);
			state.isLoading = false;
			alert("Success!! Your transaction hash is: " + action.payload.transactionHash)
			window.location.reload()
		},
		[transferToken.rejected]: (state, action) => {
			console.log(action);
			state.isLoading = false;
			toast.error(action.payload)
		},

		[exportPrivateKey.pending]: (state) => {
			//console.log(state);
			state.isLoading = true;
		},
		[exportPrivateKey.fulfilled]: (state, action) => {
			//console.log(action);
			state.isLoading = false;
			state.privateKey= action.payload.privateKey
		},
		[exportPrivateKey.rejected]: (state, action) => {
			console.log(action);
			state.isLoading = false;
			toast.error(action.payload)
		},
	},
})

export const {getAsset, addAsset, removeAsset} = userSlice.actions

export default userSlice.reducer
