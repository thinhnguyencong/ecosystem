
import React, { useEffect, useState } from 'react';
import { useDispatch, useSelector } from "react-redux";
import { Route, Redirect } from 'react-router-dom';
import Layout from '../layout/layout'
import { memo } from "react";
import { reAuth, doAuthRedirect, getAuthToken } from '../services/auth/authSlice';
import { UrlParams } from "./support/UrlParams";

const PrivateRoute = ({ component: Component, ...rest }) => {
    const isAuthenticated = useSelector((state) => state.auth.isAuthenticated)
    const dispatch = useDispatch()
    const HREF = window.location.href.trim();
    console.log("HREF", HREF);
    const urlParams = new UrlParams(HREF);
    window.history.replaceState({}, null, window.location.href.split('?')[0]);
    useEffect(() => {
        const fetchData = async () => {
			console.log("ueffec");
			if (!window.sessionStorage.getItem("authToken")) {
				console.log("ueffec 1111");
				await oAuth2Flow(urlParams, HREF.split('?')[0]);
			} else {
				dispatch(reAuth())
			}
		}
		fetchData()
    }, [])

    async function oAuth2Flow(urlParams, redirect_uri) {
        const code = urlParams.get("code");
        if (code) {
            dispatch(getAuthToken({code, redirect_uri}))
        } else {
            console.log("redirect");
            dispatch(doAuthRedirect(redirect_uri))
        }
    }

    if(isAuthenticated === null){
        return <></>
    }

    return (
        <Route {...rest} render={props => {
            if(!isAuthenticated) {
                return <Redirect to='/'/>
            } else {
                return <Layout><Component {...props} /></Layout>
            }
        }}
        />
    );
};

export default memo(PrivateRoute);



