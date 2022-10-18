import React, { useEffect, useState } from "react";
import { BrowserRouter as Router } from "react-router-dom";
import { SnackbarProvider } from 'notistack'
import { SnackbarUtilsConfigurator } from "./helpers/snackbarUtils";
import Routes from './react-routes/routes'

function App() {
	return(
		<React.Fragment>
			<SnackbarProvider 
				maxSnack={2} 
				anchorOrigin={{
					vertical: 'top',
					horizontal: 'right',
				}}
			>
				<SnackbarUtilsConfigurator />
				<Router>
					<Routes />
				</Router>
			</SnackbarProvider>
		</React.Fragment>
	)
}
	
export default App;