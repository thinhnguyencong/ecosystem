import axios from 'axios'

export const sendRequest = async ({url, method, params, data}) => {
    const axiosApiInstance = axios.create();
    
    // Request interceptor for API calls
    axiosApiInstance.interceptors.request.use(
        async config => {
            const authToken = window.sessionStorage.getItem("authToken")
            config.withCredentials = true;
            config.headers = { 
                'Authorization': `Bearer ${authToken}`,
            }
            return config;
        },
        error => {
            Promise.reject(error)
        }
    );

    // Response interceptor for API calls
    axiosApiInstance.interceptors.response.use((response) => {
        return response
    }, async function (error) {
        // if request sent with expired access token, call refresh token function
        // reference: https://thedutchlab.com/blog/using-axios-interceptors-for-refreshing-your-api-token
        const originalRequest = error.config;
        if (error.response.status === 403 && !originalRequest._retry) {
            originalRequest._retry = true;
            const access_token = await refreshAccessToken();        
            originalRequest.headers['Authorization'] = 'Bearer ' + access_token;
            return axiosApiInstance(originalRequest);
        }
        return Promise.reject(error);
    });

    if(method === "GET"){
        const resp = await axiosApiInstance.get(url, {params: params})
		return resp.data;
    } else if(method === "POST"){
        const resp = await axiosApiInstance.post(url, {data: data})
        console.log(resp)
		return resp.data;
    } else if(method === "PUT"){

    } else if(method === "DELETE"){

    }

    const refreshAccessToken = async () => {
        const params = {
            clientId: process.env.REACT_APP_CLIENT_ID
        };
        return axiosApiInstance
            .get(`${process.env.REACT_APP_SERVER_URL}/auth/refreshToken`,{params: params, withCredentials: true})
            .then(result => {
                const { authToken } = result.data
                window.sessionStorage.setItem("authToken", authToken)
                return authToken
            })
            .catch(error => {
                console.error(error)
                alert("Something's wrong, please refresh page");
                window.location.reload()
            })
    }
}