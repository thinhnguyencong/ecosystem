import React, { useState } from 'react';
import { Dialog } from '@mui/material';
import DialogTitle from '@mui/material/DialogTitle';
import DialogActions from '@mui/material/DialogActions';
import DialogContent from '@mui/material/DialogContent';
import Button from '@mui/material/Button';
import TextField from '@mui/material/TextField';
import Grid from '@mui/material/Grid';
import Box from '@mui/material/Box';
function ModalAddToken(props) {
    const { open } = props;
    const [state, setState] = useState({})
    const { address, name, decimal } = state
    const handleAddToken = (event) => {
        let data = {
            address: address,
            name: name,
            decimal: decimal
        }
        props.handleAddToken(data)
    }
    const handleChangeAddress = (e) => {
        setState({
            ...state,
            address: e.target.value
        })
    }
    const handleChangeName = (e) => {
        setState({
            ...state,
            name: e.target.value
        })
    }
    const handleChangeDecimal = (e) => {
        setState({
            ...state,
            decimal: e.target.value
        })
    }


    const handleClose = () => {
        props.handleClose()
    }
    return (
        <Dialog open={open} onClose={handleClose} sx={{}}>
            <DialogTitle>Add new Token</DialogTitle>
            <DialogContent>
                <Box pl={4}>
                    <Grid
                        container
                        direction="column"
                    >
                        {/* Address */}
                        <Grid item xs={6}>
                            <TextField
                                onChange={handleChangeAddress}
                                margin="normal"
                                required
                                id="address"
                                label="Address"
                                name="address"
                                autoComplete="address"
                                autoFocus
                            />
                        </Grid>
                        {/* Name */}
                        <Grid item xs={6}>
                            <TextField
                                onChange={handleChangeName}
                                margin="normal"
                                required
                                id="name"
                                label="Name"
                                name="name"
                                autoComplete="name"
                            />
                        </Grid>
                        {/* Decimal */}
                        <Grid item xs={6}>
                            <TextField
                                onChange={handleChangeDecimal}
                                margin="normal"
                                required
                                id="decimal"
                                label="Decimal"
                                name="decimal"
                                autoComplete="decimal"
                            />
                        </Grid>



                    </Grid>

                </Box>
            </DialogContent>
            <DialogActions>
                <Button variant="outlined" color="primary" onClick={handleClose}>Close</Button>
                <Button variant="contained" color="primary" onClick={handleAddToken}>Add</Button>
            </DialogActions>



        </Dialog>
    );
}

export default ModalAddToken;