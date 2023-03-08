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
        console.log("error", error);
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
        const response = await axiosApiInstance.get(url, {params: params}, {timeout: 2})
		return response;
    } else if(method === "POST"){
        const response = await axiosApiInstance.post(url, {data: data})
		return response;
    } else if(method === "PUT"){

    } else if(method === "DELETE"){

    }

    async function refreshAccessToken() {
        const params = {
            clientId: import.meta.env.VITE_CLIENT_ID
        };
        console.log("Refresh token............");
        return axiosApiInstance
            .get(`${import.meta.env.VITE_SERVER_URL}/api/auth/refreshToken`,{params: params, withCredentials: true})
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