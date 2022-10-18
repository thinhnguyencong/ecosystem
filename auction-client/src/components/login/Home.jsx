import React, { useEffect, useState } from 'react';
import { useHistory } from 'react-router-dom';
import { useDispatch, useSelector } from 'react-redux';
import Jazzicon, { jsNumberForAddress } from 'react-jazzicon'
import Box from "@mui/material/Box";
import List from '@mui/material/List';
import ListItem from '@mui/material/ListItem';
import ListItemText from '@mui/material/ListItemText';
import ListItemAvatar from '@mui/material/ListItemAvatar';
import Avatar from '@mui/material/Avatar';
import Button from '@mui/material/Button';
import IconButton from '@mui/material/IconButton';
import SendIcon from '@mui/icons-material/Send';
import DeleteIcon from '@mui/icons-material/Delete';
import { addAsset, getUserInfo, getAsset, removeAsset, transferToken, exportPrivateKey } from '../../services/user/userSlice';
import { Link, Paper } from '@mui/material';
import ModalSendToken from '../wallet/modalSendToken';
import Tab from '@mui/material/Tab';
import TabContext from '@mui/lab/TabContext';
import TabList from '@mui/lab/TabList';
import TabPanel from '@mui/lab/TabPanel';
import ModalAddToken from '../wallet/modalAddToken';

 
function Home(props) {
	const dispatch = useDispatch()
	const [value, setValue] = useState('1');
	const [isOpen, setIsOpen] = useState(false)
	const [assets, setAssets] = useState([])
	const [isOpenModalAddToken, setIsOpenModalAddToken] = useState(false)
	const [user, setUser] = useState({})
	const userSelector = useSelector((state) => state.user)

	useEffect(() => {
		dispatch(getUserInfo())
		dispatch(getAsset())
	}, [])

	useEffect(() => {
		setUser({
			...user,
			publicAddress: userSelector.publicAddress,
			balance: userSelector.balance,
		})
	}, [JSON.stringify(userSelector)])

	useEffect(() => {
		setAssets(userSelector.assets)
	}, [JSON.stringify(userSelector.assets)])

	const handleOpenModalSend = () => {
		setIsOpen(!isOpen)
	}

	const handleRemoveToken = (address) => {
		dispatch(removeAsset(address))
		dispatch(getUserInfo())
	}

	const handleChange = (event, newValue) => {
		setValue(newValue);
	};

	const handleOpenModalAddToken = () => {
        setIsOpenModalAddToken(!isOpenModalAddToken)
    }

	const handleAddToken = (data) => {
		dispatch(addAsset(data))
		dispatch(getUserInfo())
		setIsOpenModalAddToken(!isOpenModalAddToken)
	}
	const handleSendToken = (data) => {
		dispatch(transferToken(data))
		setIsOpen(!isOpen)
	}
	const handleExportPrivateKey = (password) => {
		dispatch(exportPrivateKey())
	}
	return (
		<React.Fragment>
			<Paper elevation={3} sx={{mt: 15, ml: 3,mr: 3}}>
				{user?.publicAddress ? 
						<Box textAlign={"center"} fontSize={20}>{user.publicAddress}</Box>
					: ""
				}
				{user?.balance ? 
					<div>
						<Box textAlign={"center"} fontSize={20} sx={{ fontWeight: 'bold', m: 1 }}> 
							{Math.round(user.balance*10000)/10000} &nbsp;TBNB
						</Box>
						<Box textAlign={"center"} fontSize={20}>
							<Jazzicon diameter={30} seed={jsNumberForAddress(value)} />
						</Box>
					
					</div>
					
					: ""
				}
				<Box textAlign={"center"}>
					<Button onClick={handleOpenModalSend} variant="contained" endIcon={<SendIcon />}>
						Send
					</Button>
					<ModalSendToken open={isOpen} handleClose={handleOpenModalSend} handleSendToken={handleSendToken}/>
				</Box>
				<Box sx={{ width: '100%', typography: 'body1' }}>
					<TabContext value={value}>
						<Box sx={{ borderBottom: 1, borderColor: 'divider' }}>
						<TabList  variant="fullWidth" onChange={handleChange} aria-label="lab API tabs example">
							<Tab label="Assets" value="1" />
							<Tab label="Activity" value="2" />
						</TabList>
						</Box>
						<TabPanel value="1">
							<List sx={{ width: '100%', bgcolor: 'background.paper' }}>
								{assets.map((asset, index) => (
									<ListItem 
										key={index} 
										secondaryAction={
											<IconButton onClick={() => handleRemoveToken(asset.address)} edge="end" aria-label="delete">
												<DeleteIcon />
											</IconButton>
										}
									>
										<ListItemAvatar>
											<Avatar>
												<Jazzicon diameter={40} seed={jsNumberForAddress(asset.address)} />
											</Avatar>
										</ListItemAvatar>
										<ListItemText primary={ asset.amount + " " + asset.name} />
									</ListItem>
								))}
							</List>
							<Link  
								component="button"
								variant="h6"  
								onClick={() => handleOpenModalAddToken()}
							>
								Import token
							</Link>
							<br />
							<Link  
								component="button"
								variant="h6"  
								onClick={handleExportPrivateKey}
							>
								Export Private Key
							</Link>
						</TabPanel>
						<TabPanel value="2">Item Two</TabPanel>
					</TabContext>
				</Box>
			</Paper>
			{userSelector?.privateKey ? <p>{userSelector.privateKey}</p> : "" }
			<ModalAddToken open={isOpenModalAddToken} handleClose={handleOpenModalAddToken} handleAddToken={handleAddToken} />
		</React.Fragment>
	   
	);
}

export default Home;