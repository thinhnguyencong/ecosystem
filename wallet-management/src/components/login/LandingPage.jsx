import React, { useEffect } from 'react';
import { useDispatch, useSelector } from "react-redux";

function LandingPage(props) {
    const isAuthenticated = useSelector((state) => state.auth.isAuthenticated)

    if(isAuthenticated) {
        return (<div></div>)
    } else {
        return (
            <div>
                <a href="/">Login</a>
            </div>
        ) 
    }
    
}

export default LandingPage;