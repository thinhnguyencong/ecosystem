import React, { useState, useEffect } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import Jazzicon, { jsNumberForAddress } from 'react-jazzicon'
import Box from "@mui/material/Box";
import MenuItem from "@mui/material/MenuItem";
import Select from "@mui/material/Select";
import Button from '@mui/material/Button';
import SendIcon from '@mui/icons-material/Send';
import { Grid, InputAdornment, TextField, Typography } from '@mui/material';
import { Dialog } from '@mui/material';
import DialogTitle from '@mui/material/DialogTitle';
import DialogActions from '@mui/material/DialogActions';
import DialogContent from '@mui/material/DialogContent';

const NATIVE_TOKEN = { name: "tBNB", address: "0x0000000000000000000000000000000000000000", type: "native"}
function ModalSendToken(props) {
	let initAssetArr = [NATIVE_TOKEN]
    const open = props.open
    const dispatch = useDispatch()
    const userSelector = useSelector((state) => state.user)
    const [assets, setAssets] = useState(initAssetArr)
	const [state, setState] = useState({
		asset: NATIVE_TOKEN,
		amount: "",
		addressTo: "",
		openPasswordModal: false
	})

	const {asset, amount, addressTo} = state

    useEffect(() => {
		let newArr = initAssetArr.concat(userSelector.assets)
		const arrUniq = [...new Map(newArr.map(v => [v.address, v])).values()]
		setAssets(arrUniq)
	}, [JSON.stringify(userSelector.assets)])


	console.log("assets", assets);
    const handleChangeAsset= (event) => {
		let obj = assets.find(x => x.address === event.target.value)
		console.log(obj);
		setState({
			...state,
			asset: {
				name: obj.name,
				address: event.target.value,
				type: obj.type
			}
		})
	}
	const handleChangeAmount= (event) => {
		setState({
			...state,
			amount: event.target.value
		})
	}
	const handleChangeReceiver = (event) => {
		setState({
			...state,
			addressTo: event.target.value
		})
	}
	const handleSendToken = () => {
		// console.log(data)
        props.handleSendToken({addressTo, amount, asset})
	}
    const handleClose = () => {
        props.handleClose()
    }
	//console.log("state", state)
    return (
        <Dialog open={open} onClose={handleClose} sx={{}}>
            <DialogTitle>Send Token</DialogTitle>
            <DialogContent>
			<Box>
				<Grid container rowSpacing={1} columnSpacing={{ xs: 1, sm: 2, md: 3 }}>
				<Grid item xs={3} alignSelf="center">
						<Typography style={{display: 'inline-block'}} fontSize={24}>Send To: &nbsp;</Typography>
					</Grid>
					<Grid item xs={6} pb={2}>
						<TextField
							sx={{ width: "100%" }}
							id="addressTo"
							label="Address To"
                            name="addressTo"
                            autoComplete="addressTo"
							value={addressTo}
							onChange={handleChangeReceiver}
							endadornment={<InputAdornment position="end">{asset.name}</InputAdornment>}
						/>
					</Grid>
					<Grid item xs={3}></Grid>
					<Grid item xs={3} alignSelf="center">
						<Typography fontSize={24} style={{display: 'inline-block', margin: "auto"}}>Asset: &nbsp;</Typography>
					</Grid>
					<Grid item xs={6}>
						<Select
							sx={{ width: "100%" }}
							defaultValue={asset.address ?? ""}
							renderValue={(value) => {
								return (
									<Box sx={{ display: "flex", gap: 1 }}>
										<Jazzicon diameter={30} seed={jsNumberForAddress(value)} />
										{asset.name}
									</Box>
								);
							}}
							onChange={(e) => handleChangeAsset(e)}
						>
							{assets.map((asset, index) => (
								<MenuItem key={index} value={asset.address}>
									<Jazzicon diameter={40} seed={jsNumberForAddress(asset.address)} /> &nbsp; &nbsp;
									{asset.name}
								</MenuItem>
							))}	
						</Select>
					</Grid>
					<Grid item xs={3} alignSelf="center">
						
					</Grid>
					<Grid item xs={3} alignSelf="center">
						<Typography style={{display: 'inline-block'}} fontSize={24}>Amount: &nbsp;</Typography>
					</Grid>
					<Grid item xs={6}>
						<TextField
							sx={{ width: "100%" }}
							id="amount"
							label="Amount"
                            name="amount"
                            autoComplete="amount"
							value={amount}
							onChange={handleChangeAmount}
							endadornment={<InputAdornment position="end">{asset.name}</InputAdornment>}
						/>
					</Grid>
					<Grid item xs={3}></Grid>
					<Grid item xs={3}>
						
					</Grid>
				</Grid>
				
			</Box>
            </DialogContent>
            <DialogActions>
                <Button variant="outlined" color="primary" onClick={handleClose}>Close</Button>
                <Button onClick={handleSendToken} variant="contained" endIcon={<SendIcon />}>
					Send
				</Button>
            </DialogActions>			


        </Dialog>

    );
}

export default ModalSendToken;