import React from 'react';
import { Route, Switch } from "react-router-dom";
import PrivateRoute from './privateRoute';
import Home from '../components/login/Home';
import LandingPage from '../components/login/LandingPage';
import Wallet from '../components/wallet/Wallet';
import Collection from '../components/marketplace/collection';
import TokenDetail from '../components/marketplace/tokenDetail';
import AuctionList from '../components/marketplace/auctionList';

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
                component={Collection}
            />
             <PrivateRoute
                path="/auction-list"
                exact
                component={AuctionList}
            />
            <PrivateRoute
                path="/token/:id"
                exact
                component={TokenDetail}
            />
            <Route
                path="*"
                component={() => "404 NOT FOUND"}
            />
        </Switch>
    )

}

export default Routes;