import React from 'react';
import { Route, Switch } from "react-router-dom";
import PrivateRoute from './privateRoute';
import Home from '../components/login/Home';
import LandingPage from '../components/login/LandingPage';
import Wallet from '../components/wallet/Wallet';

function Routes(props) {
    return (
        <Switch>
            <Route
                path="/home"
                exact
                component={LandingPage}
            />
            <PrivateRoute
                path="/"
                exact
                component={Home}
            />
            <PrivateRoute
                path="/wallet"
                exact
                component={Wallet}
            />
            <Route
                path="*"
                component={() => "404 NOT FOUND"}
            />
        </Switch>
    )

}

export default Routes;