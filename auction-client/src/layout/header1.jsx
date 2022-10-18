import * as React from 'react';
import PropTypes from 'prop-types';
import AppBar from '@mui/material/AppBar';
import Box from '@mui/material/Box';
import Divider from '@mui/material/Divider';
import Drawer from '@mui/material/Drawer';
import IconButton from '@mui/material/IconButton';
import List from '@mui/material/List';
import ListItem from '@mui/material/ListItem';
import ListItemButton from '@mui/material/ListItemButton';
import ListItemText from '@mui/material/ListItemText';
import MenuIcon from '@mui/icons-material/Menu';
import Toolbar from '@mui/material/Toolbar';
import Typography from '@mui/material/Typography';
import Button from '@mui/material/Button';
import Menu from '@mui/material/Menu';
import MenuItem from '@mui/material/MenuItem';
import ListItemIcon from '@mui/material/ListItemIcon';
import Avatar from '@mui/material/Avatar';
import Tooltip from '@mui/material/Tooltip';
import Logout from '@mui/icons-material/Logout';
import { logout } from '../services/auth/authSlice';
import { useHistory } from 'react-router-dom';
import { useDispatch, useSelector } from 'react-redux';
import { Grid, Link } from '@mui/material';

const drawerWidth = 240;
const navItems = [
	{name: "Home", link: "/"},
	{name: "Marketplace", link: "/marketplace"},
	{name: "Auction List", link: "/auction-list"} 
];

function DrawerAppBar(props) {
	const history = useHistory()
	const dispatch= useDispatch()
  const { window } = props;
  const [mobileOpen, setMobileOpen] = React.useState(false);
  const authSelector = useSelector((state) => state.auth)
  const [anchorEl, setAnchorEl] = React.useState(null);
  const anchorOpen = Boolean(anchorEl);
  const handleClick = (event) => {
	  setAnchorEl(event.currentTarget);
  };
  const handleClose = () => {
	  setAnchorEl(null);
  };
const handleLogout = () => {
	  dispatch(logout())
	  history.push("/login")
  }
  const handleDrawerToggle = () => {
	setMobileOpen(!mobileOpen);
  };

  const drawer = (
	<Box onClick={handleDrawerToggle} sx={{ textAlign: 'center' }}>
	  <Typography variant="h6" sx={{ my: 2 }}>
		MUI
	  </Typography>
	  <Divider />
	  <List>
		{navItems.map((item, index) => (
		  <ListItem key={index} disablePadding>
			<ListItemButton sx={{ textAlign: 'center' }}>
			  <ListItemText primary={item.name} />
			</ListItemButton>
		  </ListItem>
		))}
	  </List>
	</Box>
  );

  const container = window !== undefined ? () => window().document.body : undefined;

  return (
	<Box sx={{ display: 'flex', boxSizing: "border-box" }}>
	  	<AppBar style={{backgroundColor: "#002368", height: "10%"}} component="nav">
			<Toolbar>
				<Grid container>
					<Grid item xs={2} alignSelf="center">
						<IconButton
							color="inherit"
							aria-label="open drawer"
							edge="start"
							onClick={handleDrawerToggle}
							sx={{ mr: 2, display: { sm: 'none' } }}
						>
							<MenuIcon />
						</IconButton>
						{/* <Typography
							variant="h6"
							component="div"
							sx={{ flexGrow: 1, display: { xs: 'none', sm: 'block' } }}
						>
							MUI
						</Typography> */}
					</Grid>
					<Grid item xs={9} alignSelf="center" sx={{ display: { xs: 'none', sm: 'block' } }}>
						<ul className="flex lg:flex-row list-none w-full bg-primary-color lg:justify-center">
							{navItems.map((item, index) => (
								<li className="flex items-center mr-6 mb:divider-border-bottom sm:divider-border-bottom" key={index}>
									<a
										href={item.link}
										target="_blank"
										className="hover:bg-blue-light text-white flex px-3 py-4 min-width-200px rounded-lg items-center text-2xl uppercase font-bold"
									>
										<p className="text-white text-xl font-evil  letter-spacing-base uppercase">{item.name}</p>
									</a>
								</li>
						))}
						</ul>
							
						{/* // <Link key={index} href={item.link} underline="none">
						// 	<Button  
						// 		sx={{
						// 			':hover': {
						// 				bgcolor: 'info.light',
						// 				color: 'white',
						// 			},
						// 			margin: 0,
						// 			padding: "10px"
						// 		}} 
						// 		key={index}
						// 	>
								
						// 			<Box sx={{ fontFamily: 'Monospace', fontSize: 'h5.fontSize', color:"white" }}>
						// 				{item.name}
						// 			</Box>
								
						// 	</Button>
						// </Link> */}
					
					</Grid>
					<Grid item xs={9} alignSelf="center" sx={{ display: { xs: 'block', sm: 'none' } }}></Grid>
					<Grid item xs={1} alignSelf="center" justifyContent="flex-end">
						<Box display="flex" justifyContent="flex-end">
							<div style={{alignContent: "center"}}></div>{authSelector.user?.username}
							<Tooltip title="Account settings">
								<IconButton onClick={handleClick} size="small" sx={{ ml: 2 }}>
									<Avatar sx={{ width: 32, height: 32 }}>W</Avatar>
								</IconButton>
							</Tooltip>
						</Box>
						<Menu
							anchorEl={anchorEl}
							open={anchorOpen}
							onClose={handleClose}
							onClick={handleClose}
							PaperProps={{
								elevation: 0,
								sx: {
									overflow: 'visible',
									filter: 'drop-shadow(0px 2px 8px rgba(0,0,0,0.32))',
									mt: 1.5,
									'& .MuiAvatar-root': {
										width: 32,
										height: 32,
										ml: -0.5,
										mr: 1,
									},
									'&:before': {
										content: '""',
										display: 'block',
										position: 'absolute',
										top: 0,
										right: 14,
										width: 10,
										height: 10,
										bgcolor: 'background.paper',
										transform: 'translateY(-50%) rotate(45deg)',
										zIndex: 0,
									},
								},
							}}
							transformOrigin={{ horizontal: 'right', vertical: 'top' }}
							anchorOrigin={{ horizontal: 'right', vertical: 'bottom' }}
						>
							<MenuItem>
								<Avatar /> {authSelector.user?.name}
							</MenuItem>
							<MenuItem onClick={handleLogout}>
								<ListItemIcon>
									<Logout fontSize="small" />
								</ListItemIcon>
								Logout
							</MenuItem>
						</Menu>
					</Grid>
				</Grid>
				
				{/* <Box sx={{ display: { xs: 'none', sm: 'block' }, margin: "auto" }}>
					
				</Box> */}
				{/* <Typography
					variant="h6"
					component="div"
					sx={{ flexGrow: 1, display: { xs: 'none', sm: 'block' } }}
				>
				</Typography> */}
				
			</Toolbar>
	  	</AppBar>
	  <Box component="nav">
		<Drawer
		  container={container}
		  variant="temporary"
		  open={mobileOpen}
		  onClose={handleDrawerToggle}
		  ModalProps={{
			keepMounted: true, // Better open performance on mobile.
		  }}
		  sx={{
			display: { xs: 'block', sm: 'none' },
			'& .MuiDrawer-paper': { boxSizing: 'border-box', width: drawerWidth },
		  }}
		>
		  {drawer}
		</Drawer>
	  </Box>
	</Box>
  );
}

DrawerAppBar.propTypes = {
  /**
   * Injected by the documentation to work in an iframe.
   * You won't need it on your project.
   */
  window: PropTypes.func,
};

export default DrawerAppBar;
