import { createSlice, createAsyncThunk } from '@reduxjs/toolkit'
import { setCookie, clearCookie } from '../../helpers/config';
import jwtDecode from "jwt-decode"
import { url as userUrl } from '../user/userSlice';
import { toast } from '../../helpers/snackbarUtils';
import { sendRequest } from '../../helpers/sendRequest';

const url = process.env.REACT_APP_SERVER_URL + '/api/auth/';
const initialState = {
	isAuthenticated: null,
	user: {},
	//roles: [],
	isLoading: false
};

export const doAuthRedirect = createAsyncThunk(
	'DO_AUTH_REDIRECT',
	async (data, thunkAPI) => {
		try {
			const params = {
				clientId: process.env.REACT_APP_CLIENT_ID,
				redirect_uri: data
			};
			return await sendRequest({
				url: url+"authurl",
				method: "GET",
				params: params
			})
		} catch (error) {
			console.log(error.response.data.msg ?? "Error obtaining Auth URL!")
			return thunkAPI.rejectWithValue(error.response.data.msg ?? "Internal server error!");
		}
	}
);

export const getAuthToken = createAsyncThunk(
	'GET_AUTH_TOKEN',
	async (data, thunkAPI) => {
		try {
			const payload = {
				code: data.code,
				clientId: process.env.REACT_APP_CLIENT_ID,
				redirect_uri: data.redirect_uri
			};
			return await sendRequest({
				url: url+"authtoken",
				method: "POST",
				data: payload
			})
		} catch (error) {
			console.log(error.response.data.msg ?? "Error obtaining Auth Token!")
			return thunkAPI.rejectWithValue(error.response.data.msg ?? "Internal server error!");
		}
	}
);

export const reAuth = createAsyncThunk(
	'RE_AUTH',
	async (data, thunkAPI) => {
		try {
			const payload = {
				clientId: process.env.REACT_APP_CLIENT_ID
			};
			return await sendRequest({
				url: url+"reauth",
				method: "POST",
				data: payload
			})
		} catch (error) {
			console.log(error.response.data.msg ?? "Internal server error!")
			return thunkAPI.rejectWithValue(error.response.data.msg ?? "Internal server error!");
		}
	}
);


export const authSlice = createSlice({
	name: 'auth',
	initialState,
	reducers: {
		logout: (state) => {
			window.sessionStorage.clear();
    		window.location = `http://localhost:8080/realms/demo/protocol/openid-connect/logout?post_logout_redirect_uri=${process.env.REACT_APP_CLIENT_URL}/home&client_id=${process.env.REACT_APP_CLIENT_ID}`
		},
	},
	extraReducers: {
		[doAuthRedirect.pending]: (state, action) => {
			console.log(action);
			state.isLoading = true;
		},
		[doAuthRedirect.fulfilled]: (state, action) => {
			console.log(action);
			console.log(action.payload);
			window.location.assign(action.payload.url)
			state.isLoading = false;
		},
		[doAuthRedirect.rejected]: (state, action) => {
			console.log(action);
			state.isLoading = false;
			toast.error(action.payload)
		},

		///////////////////
		
		[getAuthToken.pending]: (state) => {
			state.isLoading = true;
		},
		[getAuthToken.fulfilled]: (state, action) => {
			console.log(action.payload);
			const { authToken, user } = action.payload;
			state.isAuthenticated= true
			state.isLoading = false;
			state.user = user;
			window.sessionStorage.setItem("authToken", authToken);
			//toast.success(action.payload.msg)
		},
		[getAuthToken.rejected]: (state, action) => {
			//console.log(action);
			state.isLoading = false;
			toast.error(action.payload)
		},

		///////////////////

		[reAuth.pending]: (state) => {
			state.isLoading = true;
		},
		[reAuth.fulfilled]: (state, action) => {
			console.log(action.payload);
			if (action.payload.status === 200) {
				state.isAuthenticated= true
			} else {
				window.sessionStorage.clear();
				window.location.reload()
			}
			state.isLoading = false;
		},
		[reAuth.rejected]: (state, action) => {
			//console.log(action);
			state.isLoading = false;
			window.sessionStorage.clear();
			window.location.reload()
		},
		
	},
	
})

export const {logout} = authSlice.actions

export default authSlice.reducer
