import ListItem from "@mui/material/ListItem"
import ListItemText from "@mui/material/ListItemText"
import ListItemIcon from '@mui/material/ListItemIcon';
import React from "react"
import { Link } from "react-router-dom"
import { useLocation } from "react-router-dom"
import { useSelector } from "react-redux";

function CustomListItem(props) {
    const location = useLocation()
    return (
        <React.Fragment key={props.to}>
            <ListItem
                button
                component={Link}
                to={props.to}
                selected={props.to === location.pathname}
            >
                <ListItemIcon>{props.icon}</ListItemIcon>
                <ListItemText primaryTypographyProps={{ fontSize: '16px' }} primary={props.primary} />
            </ListItem>
        </React.Fragment>

    )
    // }

}
export default CustomListItem